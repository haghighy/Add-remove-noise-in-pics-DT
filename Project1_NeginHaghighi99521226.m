% Negin Haghighi - 99521226
clear, clc;

% Position of figure
set(gcf, 'Position',  [100, 40, 900, 600])
% reading image
pic = imread('flower.jpg');
subplot(2,3,1), imshow(pic), title('<First pic>'); 
% Convert to grayscale
grayPic = rgb2gray(pic);
subplot(2,3,2), imshow(grayPic), title('<Grayscale Pic>'); 

imwrite(grayPic, 'gray_pic.png');

% Energy of gray pic
energy = sum(grayPic(:));
fprintf('The energy of gray phote = %d\n', energy);

% Noise
gaussian_pic = imnoise(grayPic, 'gaussian', 0, 0.03);
imwrite(gaussian_pic, 'gaussian_pic.png');
subplot(2,3,3), imshow(gaussian_pic), title('<Grayscale gaussian noise>'); 

pic_snr = snr(double(grayPic(:)), double(grayPic(:)) - double(grayPic(:)));
fprintf('this is <before> snr: %d\n', pic_snr);

pic_snr2 = snr(double(grayPic(:)), double(grayPic(:)) - double(gaussian_pic(:)));
fprintf('this is <after> snr: %d\n', pic_snr2);

% Frequency domain
freqdomain = fftshift(log(abs(fft2(gaussian_pic))));
subplot(2,3,4), imshow(freqdomain, []), title('<Gaussian in Freq>'); 

X=ones(5,5)/25;
method1_pic=imfilter(gaussian_pic, X);
subplot(2,3,5), imshow(method1_pic), title('<Average filter method>'); 
imwrite(method1_pic, 'method1_pic.png');

method2_pic=medfilt2(gaussian_pic);
subplot(2,3,6), imshow(method2_pic), title('<Median filter method>'); 
imwrite(method2_pic, 'img2.png');

% Method1 psnr:
[psnr1, snr1] = psnr(gaussian_pic, method1_pic);
fprintf('\n Average filter psnr: %0.3f', psnr1);
% Method2 psnr:
[psnr2, snr2] = psnr(gaussian_pic, method2_pic);
fprintf('\n median filter psnr: %0.3f', psnr2);
