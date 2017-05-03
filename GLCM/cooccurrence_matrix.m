function [properties0,properties45,properties90,properties135,properties0_2,properties45_2,properties90_2,properties135_2] = cooccurrence_matrix(FileName,Image_new,label)
% %% 8x8
glcm0 = graycomatrix(Image_new,'NumLevels',8,'Offset',[0 1]);
glcm45 = graycomatrix(Image_new,'NumLevels',8,'Offset',[-1 1]);
glcm90 = graycomatrix(Image_new,'NumLevels',8,'Offset',[-1 0]);
glcm135 = graycomatrix(Image_new,'NumLevels',8,'Offset',[-1 -1]);

%% 32x32
glcm0_2 = graycomatrix(Image_new,'NumLevels',32,'Offset',[0 1]);
glcm45_2 = graycomatrix(Image_new,'NumLevels',32,'Offset',[-1 1]);
glcm90_2 = graycomatrix(Image_new,'NumLevels',32,'Offset',[-1 0]);
glcm135_2 = graycomatrix(Image_new,'NumLevels',32,'Offset',[-1 -1]);

% maxvalue0 = max(max(glcm0));
% r= maxvalue0/255;
% for i=2:8
%     for j=2:8
%         glcm0_img(i,j) = glcm0(i,j)/r;              
%     end
% end
% 
% maxvalue45 = max(max(glcm45));
% r= maxvalue45/255;
% for i=2:8
%     for j=2:8
%         glcm45_img(i,j) = glcm45(i,j)/r;              
%     end
% end
% 
% maxvalue90 = max(max(glcm90));
% r= maxvalue90/255;
% for i=2:8
%     for j=2:8
%         glcm90_img(i,j) = glcm90(i,j)/r;              
%     end
% end
% 
% maxvalue135 = max(max(glcm135));
% r= maxvalue135/255;
% for i=2:8
%     for j=2:8
%         glcm135_img(i,j) = glcm135(i,j)/r;              
%     end
% end

% FNW1 = [FileName '_' label '_glcm0(8).jpg'];     
% imwrite(glcm0_img,FNW1, 'jpg');
% FNW2 = [FileName '_' label '_glcm45(8).jpg'];     
% imwrite(glcm45_img,FNW2, 'jpg');
% FNW3 = [FileName '_' label '_glcm90(8).jpg'];     
% imwrite(glcm90_img,FNW3, 'jpg');
% FNW4 = [FileName '_' label '_glcm135(8).jpg'];     
% imwrite(glcm135_img,FNW4, 'jpg');

%% find properties

glcm0(1:7,1:7) = glcm0(2:8,2:8);
glcm45(1:7,1:7) = glcm45(2:8,2:8);
glcm90(1:7,1:7) = glcm90(2:8,2:8);
glcm135(1:7,1:7) = glcm135(2:8,2:8);

glcm0_2(1:31,1:31) = glcm0_2(2:32,2:32);
glcm45_2(1:31,1:31) = glcm45_2(2:32,2:32);
glcm90_2(1:31,1:31) = glcm90_2(2:32,2:32);
glcm135_2(1:31,1:31) = glcm135_2(2:32,2:32);

%% 8x8
properties0 = GLCM_Features1(glcm0,0);
properties45 = GLCM_Features1(glcm45,0);
properties90 = GLCM_Features1(glcm90,0);
properties135 = GLCM_Features1(glcm135,0);

%% 32x32
properties0_2 = GLCM_Features1(glcm0_2,0);
properties45_2 = GLCM_Features1(glcm45_2,0);
properties90_2 = GLCM_Features1(glcm90_2,0);
properties135_2 = GLCM_Features1(glcm135_2,0);

% save([FileName '_' label 'GLCM.mat'],'properties0','properties45','properties90','properties135','properties0_2','properties45_2','properties90_2','properties135_2');

% save([FileName '_' label '(8)glcm0_2.mat'],'glcm0','properties0');
% save([FileName '_' label '(8)glcm45_2.mat'],'glcm45','properties45');
% save([FileName '_' label '(8)glcm90_2.mat'],'glcm90','properties90');
% save([FileName '_' label '(8)glcm135_2.mat'],'glcm135','properties135');
% 
% save([FileName '_' label '(32)glcm0_2.mat'],'glcm0_2','properties0_2');
% save([FileName '_' label '(32)glcm45_2.mat'],'glcm45_2','properties45_2');
% save([FileName '_' label '(32)glcm90_2.mat'],'glcm90_2','properties90_2');
% save([FileName '_' label '(32)glcm135_2.mat'],'glcm135_2','properties135_2');

