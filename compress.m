rgbImage=imread('img.jpg');
%{
R = rgbImage(:, :, 1);
G = rgbImage(:, :, 2);
B = rgbImage(:, :, 3);

Y=0.299*R + 0.587*G +0.114*B;
Cb= 0.564*(B-Y);
Cr= 0.713*(R-Y);



YCbCrres= rgb2ycbcr(rgbImage);

Y=YCbCrres(:,:,1);

Cb=YCbCrres(:,:,2);

Cr=YCbCrres(:,:,3);


redChannel= Y + 1.402*Cr;
greenChannel= Y - 0.344*Cb - 0.714*Cr;
blueChannel= Y + 1.772*Cb;
%}

redChannel = rgbImage(:, :, 1);
greenChannel = rgbImage(:, :, 2);
blueChannel = rgbImage(:, :, 3);

AnewwR=encDecResult(redChannel);
AnewwG=encDecResult(greenChannel);
AnewwB=encDecResult(blueChannel);

reImage = cat(3, AnewwR, AnewwG, AnewwB);

subplot(1,2,1);
imshow(rgbImage);
title('Original Image');
subplot(1,2,2);
imshow(reImage);
title('Reconstructed Image');