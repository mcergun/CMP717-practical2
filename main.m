% Main Program
close all;

% Denoising

filenames = {'barbara.png'; 'foreman.tif'; 'peppers256.png'};
image_count = size(filenames);

%% Parameters are set here
% various parameters
param.patchSize = [8 8];

% OMP param
param.errorGoal = 1.15;
param.noiseSig = 50;

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
    
for i=1:image_count
    img = imread(filenames{i});
    [results_PSNR, results_img] = Image_Denoising_Test_Custom(img, param);
end