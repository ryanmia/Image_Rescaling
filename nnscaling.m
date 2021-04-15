clear all;close all;clc;

img=imread("img.png");
img=img(:,:,1);
xscale=15;
yscale=10;
bigger=rescaleNN(img,xscale,yscale);

figure
image(img)
colormap(gray(255));
figure
image(bigger)
colormap(gray(255));
bigger= uint8(bigger);
imwrite(bigger,"img_nnscaling_2x3.png");
function bigger=rescaleNN(img,xscale,yscale)
    [x,y]=size(img);
    %horz
    horzImg=zeros(size(img,1),size(img,2)*xscale);
    for j=1:size(horzImg,2)
        mapsFrom=round(j/xscale)+1;
        if mapsFrom>size(img,2)
            mapsFrom=size(img,2);
        end
        horzImg(:,j)=img(:,mapsFrom);
    end
    %vert
    bigger=zeros(size(img,1)*yscale,size(img,2)*xscale);
    for i=1:size(bigger,1)
        mapsFrom=round(i/yscale)+1;
        if mapsFrom>size(horzImg,1)
            mapsFrom=size(horzImg,1);
        end
        bigger(i,:)=horzImg(mapsFrom,:);
    end
end