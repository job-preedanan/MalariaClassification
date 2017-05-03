function TestClassification
% This is function for validating program using different  feature sets

fr = fopen('testname.txt', 'r');      
ImageName=fgetl(fr);
Round = str2num(ImageName);
for i=1:Round

    ImageName = fgetl(fr);      
    disp(ImageName);
    pathname = ['C:\Users\job_preedanan\Documents\MATLAB\Testset\' ImageName];                       % edit path here
    
    [img,cell_wsh] = segmentcell(ImageName);       % prepare for visualizing results
    
    FN_1 = [ImageName '_features1.xlsx'];
    TestData1 = xlsread(FN_1);
    FN_2 = [ImageName '_features2.xlsx'];
    TestData2 = xlsread(FN_2);
    
    % -------------------------------------------------------------------------------------------------    
    % Testing with 'Linear' svm model from 'mrmr' 
    % -------------------------------------------------------------------------------------------------
    % load features
    TestData(:,1) = TestData1(:,109); 
    TestData(:,2) = TestData1(:,7); 
    TestData(:,3) = TestData1(:,103); 
    TestData(:,4) = TestData1(:,143);  
    TestData(:,5) = TestData1(:,107);  
    TestData(:,6) = TestData1(:,110);  
    TestData(:,7) = TestData1(:,147);  
    TestData(:,8) = TestData1(:,163);  
    TestData(:,9) = TestData1(:,122);   
    TestData(:,10) = TestData1(:,45);   
    group(:,1) = TestData1(:,1);            %load label (for validation)
  
    load models_linear_mrmr.mat     % load model
    disp('linear svm mrmr');
    
    % classification
    [result1,Sensitivity1,Specificity1,Accuracy1] = testsvm(models,TestData,group);
    clearvars TestData;
    clearvars group;
    
    % visualize results
    infected_img1 = detection(cell_wsh,img,result1);
    fn1 = [ImageName '_lm.jpg'];
    fn1 = fullfile(pathname, fn1);
    imwrite(infected_img1,fn1, 'jpg')
    
    % -------------------------------------------------------------------------------------------------    
    % Testing with 'rbf' svm model from 'mrmr'
    % -------------------------------------------------------------------------------------------------
    % load features
    TestData(:,1) = TestData1(:,109); 
    TestData(:,2) = TestData1(:,7); 
    TestData(:,3) = TestData1(:,103); 
    TestData(:,4) = TestData1(:,143);  
    TestData(:,5) = TestData1(:,107);  
    TestData(:,6) = TestData1(:,110);  
    TestData(:,7) = TestData1(:,147);  
    TestData(:,8) = TestData1(:,163);  
    TestData(:,9) = TestData1(:,122);   
    TestData(:,10) = TestData1(:,45);   
    group(:,1) = TestData1(:,1);             %load label (for validation)
    
    load models_rbf_mrmr.mat          %load model
    disp('rbf svm mrmr ');
    
    %classification
    [result2,Sensitivity2,Specificity2,Accuracy2] = testsvm(models,TestData,group);
    clearvars TestData;
    clearvars group;
    
    %vitualize results
    infected_img2 = detection(cell_wsh,img,result2);
    fn2 = [ImageName '_rm.jpg'];
    fn2 = fullfile(pathname, fn2);
    imwrite(infected_img2,fn2, 'jpg')
    
    % -------------------------------------------------------------------------------------------------   
    % Testing with 'linear' svm model from 'feed forward'
    % -------------------------------------------------------------------------------------------------
    %load features
    TestData(:,1) = TestData1(:,103);   
    TestData(:,2) = TestData1(:,109);  
    TestData(:,3) = TestData1(:,45);
    group(:,1) = TestData1(:,1);               %load label (for validation)
    
    load models_linear_sfs.mat;                  %load model
    disp('linear svm normal ');
    
    %classification
    [result3,Sensitivity3,Specificity3,Accuracy3] = testsvm(models,TestData,group);
    clearvars TestData;
    clearvars group;
    
    %visualize results
    infected_img3 = detection(cell_wsh,img,result3);
    fn3 = [ImageName '_lf.jpg'];
    fn3 = fullfile(pathname, fn3);
    imwrite(infected_img3,fn3, 'jpg')
    
    % ------------------------------------------------------------------------------------------------
    % Testing with 'rbf' svm model from 'feed forward'
    % -------------------------------------------------------------------------------------------------
    % load features
    TestData(:,1) = TestData1(:,103);   
    TestData(:,2) = TestData1(:,45);
    group(:,1) = TestData1(:,1);            %load label (for validation)
    
    load models_rbf_sfs.mat;                  %load model  
    disp('rbf svm normal ');
    
    %classification
    [result4,Sensitivity4,Specificity4,Accuracy4] = testsvm(models,TestData,group);
    clearvars TestData;
    clearvars group;
    
    %vitualize results
    infected_img4 = detection(cell_wsh,img,result4);                     
    fn4 = [ImageName '_rf.jpg'];
    fn4 = fullfile(pathname, fn4);
    imwrite(infected_img4,fn4, 'jpg')
    
    % ------------------------------------------------------------------------------------------------ 
    % Testing with 'linear' svm model from 'backward'
    % ------------------------------------------------------------------------------------------------
    % load features
    TestData(:,1) = TestData1(:,109); 
    TestData(:,2) = TestData1(:,7); 
    TestData(:,3) = TestData1(:,143);  
    TestData(:,4) = TestData1(:,107);  
    TestData(:,5) = TestData1(:,110);  
    TestData(:,6) = TestData1(:,147);  
    TestData(:,7) = TestData1(:,163);  
    TestData(:,8) = TestData1(:,122);   
    TestData(:,9) = TestData1(:,45);   
    group(:,1) = TestData1(:,1);                % load label (for validation)
    
    load models_linear_sbs.mat            % load model
    disp('linear svm sbs');
    
    %classification
    [result5,Sensitivity5,Specificity5,Accuracy5] = testsvm(models,TestData,group);
    clearvars TestData;
    clearvars group;
    
    %visualize results
    infected_img5 = detection(cell_wsh,img,result5);
    fn5 = [ImageName '_lb.jpg'];
    fn5 = fullfile(pathname, fn5);
    imwrite(infected_img5,fn5, 'jpg')

    % ------------------------------------------------------------------------------------------------ 
    % Testing with 'rbf' svm model from 'backward'
    % ------------------------------------------------------------------------------------------------
    % load features
    TestData(:,1) = TestData1(:,109); 
    TestData(:,2) = TestData1(:,103); 
    TestData(:,3) = TestData1(:,143);  
    TestData(:,4) = TestData1(:,107);  
    TestData(:,5) = TestData1(:,110);  
    TestData(:,6) = TestData1(:,147);  
    TestData(:,7) = TestData1(:,163);  
    TestData(:,8) = TestData1(:,122);   
    TestData(:,9) = TestData1(:,45);   
    group(:,1) = TestData1(:,1);                %load label
    
    load models_rbf_sbs.mat;              % load model
    disp('rbf svm sbs');
    
    %classification
    [result6,Sensitivity6,Specificity6,Accuracy6] = testsvm(models,TestData,group);
    clearvars TestData;
    clearvars group;
    
    %visualize results
    infected_img6 = detection(cell_wsh,img,result6);
    fn6 = [ImageName '_rb.jpg'];
    fn6 = fullfile(pathname, fn6);
    imwrite(infected_img6,fn6, 'jpg')

    data1{i,1} = ImageName;
    data1{i,2} = Sensitivity1(1,1);
    data1{i,3} = Sensitivity1(1,2);
    data1{i,4} = Sensitivity1(1,3);
    data1{i,5} = Specificity1(1,1);
    data1{i,6} = Specificity1(1,2);
    data1{i,7} = Specificity1(1,3);
    data1{i,8} = Accuracy1(1,1);
    data1{i,9} = Accuracy1(1,2);
    data1{i,10} = Accuracy1(1,3);
    data2{i,1} = ImageName;
    data2{i,2} = Sensitivity2(1,1);
    data2{i,3} = Sensitivity2(1,2);
    data2{i,4} = Sensitivity2(1,3);
    data2{i,5} = Specificity2(1,1);
    data2{i,6} = Specificity2(1,2);
    data2{i,7} = Specificity2(1,3);
    data2{i,8} = Accuracy2(1,1);
    data2{i,9} = Accuracy2(1,2);
    data2{i,10} = Accuracy2(1,3);
    data3{i,1} = ImageName;
    data3{i,2} = Sensitivity3(1,1);
    data3{i,3} = Sensitivity3(1,2);
    data3{i,4} = Sensitivity3(1,3);
    data3{i,5} = Specificity3(1,1);
    data3{i,6} = Specificity3(1,2);
    data3{i,7} = Specificity3(1,3);
    data3{i,8} = Accuracy3(1,1);
    data3{i,9} = Accuracy3(1,2);
    data3{i,10} = Accuracy3(1,3);
    data4{i,1} = ImageName;
    data4{i,2} = Sensitivity4(1,1);
    data4{i,3} = Sensitivity4(1,2);
    data4{i,4} = Sensitivity4(1,3);
    data4{i,5} = Specificity4(1,1);
    data4{i,6} = Specificity4(1,2);
    data4{i,7} = Specificity4(1,3);
    data4{i,8} = Accuracy4(1,1);
    data4{i,9} = Accuracy4(1,2);
    data4{i,10} = Accuracy4(1,3);
    data3{i,1} = ImageName;
    data3{i,2} = Sensitivity5(1,1);
    data3{i,3} = Sensitivity5(1,2);
    data3{i,4} = Sensitivity5(1,3);
    data3{i,5} = Specificity5(1,1);
    data3{i,6} = Specificity5(1,2);
    data3{i,7} = Specificity5(1,3);
    data3{i,8} = Accuracy5(1,1);
    data3{i,9} = Accuracy5(1,2);
    data3{i,10} = Accuracy5(1,3);
    data4{i,1} = ImageName;
    data4{i,2} = Sensitivity6(1,1);
    data4{i,3} = Sensitivity6(1,2);
    data4{i,4} = Sensitivity6(1,3);
    data4{i,5} = Specificity6(1,1);
    data4{i,6} = Specificity6(1,2);
    data4{i,7} = Specificity6(1,3);
    data4{i,8} = Accuracy6(1,1);
    data4{i,9} = Accuracy6(1,2);
    data4{i,10} = Accuracy6(1,3);
    data5{i,1} = ImageName;
    data5{i,2} = Sensitivity5(1,1);
    data5{i,3} = Sensitivity5(1,2);
    data5{i,4} = Sensitivity5(1,3);
    data5{i,5} = Specificity5(1,1);
    data5{i,6} = Specificity5(1,2);
    data5{i,7} = Specificity5(1,3);
    data5{i,8} = Accuracy5(1,1);
    data5{i,9} = Accuracy5(1,2);
    data5{i,10} = Accuracy5(1,3);
    data6{i,1} = ImageName;
    data6{i,2} = Sensitivity6(1,1);
    data6{i,3} = Sensitivity6(1,2);
    data6{i,4} = Sensitivity6(1,3);
    data6{i,5} = Specificity6(1,1);
    data6{i,6} = Specificity6(1,2);
    data6{i,7} = Specificity6(1,3);
    data6{i,8} = Accuracy6(1,1);
    data6{i,9} = Accuracy6(1,2);
    data6{i,10} = Accuracy6(1,3);
    
%     if i==50 || i==100 || i==150 || i==200 || i==250
%         xlswrite('resultclassification1-5.xlsx',data1);
%         xlswrite('resultclassification2-5.xlsx',data2);
%         xlswrite('resultclassification3-5.xlsx',data3);
%         xlswrite('resultclassification4-5.xlsx',data4);
%     end
end
xlswrite('resultclassification-linear-mrmr.xlsx',data1);
xlswrite('resultclassification-rbf-mrmr.xlsx',data2);
xlswrite('resultclassification-linear-sfs.xlsx',data3);
xlswrite('resultclassification-rbf-sfs.xlsx',data4);
xlswrite('resultclassification-linear-sbs.xlsx',data5);
xlswrite('resultclassification-rbf-sbs.xlsx',data6);


function [img,cell_wsh] = segmentcell(FileName)
FN = [FileName '.jpg'];
img = imread(FN);
img2 = rgb2gray(img);
bw=adaptivethreshold(img2,100,0.02,0);

bw = imfill(~bw,'holes');
se = strel('disk',5);
bw = imerode(bw,se);
bw = imerode(bw,se);
bw = imdilate(bw,se);
bw = imdilate(bw,se);
bw = bwareaopen(bw,500);

wBW = matlabWatershed(bw);
cell_wsh = imclearborder(wBW); 
cell_wsh = bwareaopen(cell_wsh,1200);


function [result,Sensitivity,Specificity,Accuracy] = testsvm(models,TestData,group)

GroupTest(:,1) = group;  

result = zeros(length(TestData(:,1)),1);
numClasses = 3;

for j=1:size(TestData,1) 
    for k=1:numClasses
        if(svmclassify(models(k),TestData(j,:))) 
            break;
        end
    end
    result(j) = k;
end
[a b] = size(result);

TPi = 0;
FPi = 0;
FNi = 0;
TNi = 0;
TPr = 0;
FPr = 0;
FNr = 0;
TNr = 0;
TPt = 0;
FPt = 0;
FNt = 0;
TNt = 0;

for i=1:a
    if result(i) ~= 1 &&  GroupTest(i) ~= 1
        TPi = TPi + 1;
    end
    if result(i) ~= 1 &&  GroupTest(i) == 1    
        FPi = FPi + 1;
    end
    if result(i) == 1 &&  GroupTest(i) ~= 1
        FNi = FNi + 1;
    end
    if result(i) == 1 &&  GroupTest(i) == 1
        TNi = TNi + 1;
    end    
end

% 1=normal 2=ring 3=troph 
for i=1:a
    if result(i) ~= 2 &&  GroupTest(i) ~= 2
        TNr = TNr + 1;
    end
    if result(i) ~= 2 &&  GroupTest(i) == 2    
        FNr = FNr + 1;
    end
    if result(i) == 2 &&  GroupTest(i) ~= 2
        FPr = FPr + 1;
    end
    if result(i) == 2 &&  GroupTest(i) == 2
        TPr = TPr + 1;
    end    
end

for i=1:a
    if result(i) ~= 3 &&  GroupTest(i) ~= 3
        TNt = TNt + 1;
    end
    if result(i) ~= 3 &&  GroupTest(i) == 3    
        FNt = FNt + 1;
    end
    if result(i) == 3 &&  GroupTest(i) ~= 3
        FPt = FPt + 1;
    end
    if result(i) == 3 &&  GroupTest(i) == 3
        TPt = TPt + 1;
    end    
end

Sensitivity_infect = TPi*100/(TPi+FNi);
Specificity_infect  = TNi*100/(TNi+FPi);
Accuracy_infect = (TPi+TNi)*100/(TPi+TNi+FPi+FNi);
disp('Sensitivity_infect');
disp(Sensitivity_infect);
disp('Specificity_infect');
disp(Specificity_infect);
disp('Accuracy_infect');
disp(Accuracy_infect);

Sensitivity_ring = TPr*100/(TPr+FNr);
Specificity_ring  = TNr*100/(TNr+FPr);
Accuracy_ring = (TPr+TNr)*100/(TPr+TNr+FPr+FNr);
disp('Sensitivity_ring');
disp(Sensitivity_ring);
disp('Specificity_ring');
disp(Specificity_ring);
disp('Accuracy_ring');
disp(Accuracy_ring);

Sensitivity_troph = TPt*100/(TPt+FNt);
Specificity_troph  = TNt*100/(TNt+FPt);
Accuracy_troph = (TPt+TNt)*100/(TPt+TNt+FPt+FNt);
disp('Sensitivity_troph');
disp(Sensitivity_troph);
disp('Specificity_troph');
disp(Specificity_troph);
disp('Accuracy_troph');
disp(Accuracy_troph);

Sensitivity(1,1) = Sensitivity_ring;
Sensitivity(1,2) = Sensitivity_troph;
Sensitivity(1,3) = Sensitivity_infect;
Specificity(1,1) = Specificity_ring;
Specificity(1,2) = Specificity_troph;
Specificity(1,3) = Specificity_infect;
Accuracy(1,1) = Accuracy_ring;
Accuracy(1,2) = Accuracy_troph;
Accuracy(1,3) = Accuracy_infect;