close all
clear all
clc

cd('.');

folder_path = 'sigma5atoms144size8';

[results_PSNR, results_img] = gather_results(folder_path);

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
