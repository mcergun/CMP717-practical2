% Main Program

% Denoising

Im=imread('barbara.png');

%% Parameters are set here
% various parameters
param.patchSize = [8 8];

% OMP param
param.errorGoal = 1.15;
param.noiseSig = 20;

% Dictionary training param
param.method = 'KSVD';
% param.method = 'MOD';

param.nAtoms = 100;

param.nIterations = 5;
param.useLessAtoms = [0.1 0.1 0.2 0.2 0.4 0.4 0.7 0.7 1 1 1 1 1 1 1];

param.initType = 'RandomPatches'; 
param.initType = 'DCT'; 
%  param.initType = 'Input'; 

param.groundTruthData.patchSize = param.patchSize;

%% Test is run here
Image_Denoising_Test_Custom(Im, param);