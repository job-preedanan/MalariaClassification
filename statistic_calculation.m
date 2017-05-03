function [Mean,Std,Skewness,Kurtosis] = statistic_calculation(intensity)

[m n] = size(intensity);

%% Mean 
sumx = 0;
for i = 1:m
    x = intensity(i,3);
    sumx = sumx +x;
end
Mean = sumx/m;


%% Std
sumstd = 0;
for i = 1:m
    x = intensity(i,3);
    sumstd = sumstd + ((x-Mean)*(x-Mean)/m);
end
Std = sqrt(sumstd);

%% Skewness
sumskew = 0;
for i = 1:m
    x = intensity(i,3);
    sumskew = sumskew + ((x-Mean)^3)/(Std^3);
end
Skewness = sumskew/m;

%% Kurtosis
sumkurt = 0;
for i = 1:m
    x = intensity(i,3);
    sumkurt = sumkurt + ((x-Mean)^4)/(Std^4);
end
Kurtosis = sumkurt/m;



