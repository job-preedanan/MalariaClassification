function feature_index = FeaturesSelection_Backward(trainName)

most_accuracy = 0;
feature_index = 1:10;
old_length = 10;
    
for j=1:10
    for i=1:10
        for n = 1:length(feature_index)
            if i == feature_index(1,n) %check if new feature not be the same
                check = 1;
            end
        end
        if check ==1
            %fi = feature_index;
            fi= backwarddata(i,feature_index);
            accuracy = Leave1out_validation(fi,trainName);    %go to leave1out and calculate average accuracy
            if accuracy > most_accuracy
                most_accuracy = accuracy;
                feature_index2 = fi;
            end
        end
    end
    if length(feature_index2) == old_length
        break;
    end
    old_length = length(feature_index2);
    feature_index = feature_index2;
end 

function fi= backwarddata(i,feature_index)

a =1;
for j = 1:length(feature_index)
    if feature_index(1,j) ~= i
      fi(1,a) = feature_index(1,j);
      a=a+1;
    end
end