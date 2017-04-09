% Main Program
% close all;

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
param.externalTrain = 1;
param.externalTrainPath = '../data';
%  param.initType = 'Input';

%% Test is run here
results_PSNR = zeros(image_count, 4);
size(results_PSNR)
results_img = cell(1, image_count);

patch_size = [8 8];
sigma = 20;
atoms = 100;
param.noiseSig = sigma;
param.nAtoms = atoms;
param.patchSize = patch_size;
param.groundTruthData.patchSize = param.patchSize;
img = imread(filenames{1});
[local_PSNRs, local_imgs] = Image_Denoising_Test_Custom(img, param);
