close all
clear all
clc

cd('.');

folder_path = 'sigma100atoms100size8';

load(strcat(folder_path, '/PSNR.mat'));
load(strcat(folder_path, '/img.mat'));

image_count = size(results_PSNR, 1);

for i=1:image_count
    imageset = uint8(results_img{i});
    figure
    for j=1:4
        subplot(2, 2, j)
        imshow(imageset(:, :, j))
        title(sprintf('PSNR %f', results_PSNR(i, j)));
    end
end

% im1 = uint8(im(:, :, 4));
% 
% subimage(im1)
% subimage(im1)