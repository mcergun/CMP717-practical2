% Main Program
close all;

% Denoising

filenames = {'barbara.png' 'foreman.tif' 'peppers256.png'};
image_count = max(size(filenames));

%% Parameters are set here
% various parameters
param.patchSize = [8 8];

% OMP param
param.errorGoal = 1.15;
param.noiseSig = 100;

% Dictionary training param
param.method = 'KSVD';
% param.method = 'MOD';

param.nAtoms = 100;

% parameter is changed to 8 because it is a sweet spot for 
% calculation time / performance gain
param.nIterations = 8;
param.useLessAtoms = [0.1 0.1 0.2 0.2 0.4 0.4 0.7 0.7 1 1 1 1 1 1 1];

param.initType = 'RandomPatches'; 
param.initType = 'DCT'; 
%  param.initType = 'Input'; 

param.groundTruthData.patchSize = param.patchSize;

%% Test is run here
results_PSNR = zeros(image_count, 4);
size(results_PSNR)
results_img = cell(1, image_count);
for i=1:image_count
    close all;
    img = imread(filenames{i});
    [local_PSNRs, local_imgs] = Image_Denoising_Test_Custom(img, param);
    results_img(i) = {local_imgs};
    results_PSNR(i, :) = local_PSNRs;
end

folder_path = sprintf('results/sigma%datoms%dsize%d/', param.noiseSig, ...
    param.nAtoms, param.patchSize(1));

mkdir(folder_path);

save(strcat(folder_path, 'img.mat'), 'results_img');
save(strcat(folder_path, 'PSNR.mat'), 'results_PSNR');