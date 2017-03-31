function Image_Denoising_Test_Custom(Im, param)
% Run synthetic denoising tests using neveral methods.
% noiseSig is the standard deviation of the noise

% Read image
trueIm = double(Im);

param.groundTruthData.groundTruthIm = trueIm;

figure; imshow(trueIm , []);   title('ground truth image' );

noiseSig = param.noiseSig;

% Add noise
noisyIm = Add_Noise_To_Image(trueIm , noiseSig, 1);
noisyPSNR = Compute_Error_Stats(trueIm , noisyIm);
figure; imshow(noisyIm , []); title(sprintf('noisy image  : %02.2f dB' ,noisyPSNR) );

%======================================================

% Run denoising with a fixed dictionary without overlaps
disp('Applying the local patch-based image denoising algorithm with DCT  and no overlaps');
DCTdict = Build_DCT_Overcomplete_Dictionary(param.nAtoms , param.patchSize);
ResIm_NoOverlap = Image_Denoising_Patches(noisyIm , DCTdict , param);
resDCTPSNR = Compute_Error_Stats(trueIm , ResIm_NoOverlap);
figure; imshow(ResIm_NoOverlap , []);   title(sprintf('DCT, no overlap : %02.2f dB' ,resDCTPSNR) );
disp(['     PSNR = ',num2str(resDCTPSNR)]);
disp('   ');

% Run denoising with a fixed dictionary with overlaps
disp('Applying the local patch-based image denoising algorithm with DCT  with overlaps');
DCTdict = Build_DCT_Overcomplete_Dictionary(param.nAtoms , param.patchSize);
ResIm_WithOverlap = Image_Denoising_Patches_Overlap(noisyIm , DCTdict , param);
resDCToverlapPSNR = Compute_Error_Stats(trueIm , ResIm_WithOverlap);
figure; imshow(ResIm_WithOverlap , []);   title(sprintf('DCT, with overlap : %02.2f dB' ,resDCToverlapPSNR) );
disp(['     PSNR = ',num2str(resDCToverlapPSNR)]);
disp('   ');

% Run denoising with K-SVD learning and overlaps
disp('Applying the local patch-based image denoising algorithm with K-SVD and overlaps');
ResIm_Trained = Image_Denoising_Trained_Dictionary(noisyIm , param);
resTrainedPSNR = Compute_Error_Stats(trueIm , ResIm_Trained);
figure; imshow(ResIm_Trained , []);   title(sprintf('With trained dictionary : %02.2f dB' ,resTrainedPSNR) );
disp(['     PSNR = ',num2str(resTrainedPSNR)]);
disp('   ');

return;

