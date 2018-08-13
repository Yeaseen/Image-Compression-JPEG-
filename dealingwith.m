function Anew=imgreader(x)
%reading the image
A=imread('Kodak21.bmp');

%get the number of pixels
[rows,columns] = size(A);
disp('No of pixels')
Number_Pixels = rows*columns

%convert it to grayscale
%AS=rgb2gray(A);
AS=[];
AS=A;

%get the row and col size
rowSize=size(AS,1)
colSize=size(AS,2)

%subtract the bytes from the image
s=int16(AS)-128;
B=[];
Bq=[];
count=1;


blockSize=input('Enter 8 to encode using 8X8 or 16 to use 16X16 : ')
jump=0;
zzcount=0;
if blockSize==8
    jump=7;
    zzcount=64;
    printLimit=8;
else
    jump=15;
    zzcount=256;
    printLimit=16;
end

%encoding process
for i=1:blockSize:rowSize
     for j=1:blockSize:colSize 
        %performing the DCT
        B(i:i+jump,j:j+jump) = dct2(s(i:i+jump,j:j+jump));
        %performing the quantization
        Bq(i:i+jump,j:j+jump)=quantization(B(i:i+jump,j:j+jump),blockSize);
        %zigzag(count,1:zzcount)=zzag(Bq(i:i+jump,j:j+jump));
        %count=count+1;
     end
end

ZgZag=zigzag(Bq);

Bqnew=[];
Bqnew=invzigzag(ZgZag,rowSize,colSize);

Bnew=[];
ASnew=[];

%decoding process
for i=1:blockSize:rowSize
     for j=1:blockSize:colSize 
        %performing the dequantization
        Bnew(i:i+jump,j:j+jump)=invQuantization(Bqnew(i:i+jump,j:j+jump),blockSize);
        %performing the inverse DCT
        ASnew(i:i+jump,j:j+jump) = round(idct2(Bnew(i:i+jump,j:j+jump)));
     end
end

disp('dequantization');
%Bnew(1:printLimit,1:printLimit)
disp('Inverse DCT')
%ASnew(1:printLimit,1:printLimit)




disp('final');
Aneww=[];
Aneww=ASnew+128;

Aneww=uint8(Aneww);

rgbImage = cat(3,Aneww,Aneww,Aneww);
subplot(1,2,1);
imshow(A);
title('Original Image');
subplot(1,2,2);
imshow(rgbImage);
title('Reconstructed Image');
disp('error value')
%error=abs(sum(sum(imsubtract(A,rgbImage).^2)))/Number_Pixels;
%ee=error;
%disp(ee);

end



        
