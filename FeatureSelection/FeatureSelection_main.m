%% feature selection part 1
   % mRMR selection (10 features)
trainName = 'trainname.txt';                                                %txt file of xls name for training data 
[TrainedFeatures,mRMR_feature] = FeaturesSelection_mRMR(trainName);         %outputs are 1.)random training data and 2.)selected features' index from mRMR
save('mRMR_feature.mat','mRMR_feature');
xlswrite('traindata.xlsx',TrainedFeatures);

%% feature selection part 2
   % Feed forward selection -- select best features set 
   %                        -- based on leave-one-out validation 
   % change index selected features derived from mRMR in
   % 'multisvm_validation' fn befoe running this
feature_index = FeaturesSelection_FeedForward(trainName);   

%% Training SVM model
% TrainedFeatures = xlsread('traindata.xlsx');
models = TrainProgram(TrainedFeatures,feature_index);
save('models.mat','models');
disp 'finish create svm model'
