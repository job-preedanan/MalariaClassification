function [ Lfig ] = matlabWatershed( BW )
%This function implements watershed algorithm on binary image. 
%   Input: Binary labelling matrix. 
%   Output: Watershed cut binary labelling matrix. 

D = -bwdist(~BW); 
mask = imextendedmin(D, 2); 
D2 = imimposemin(D, mask); 
L = watershed(D2); 
Label = BW; 
Label(L==0) = 0; 
%rgb = label2rgb(L, 'jet', [.5 .5 .5]); 
%figure, imshow(rgb, 'InitialMagnification', 'fit'); 
Lfig = Label; 
end

          