function [result,Sensitivity,Specificity,Accuracy] = multisvm_validation(TrainData,TestData,fi)
% fi = features index selected from Feed forward 

%% Stage Classification
%% 10 best features from mRMR  

TrainingSet(:,1) = TrainData(:,8);    
TrainingSet(:,2) = TrainData(:,7);    
TrainingSet(:,3) = TrainData(:,152);   
TrainingSet(:,4) = TrainData(:,167);  
TrainingSet(:,5) = TrainData(:,112);  
TrainingSet(:,6) = TrainData(:,92);  
TrainingSet(:,7) = TrainData(:,200);  
TrainingSet(:,8) = TrainData(:,132);   
TrainingSet(:,9) = TrainData(:,43);   
TrainingSet(:,10) = TrainData(:,3); 
GroupTrain(:,1) = TrainData(:,1);   %multigroup

TestSet(:,1) = TestData(:,8);    
TestSet(:,2) = TestData(:,7);    
TestSet(:,3) = TestData(:,152);   
TestSet(:,4) = TestData(:,167);  
TestSet(:,5) = TestData(:,112);  
TestSet(:,6) = TestData(:,92);  
TestSet(:,7) = TestData(:,200);  
TestSet(:,8) = TestData(:,132);   
TestSet(:,9) = TestData(:,43);   
TestSet(:,10) = TestData(:,3); 
GroupTest(:,1) = TestData(:,1);  

Selected_TrainingSet = TrainingSet(:,fi);
Selected_TestSet = TestSet(:,fi);

u=unique(GroupTrain);
numClasses=length(u);
result = zeros(length(TestSet(:,1)),1);

%build models
for k=1:numClasses
    %Vectorized statement that binarizes Group
    %where 1 is the current class and 0 is all other classes 
%     G1vAll = zeros(length(u(:,1)),1);
%     G1vAll(k,1)=1;
    G1vAll=(GroupTrain==u(k));
    models(k) = svmtrain(Selected_TrainingSet,G1vAll,'kernel_function','rbf'); % Selected_TrainingSet
%     svm_3d_matlab_vis(models(k),TrainingSet,G1vAll);
end


%classify test cases
normal =0;
infected = 0;
ring = 0;
troph = 0;

for j=1:size(TestSet,1) %Selected_TestSet
    for k=1:numClasses
        if(svmclassify(models(k),Selected_TestSet(j,:))) %Selected_TestSet
            break;
        end
    end
    result(j) = k;
    if k==1
        normal = normal + 1;
    end
    if k==2
        ring = ring +1;
    end
    if k==3
        troph = troph +1;
    end
%     else
%         infected = infected + 1;
%     end
end

TPr = 0;
FPr = 0;
FNr = 0;
TNr = 0;
TPt = 0;
FPt = 0;
FNt = 0;
TNt = 0;


[a b] = size(result);

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

Sensitivity_ring = TPr*100/(TPr+FNr);
Specificity_ring  = TNr*100/(TNr+FPr);
Accuracy_ring = (TPr+TNr)*100/(TPr+TNr+FPr+FNr);

Sensitivity_troph = TPt*100/(TPt+FNt);
Specificity_troph  = TNt*100/(TNt+FPt);
Accuracy_troph = (TPt+TNt)*100/(TPt+TNt+FPt+FNt);

Ring = ring*100/a;
Troph = troph*100/a;
infected = ring+troph; 
Paracitemia = infected*100/a;

Sensitivity(1,1) = Sensitivity_ring;
Sensitivity(1,2) = Sensitivity_troph;
Specificity(1,1) = Specificity_ring;
Specificity(1,2) = Specificity_troph;
Accuracy(1,1) = Accuracy_ring;
Accuracy(1,2) = Accuracy_troph;


% % 1=normal 2=infected
% for i=1:a
%     if result(i) == 1 &&  GroupTest(i) == 1
%         TN = TN + 1;
%     end
%     if result(i) == 1 &&  GroupTest(i) ~= 1    
%         FN = FN + 1;
%     end
%     if result(i) ~= 1 &&  GroupTest(i) == 1
%         FP = FP + 1;
%     end
%     if result(i) ~= 1 &&  GroupTest(i) ~= 1
%         TP = TP + 1;
%     end    
% end
% 
% Sensitivity = TP*100/(TP+FN);
% Specificity  = TN*100/(TN+FP);
% Accuracy = (TP+TN)*100/(TP+TN+FP+FN);

%% SHOWING RESULT %%
% disp(label);
% 
% disp('Total Erythrocytes' );
% disp(a);
% 
% disp('Infected Erythrocytes');
% disp(infected);
% 
% disp('Number of Ring stage');
% disp(ring);
% 
% disp('Number of Trophozoit stage');
% disp(troph);
% 
% disp('Percent parasitemia (%)');
% disp(Paracitemia);
% 
% disp('Ring stage (%)');
% disp(Ring);
% 
% disp('Trophozoit stage (%)');
% disp(Troph);

disp('Sensitivity(ring) = ');
disp(Sensitivity_ring);

disp('Specificity(ring) = ');
disp(Specificity_ring);

disp('Accuracy(ring) = ');
disp(Accuracy_ring);

disp('Sensitivity(troph) = ');
disp(Sensitivity_troph);

disp('Specificity(troph) = ');
disp(Specificity_troph);

disp('Accuracy(troph) = ');
disp(Accuracy_troph);

%save(['celldata_' label '(featureselection10).mat'],'a','normal','infected','ring','troph','Paracitemia','Ring','Troph');
% save(['celldata_' label '(featureselection10_rbf).mat'],'a','normal','infected','Paracitemia');





