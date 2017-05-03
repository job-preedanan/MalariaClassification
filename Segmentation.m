function [wBW,gImg,img] = Segmentation(FileName,pathname)

FN = [pathname FileName '.jpg'];
img = imread(FN);
gImg = rgb2gray(img);
% img2 = contrast_linear_str(img2);
% imwrite(img2,'image47g.jpg', 'jpg');

%% Segmentation 
%[nfc, Jrbo] = mySegmentation2(img, 2);    %segmentation N'Mon method

% Adaptive threshold
bw=adaptivethreshold(gImg,100,0.02,0);     %cell segmentation by Adaptive Thresh method

%% morphology 
bw = imfill(~bw,'holes');
se = strel('disk',5);
bw = imerode(bw,se);  bw = imerode(bw,se);
bw = imdilate(bw,se); bw = imdilate(bw,se);
bw = bwareaopen(bw,500);                      % complete segmented cell image

% fn2 = [FileName '_segment1.jpg'];
% fn2 = fullfile(pathname, fn2);
% imwrite(bw,fn2, 'jpg');

%% Watershed + clear border
% cell_wsh = imagej(filename); %processed by ImageJ
wBW = matlabWatershed(bw);
wBW = imclearborder(wBW); 
wBW = bwareaopen(wBW,1200);

% segment_img = img2;
% [a b] = size(wBW);
% for j = 1:b
%     for i = 1:a
%         if wBW(i,j,1) == 0
%             segment_img(i,j,1) = 255;
%         end
%     end
% end
% figure,imshow(segment_img);
% imwrite(segment_img,'image-7seg.jpg', 'jpg');







