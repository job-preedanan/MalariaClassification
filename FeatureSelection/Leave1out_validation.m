function accuracy = Leave1out_validation(fi,TN,TrainData)

% TrainData = xlsread('trainfeature30_1.xlsx'); 

fr = fopen(TN, 'r');  
ImageName=fgetl(fr);
Round = str2num(ImageName);
for i=1:Round

    ImageName = fgetl(fr);              
    FN_1 = [ImageName '_features1.xlsx'];
    [TestData] = xlsread(FN_1);      
    label = int2str(i);               
    [result,Sensitivity,Specificity,Accuracy] = multisvm_validation(TrainData,TestData,fi);
    Result(i,1) = Sensitivity(1,1);   %ring
    Result(i,2) = Sensitivity(1,2);   %troph
    Result(i,3) = Specificity(1,1);   %ring
    Result(i,4) = Specificity(1,2);   %troph
    Result(i,5) = Accuracy(1,1);   %ring
    Result(i,6) = Accuracy(1,2);   %troph
end

sumsenr = 0;
n = 0;
sumsent = 0;
m= 0;
for a =1:6
    if isnan(Result(a,1))
        disp('NaN');
    else
        sumsenr = sumsenr + Result(a,1);
        n = n+1;
    end
    if isnan(Result(a,2))
        disp('NaN');
    else
        sumsent = sumsent + Result(a,2);
        m = m+1;
    end
end

Result_ring_average = sumsenr/n;
% Result_ring_average = mean(Result(:,1));
disp('average accuracy of Ring ');
disp(Result_ring_average);

Result_troph_average = sumsent/m;
% Result_troph_average = mean(Result(:,2));
disp('average accuracy of Trophozoit ');
disp(Result_troph_average);

accuracy = (Result_ring_average+Result_troph_average)/2;