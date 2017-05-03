function [infected_img,troph_contour,ring_contour] = visualClassification(cell_wsh,img,result)

CC = bwconncomp(cell_wsh);
stats = regionprops(CC,'PixelList');
[a,b] = size(result);

infected_cell = cell_wsh;
cell_ring = cell_wsh;
cell_troph = cell_wsh;
for i=1:a
    [c d] = size(stats(i,1).PixelList);
    for j=1:c
        x = stats(i,1).PixelList(j,2);
        y = stats(i,1).PixelList(j,1);
        if  result(i) ~= 2  %ring
            cell_ring(x,y,:) = 0;
        end
        if  result(i) ~= 3  %troph
            cell_troph(x,y,:) = 0;
        end
    end
end

se2 = strel('disk',5);
cell_ring_dilate = imdilate(cell_ring,se2); 
cell_troph_dilate = imdilate(cell_troph,se2);

[n m] = size(cell_ring);


for i=1:n
    for j=1:m
        if cell_ring(i,j) == cell_ring_dilate(i,j)
            ring_contour(i,j) = 0;
        else
            ring_contour(i,j) = 255;
        end
        
        if cell_troph(i,j) == cell_troph_dilate(i,j)
            troph_contour(i,j) = 0;
        else
            troph_contour(i,j) = 255;
        end
    end
end
% figure,imshow(troph_contour);

infected_img = img;
[x y z] = size(img);
for i=1:x
    for j=1:y
        if ring_contour(i,j,:) == 255 
            infected_img(i,j,1) = 255;
            infected_img(i,j,2) = 0;
            infected_img(i,j,3) = 0;
        end
        if troph_contour(i,j,:) ==255
            infected_img(i,j,1) = 21;
            infected_img(i,j,2) = 111;
            infected_img(i,j,3) = 41;           
        end
    end
end
