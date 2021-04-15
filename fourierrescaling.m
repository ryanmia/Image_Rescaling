clear all;close all;clc;

img=imread("img.png");
img=img(:,:,1);

xscale=15;
yscale=10;
bigger=rescaleFourier(img,xscale,yscale);

figure
image(img)
colormap(gray(255));
figure
image(abs(bigger))
colormap(gray(255));
bigger= uint8(bigger);
imwrite(bigger,"img_fourier_2x3.png");

function bigger=rescaleFourier(img,xscale,yscale)
    [yscale, xscale]=deal(xscale,yscale);
    [x,y]=size(img);
    imgFFT=fft2(img);
    %this is x
    biggerFFT=zeros(size(imgFFT,1)*xscale,size(imgFFT,2));
    biggerFFT(1:size(imgFFT,1)/2,:)=imgFFT(1:size(imgFFT,1)/2,:);
    biggerFFT(size(biggerFFT,1)-size(imgFFT,1)/2:end,:)=imgFFT(size(imgFFT,1)/2:end,:);
    %this is y
    fullFFT=zeros(size(imgFFT,1)*xscale,size(imgFFT,2)*yscale);
    fullFFT(:,1:size(biggerFFT,2)/2)=biggerFFT(:,1:size(biggerFFT,2)/2);
    fullFFT(:,size(fullFFT,2)-size(biggerFFT,2)/2:end)=biggerFFT(:,size(biggerFFT,2)/2:end);
     
    bigger=ifft2(fullFFT)*xscale*yscale;
    bigger=round(abs(bigger));
    if max(max(bigger))>255
        bigger=round(255*bigger./max(max(bigger)));
    end
end