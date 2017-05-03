function feature_index = FeaturesSelection_FeedForward(trainName)

most_accuracy = 0;

for j=1:10
    feature_index(1,j) = 0;
    for i=1:10
        if i ~= feature_index(1,:) %check if new feature not be the same
            fi = feature_index;
            fi(1,j) = i;
            accuracy = Leave1out_validation(fi,trainName); %go to leave1out and calculate average accuracy
            if accuracy > most_accuracy
                most_accuracy = accuracy;
                feature_index(1,j) = i;
            end
        end
    end
    if feature_index(1,j) == 0
        break;       
    end
end 
















