function [results_PSNR, results_img] = gather_results( folder_path )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here

path_psnr = fullfile(folder_path, 'PSNR.mat');
path_img = fullfile(folder_path, 'img.mat');

load(path_psnr);
load(path_img);

end

