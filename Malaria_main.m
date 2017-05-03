%% Main Program 

%% Auto run for segmentation,features extraction and classification
clc;
clear;

% setting mode
% 0 - just colloct data
% 1 - full system
mode = 1;    

% setting running
% 0 - 1 image
% 1 - multiple images
multifiles = 0;

if multifiles == 1
    fr = fopen('trainname.txt', 'r');      %File name of images      Train set or Test set
    FileName=fgetl(fr);
    TotalFile = str2num(FileName);
else
    FileName = 'image-2';                  %File name
    TotalFile = 1;
end

pathname = 'C:\Users\Lenovo\Documents\MATLAB\MalariaProgram\' ;   %select pathname of images

load models_rbf_sfs2.mat;      %load model (derived from Feature selection)

for i = 1:TotalFile
    if multifiles == 1
        FileName = fgetl(fr);         % read line by line
    end
    
    mkdir(pathname,FileName);
    directory = [pathname FileName];
    addpath(directory);
       
    %% segmentation
    [segmentedImg, gImg,img] = Segmentation(FileName,pathname);                          
    if mode == 0
        fng = [FileName '\' FileName '_grey.jpg'];
        fng = fullfile(pathname, fng);
        imwrite(gImg,fng, 'jpg');
        
        fn1 = [FileName '\' FileName '_segment.jpg'];
        fn1 = fullfile(pathname, fn1);
        imwrite(segmentedImg,fn1, 'jpg');
    end
    disp('Finish Segmentation');
    
    %% features extraction
    features = FeaturesExtraction(segmentedImg,FileName,gImg,pathname,1);    
    if mode == 0
        fn2 = [FileName '\' FileName '_features.xlsx'];
        fn2 = fullfile(pathname, fn2);
        xlswrite(fn2,features);
    end
    disp('Finish features calculation');
      
    %% Classification
    if mode == 1
        
        % selected features (depend on svm model)          
        % ** provided in selected_features.txt
        selectedFeatures(:,1) = features(:,103); 
        selectedFeatures(:,3) = features(:,45);  
       
        %classification
        [Parasitemia,Ring,Troph,result] = cellClassification(models,selectedFeatures);
        disp('Finish classification');
        
        %vitualization
        [infected_img,troph_contour,ring_contour] = visualClassification(segmentedImg,img,result);
        disp('Finish showing images');
        
        fn3 = [FileName '\' FileName '_results.xlsx'];
        fn3 = fullfile(pathname, fn3);
        xlswrite(fn3,result);
        
        fn4 = [FileName '\' FileName 'infected_img.jpg'];
        fn4 = fullfile(pathname, fn4);
        imwrite(infected_img,fn4, 'jpg');
        imshow(infected_img),title('Result of classification');
        
    end
    
    clear features;
end
    
% fclose(fr);










