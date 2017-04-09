% Main Program
close all;

% Denoising

filenames = {'../barbara.png' '../foreman.tif' '../peppers256.png'};
image_count = max(size(filenames));

%% Parameters are set here
% various parameters
% OMP param
param.errorGoal = 1.15;

% Dictionary training param
param.method = 'KSVD';
% param.method = 'MOD';


% parameter is changed to 8 because it is a sweet spot for
% calculation time / performance gain
param.nIterations = 8;
param.useLessAtoms = [0.1 0.1 0.2 0.2 0.4 0.4 0.7 0.7 1 1 1 1 1 1 1];

param.initType = 'RandomPatches';
param.initType = 'DCT';
param.externalTrain = 0;
%  param.initType = 'Input';

%% Test is run here
results_PSNR = zeros(image_count, 4);
size(results_PSNR)
results_img = cell(1, image_count);

for patch_size = 8
    for sigma = 5:5:60
        for atoms = 8:12
            param.noiseSig = sigma;
            param.nAtoms = atoms^2;
            param.patchSize = [patch_size patch_size];
            param.groundTruthData.patchSize = param.patchSize;
            
            for i=1:image_count
                img = imread(filenames{i});
                [local_PSNRs, local_imgs] = Image_Denoising_Test_Custom(img, param);
                results_img(i) = {local_imgs};
                results_PSNR(i, :) = local_PSNRs;
            end
            
            folder_path = sprintf('../results/sigma%datoms%dsize%d/', param.noiseSig, ...
                param.nAtoms, param.patchSize(1));
            
            mkdir(folder_path);
            
            save(strcat(folder_path, 'img.mat'), 'results_img');
            save(strcat(folder_path, 'PSNR.mat'), 'results_PSNR');
        end
    end
end
