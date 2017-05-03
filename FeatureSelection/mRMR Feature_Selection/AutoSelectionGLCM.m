function AutoSelectionGLCM
auto=1;
if auto
    load Statist_Feature.mat
    load GLCM_Feature.mat
    [a,b] = size(GLCM_Feature1);
    [c,d] = size(Moment_Feature);
    All_Feature = GLCM_Feature1;
    All_Feature(:,b+1:b+b) = GLCM_Feature2;
    All_Feature(:,2*b+1:2*b+b) = GLCM_Feature3;
    All_Feature(:,3*b+1:3*b+b) = GLCM_Feature4;
    All_Feature(:,4*b+1:4*b+d) = Moment_Feature;
    Class(1:30,1) = 1;Class(31:60,1) = 2;Class(61:90,1) = 3;
    Class(91:120,1) = 4;Class(121:150,1) = 5;
    [Feature] = mrmr_mid_d(All_Feature,Class,10);
    disp(Feature);
    SelectFunction(:,1) = All_Feature(:,Feature(1));
    SelectFunction(:,2) = All_Feature(:,Feature(2));
    SelectFunction(:,3) = All_Feature(:,Feature(3));
    SelectFunction(:,4) = All_Feature(:,Feature(4));
    SelectFunction(:,5) = All_Feature(:,Feature(5));
    SelectFunction(:,6) = All_Feature(:,Feature(6));
    SelectFunction(:,7) = All_Feature(:,Feature(7));
    SelectFunction(:,8) = All_Feature(:,Feature(8));
    SelectFunction(:,9) = All_Feature(:,Feature(9));
    SelectFunction(:,10) = All_Feature(:,Feature(10));
    save(['E:\Project\Senior Project\Result\All_Feature\FeatureSelection\' 'Selection_Feature.mat'],'SelectFunction');
end

