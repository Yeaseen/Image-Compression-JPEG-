function res=encDecResult(inp)

AS=inp;
rowSize=size(AS,1);
colSize=size(AS,2);
s=int8(AS)-128;
B=[];
Bq=[];


blockSize=8;
jump=7;

for i=1:blockSize:rowSize
     for j=1:blockSize:colSize 
        %performing the DCT
        B(i:i+jump,j:j+jump) = dct2(s(i:i+jump,j:j+jump));
        %performing the quantization
        Bq(i:i+jump,j:j+jump)=quantization(B(i:i+jump,j:j+jump),blockSize);
     end
end

rowSize=size(Bq,1);
colSize=size(Bq,2);


ZgZag = zigzagMy(Bq);






Bqnew=invzigzagMy(ZgZag,rowSize,colSize);


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


Aneww=ASnew+128;

Aneww=uint8(Aneww);

res=Aneww;
end
