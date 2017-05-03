function models = TrainProgram(feature) 

TrainingSet(:,1) = feature(:,109); 
TrainingSet(:,2) = feature(:,103); 
TrainingSet(:,3) = feature(:,143);  
TrainingSet(:,4) = feature(:,107);  
TrainingSet(:,5) = feature(:,110);  
TrainingSet(:,6) = feature(:,147);  
TrainingSet(:,7) = feature(:,163);  
TrainingSet(:,8) = feature(:,122);   
TrainingSet(:,9) = feature(:,45);   
TrainingSet(:,10) = feature(:,7); 

GroupTrain(:,1) = feature(:,1);   %multigroup

u=unique(GroupTrain);
numClasses=length(u);

%build models
for k=1:numClasses
    %Vectorized statement that binarizes Group
    %where 1 is the current class and 0 is all other classes 
%     G1vAll = zeros(length(u(:,1)),1);
%     G1vAll(k,1)=1;
    G1vAll=(GroupTrain==u(k));
    models(k) = svmtrain(TrainingSet,G1vAll,'kernel_function','rbf');
%     svm_3d_matlab_vis(models(k),TrainingSet,G1vAll);
end








