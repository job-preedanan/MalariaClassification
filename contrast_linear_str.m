function Image_new2 = contrast_linear_str(Image_new)
I2 = prctile(double(Image_new(:)),95);
I1 = prctile(double(Image_new(:)),5);
Image_new2 = zeros(size(Image_new),'uint8');
[a b]=size(Image_new);

for j=1:b
    for i=1:a
        Ic = double(Image_new(i,j));
        if Ic > I2
            Image_new2(i,j) = 255;
        elseif Ic < I1
            Image_new2(i,j) = 0;
        else
            In = 255*(Ic-I1)/(I2-I1);
            Image_new2(i,j) = In;
        end
    end
end 