function [Parasitemia,Ring,Troph,result] = cellClassification(models,features)
% Stage Classification

numClasses=3;

%classify test cases
normal =0;
ring = 0;
troph = 0;

for j=1:size(features,1)
    for k=1:numClasses
        if(svmclassify(models(k),features(j,:))) 
            break;
        end
    end
    result(j,1) = k;
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

[a b] = size(result);
Ring = ring*100/a;
Troph = troph*100/a;
infected = ring+troph; 
Parasitemia = infected*100/a;



