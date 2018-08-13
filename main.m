
ImageArray=[20,20,20,17,0,0,0,0,11,0,-10,-5,0,0,1,0,0,0];


%starting of RLEncoding
display(ImageArray);
j=1;
      a=length(ImageArray);
      count=0;
      for n=1:a
       b=ImageArray(n);
       if n==a
       count=count+1;
       c(j)=count;
       s(j)=ImageArray(n);
       elseif ImageArray(n)==ImageArray(n+1)
       count=count+1;
       elseif ImageArray(n)==b
       count=count+1;
       c(j)=count;
       s(j)=ImageArray(n);
       j=j+1;
       count=0;
       end
      end
 % Calculation Bit Cost
      z=a*8;
      display(z);
      c1=length(c);
      s1=length(s);
      OutputBitcost= (c1*8)+(s1*8);
      OutputBitcost=(OutputBitcost);
      display(OutputBitcost);
      
      
 % starting RLDecoding 
       
      g=length(s);
      j=1;
      l=1;
      for i=1:g
       v(l)=s(j);
       if c(j)~=0
       w=l+c(j)-1;
       for p=l:w
       v(l)=s(j);
       l=l+1;
       end
       end
       j=j+1;
      end
      ReconstructedImageArray=v;
      display(ReconstructedImageArray);
      
      
      