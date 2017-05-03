function [TrainedFeatures,mRMR_features] = FeaturesSelection_mRMR(TN)
%% randomly select train data from feature data
% ratio of normal cells and infected cells = 1:1(ring 50%, troph 50%)
% input = excel file - 1st column : cell label (1-normal,2-ring,3-troph).
% other column : features data

fr = fopen(TN, 'r');  
FileName=fgetl(fr);
Round = str2double(FileName);
r = 0;
for i = 1:Round
    TrainName = fgetl(fr);
    FN_1 = ['C:\Users\job_preedanan\Documents\MATLAB\Trainset\' TrainName '\' TrainName '_features2.xlsx'];    %path name of computed features from Feature Extraction
    Data = xlsread(FN_1); 
    [a b] = size(Data);
    m = 0;
    p = 0;
    for j = 1:a
        label = Data(j,1);
        if label == 1;
            ncell(m+1,:) = Data(j,:);
            [m n] = size(ncell);
        else
            icell(p+1,:) = Data(j,:);
            [p q] = size(icell);
        end
    end
    %random features from normal cell = p
    nfeature = datasample(ncell,p);
    TrainedFeatures(r+1:r+p,:) = icell(1:p,:);
    TrainedFeatures(r+p+1:r+(2*p),:) = nfeature(1:p,:);
    [r s] = size(TrainedFeatures);
    clear ncell
    clear icell
end       
disp 'finish create train data'

%% mRMR %%
% feature = xlsread('trainfeature10_2.xlsx');
[a b] = size(TrainedFeatures);
feature_value = TrainedFeatures(1:20,2:b);
groupname = TrainedFeatures(1:20,1);

numfeatures = 10; %number of selected features by mRMR
mRMR_features = mrmr_mid_d(feature_value, groupname, numfeatures);     %return index of selected features

