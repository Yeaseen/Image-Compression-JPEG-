rgbImage=imread('img.jpg');

YCbCrres= rgb2ycbcr(rgbImage);

Y=YCbCrres(:,:,1);

Cb=YCbCrres(:,:,2);

Cr=YCbCrres(:,:,3);

redChannel= Y + 1.402*Cr;
greenChannel= Y - 0.344*Cb - 0.714*Cr;
blueChannel= Y + 1.772*Cb;


subplot(1,4,1);
imshow(rgbImage);
title('Original Image');
subplot(1,4,2);
imshow(Y);
title('Y');
subplot(1,4,3);
imshow(Cb);
title('Cb');
subplot(1,4,4);
imshow(Cr);
title('Cr');