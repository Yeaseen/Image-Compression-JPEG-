I = imread('mars.png');
display('Original Image Size in Bit');
ImageSize = 8*prod(size(I))

Y_d =rgb2ycbcr( I );
% Downsample:
Y_d(:,:,2) = 2*round(Y_d(:,:,2)/2);
Y_d(:,:,3) = 2*round(Y_d(:,:,3)/2);




% DCT compress:
Y_d=int8(Y_d)-128;
blockSize=8;
jump=7;
B = zeros(size(Y_d));
Bq = B;
for channel = 1:3
    for i = 1:8:size(Y_d,1)-7
        for j = 1:8:size(Y_d,2)
            B(i:i+jump,j:j+jump,channel) = dct2(Y_d(i:i+jump,j:j+jump,channel));
            Bq(i:i+jump,j:j+jump,channel)=quantization(B(i:i+jump,j:j+jump,channel),blockSize);
        end
    end
end

rowSize=size(Bq,1);
colSize=size(Bq,2);


ZgZag1 = zigzagMy(Bq(:,:,1));
ZgZag2 = zigzagMy(Bq(:,:,2));
ZgZag3 = zigzagMy(Bq(:,:,3));


j=1;
      a=length(ZgZag1);
      count=0;
      for n=1:a
       b=ZgZag1(n);
       if n==a
       count=count+1;
       Z1c(j)=count;
       Z1s(j)=ZgZag1(n);
       elseif ZgZag1(n)==ZgZag1(n+1)
       count=count+1;
       elseif ZgZag1(n)==b
       count=count+1;
       Z1c(j)=count;
       Z1s(j)=ZgZag1(n);
       j=j+1;
       count=0;
       end
      end

      c1=length(Z1c);
      s1=length(Z1s);
      


j=1;
      a=length(ZgZag2);
      count=0;
      for n=1:a
       b=ZgZag2(n);
       if n==a
       count=count+1;
       Z2c(j)=count;
       Z2s(j)=ZgZag2(n);
       elseif ZgZag2(n)==ZgZag2(n+1)
       count=count+1;
       elseif ZgZag2(n)==b
       count=count+1;
       Z2c(j)=count;
       Z2s(j)=ZgZag2(n);
       j=j+1;
       count=0;
       end
      end

      c2=length(Z2c);
      s2=length(Z2s);
      


      
j=1;
      a=length(ZgZag3);
      count=0;
      for n=1:a
       b=ZgZag3(n);
       if n==a
       count=count+1;
       Z3c(j)=count;
       Z3s(j)=ZgZag3(n);
       elseif ZgZag3(n)==ZgZag3(n+1)
       count=count+1;
       elseif ZgZag3(n)==b
       count=count+1;
       Z3c(j)=count;
       Z3s(j)=ZgZag3(n);
       j=j+1;
       count=0;
       end
      end

      c3=length(Z3c);
      s3=length(Z3s);
      
      
  OutputBitcost=(c1*8)+(s1*8)+(c2*8)+(s2*8)+(c3*8)+(s3*8);  
  display('Compressed Image Size in Bit');
  display(OutputBitcost);

  
  g1=length(Z1s);
      j=1;
      l=1;
      for i=1:g1
       v1(l)=Z1s(j);
       if Z1c(j)~=0
       w=l+Z1c(j)-1;
       for p=l:w
       v1(l)=Z1s(j);
       l=l+1;
       end
       end
       j=j+1;
      end
      invrlc1=v1;
      
   
  
   g2=length(Z2s);
      j=1;
      l=1;
      for i=1:g2
       v2(l)=Z2s(j);
       if Z2c(j)~=0
       w=l+Z2c(j)-1;
       for p=l:w
       v2(l)=Z2s(j);
       l=l+1;
       end
       end
       j=j+1;
      end
      invrlc2=v2;

  g3=length(Z3s);
      j=1;
      l=1;
      for i=1:g3
       v3(l)=Z3s(j);
       if Z3c(j)~=0
       w=l+Z3c(j)-1;
       for p=l:w
       v3(l)=Z3s(j);
       l=l+1;
       end
       end
       j=j+1;
      end
      invrlc3=v3;
   
  


Bqnew(:,:,1)=invzigzagMy(invrlc1,rowSize,colSize);
Bqnew(:,:,2)=invzigzagMy(invrlc2,rowSize,colSize);
Bqnew(:,:,3)=invzigzagMy(invrlc3,rowSize,colSize);

Bnew=zeros(size(Bqnew));
ASnew=Bnew;
for channel = 1:3
    for i = 1:8:size(Y_d,1)-7
        for j = 1:8:size(Y_d,2)
            Bnew(i:i+jump,j:j+jump,channel) = invQuantization(Bqnew(i:i+jump,j:j+jump,channel),blockSize);
            ASnew(i:i+jump,j:j+jump,channel)=round(idct2(Bnew(i:i+jump,j:j+jump,channel)));
        end
    end
end


ASnew=ASnew+128;

subplot(1,2,1)
imshow(I)
title('Original')
subplot(1,2,2)
imshow(ycbcr2rgb(uint8(ASnew)));
title('Reconstructed Image')

[peaksnr, snr] = psnr(I, ycbcr2rgb(uint8(ASnew)));
display(peaksnr);
