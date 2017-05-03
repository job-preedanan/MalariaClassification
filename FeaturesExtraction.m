function features = FeaturesExtraction(cell_wsh,FileName,gImg,pathname,option)
%% This code is for features calculation
% Features = HA, GLCM, GLRLM, wavelet transform

CC = bwconncomp(cell_wsh);
stats = regionprops(CC,'Centroid','PixelList','BoundingBox','Area');

[a b] = size(stats);
% save([FileName '_stats.mat'],'a','stats');
statta = zeros(a,4);
GLCM = zeros(a,3);
GLRLM = zeros(a,44);
Energy_wavelet = zeros(a,60);

for n=1:a
    [c d] = size(stats(n,1).PixelList);
    e = round(stats(n,1).BoundingBox(1,1));
    f = round(stats(n,1).BoundingBox(1,2));
    g = stats(n,1).BoundingBox(1,3);
    h = stats(n,1).BoundingBox(1,4);
    cellImg = zeros(h, g, 'uint8');
    for m =1:c
        x = stats(n,1).PixelList(m,2);
        y = stats(n,1).PixelList(m,1);
        intensity(m,1) = x;
        intensity(m,2) = y;        
        intensity(m,3) = gImg(x,y);
        %%create cell image
        xn = (x - f)+1;
        yn = (y - e)+1;
        cellImg(xn,yn) = gImg(x,y);   %cell 
    end
    label = int2str(n); 
    
%     path = [FileName];
    mkdir(FileName,'cells1');
    directory = [pathname FileName '\cells1'];
    addpath(directory);

    %% linearlization 
    if option == 2
        
        cellImg = contrast_linear_str(cellImg);
                
%         path = ['../Trainset/' FileName];
%         mkdir(path,'cells2');
        directory = [pathname FileName '\cells2'];
        addpath(pathname);
    end
    
    FNW = [FileName '_cell' label '.jpg']; 
    file = fullfile(directory, FNW);
    imwrite(cellImg,file, 'jpg');
    
    %% run length matrix calculation
    [GLRLMS,SI] = grayrlmatrix(cellImg);
    v1= GLRLMS{1,1};
    GLRLMS{1,1}= v1(2:8,:);
    v2= GLRLMS{1,2};
    GLRLMS{1,2}= v2(2:8,:);
    v3= GLRLMS{1,3};
    GLRLMS{1,3}= v3(2:8,:);
    v4= GLRLMS{1,4};
    GLRLMS{1,4}= v4(2:8,:);
    statsrlm = grayrlprops(GLRLMS);

    GLRLM(n,1) = statsrlm(1,1);
    GLRLM(n,2) = statsrlm(1,2);
    GLRLM(n,3) = statsrlm(1,3);
    GLRLM(n,4) = statsrlm(1,4);
    GLRLM(n,5) = statsrlm(1,5);
    GLRLM(n,6) = statsrlm(1,6);
    GLRLM(n,7) = statsrlm(1,7);
    GLRLM(n,8) = statsrlm(1,8);
    GLRLM(n,9) = statsrlm(1,9);
    GLRLM(n,10) = statsrlm(1,10);
    GLRLM(n,11) = statsrlm(1,11);
    GLRLM(n,12) = statsrlm(2,1);
    GLRLM(n,13) = statsrlm(2,2);
    GLRLM(n,14) = statsrlm(2,3);
    GLRLM(n,15) = statsrlm(2,4);
    GLRLM(n,16) = statsrlm(2,5);
    GLRLM(n,17) = statsrlm(2,6);
    GLRLM(n,18) = statsrlm(2,7);
    GLRLM(n,19) = statsrlm(2,8);
    GLRLM(n,20) = statsrlm(2,9);
    GLRLM(n,21) = statsrlm(2,10);
    GLRLM(n,22) = statsrlm(2,11);
    GLRLM(n,23) = statsrlm(3,1);
    GLRLM(n,24) = statsrlm(3,2);
    GLRLM(n,25) = statsrlm(3,3);
    GLRLM(n,26) = statsrlm(3,4);
    GLRLM(n,27) = statsrlm(3,5);
    GLRLM(n,28) = statsrlm(3,6);
    GLRLM(n,29) = statsrlm(3,7);
    GLRLM(n,30) = statsrlm(3,8);
    GLRLM(n,31) = statsrlm(3,9);
    GLRLM(n,32) = statsrlm(3,10);
    GLRLM(n,33) = statsrlm(3,11);
    GLRLM(n,34) = statsrlm(4,1);
    GLRLM(n,35) = statsrlm(4,2);
    GLRLM(n,36) = statsrlm(4,3);
    GLRLM(n,37) = statsrlm(4,4);
    GLRLM(n,38) = statsrlm(4,5);
    GLRLM(n,39) = statsrlm(4,6);
    GLRLM(n,40) = statsrlm(4,7);
    GLRLM(n,41) = statsrlm(4,8);
    GLRLM(n,42) = statsrlm(4,9);
    GLRLM(n,43) = statsrlm(4,10);
    GLRLM(n,44) = statsrlm(4,11);
    % save([FileName label '_GLRLMS_2.mat'],'GLRLMS','SI');
    % save([FileName '_' label '_GLRLMS.mat'],'statsrlm');


    %% Co-occulance matrix calculation
    [properties0,properties45,properties90,properties135,properties0_2,properties45_2,properties90_2,properties135_2] = cooccurrence_matrix(FileName,cellImg,label);
    % [properties0,properties135,properties0_2,properties45_2,properties135_2] = cooccurrence_matrix(FileName,Image_new,label);
    GLCM(n,1) = properties0.autoc;    %Auto correlation
    GLCM(n,2) = properties0.contr;    %Contrast
    GLCM(n,3) = properties0.cprom;    %Cluster Prominence
    GLCM(n,4) = properties0.cshad;    %Cluster shade
    GLCM(n,5) = properties0.dissi;    %Dissimilarity
    GLCM(n,6) = properties0.energ;    %Energy
    GLCM(n,7) = properties0.entro;    %Entropy
    GLCM(n,8) = properties0.homom;    %Homogeneity: matlab
    GLCM(n,9) = properties0.homop;    %Homogeneity
    GLCM(n,10) = properties0.maxpr;   %Maximum probability
    GLCM(n,11) = properties0.sosvh;   %Sum of sqaures: Variance
    GLCM(n,12) = properties0.savgh;   %Sum average
    GLCM(n,13) = properties0.idmnc;   %Inverse difference moment normalized
    GLCM(n,14) = properties0.indnc;   %Inverse difference normalized (INN)
    GLCM(n,15) = properties0.svarh;   %Sum variance
    GLCM(n,16) = properties0.senth;   %Sum entropy
    GLCM(n,17) = properties0.dvarh;   %Difference variance
    GLCM(n,18) = properties0.denth;   %Difference entropy
    GLCM(n,19) = properties0.inf1h;   %Information measure of correlation1
    GLCM(n,20) = properties0.inf2h;   %Information measure of correlation2
    GLCM(n,21) = properties45.autoc;
    GLCM(n,22) = properties45.contr;
    GLCM(n,23) = properties45.cprom;
    GLCM(n,24) = properties45.cshad;
    GLCM(n,25) = properties45.dissi;
    GLCM(n,26) = properties45.energ;
    GLCM(n,27) = properties45.entro;
    GLCM(n,28) = properties45.homom;
    GLCM(n,29) = properties45.homop;
    GLCM(n,30) = properties45.maxpr;
    GLCM(n,31) = properties45.sosvh;
    GLCM(n,32) = properties45.savgh;
    GLCM(n,33) = properties45.idmnc;
    GLCM(n,34) = properties45.indnc;
    GLCM(n,35) = properties45.svarh;
    GLCM(n,36) = properties45.senth;
    GLCM(n,37) = properties45.dvarh;
    GLCM(n,38) = properties45.denth;
    GLCM(n,39) = properties45.inf1h;
    GLCM(n,40) = properties45.inf2h;
    GLCM(n,41) = properties90.autoc;
    GLCM(n,42) = properties90.contr;
    GLCM(n,43) = properties90.cprom;
    GLCM(n,44) = properties90.cshad;
    GLCM(n,45) = properties90.dissi;
    GLCM(n,46) = properties90.energ;
    GLCM(n,47) = properties90.entro;
    GLCM(n,48) = properties90.homom;
    GLCM(n,49) = properties90.homop;
    GLCM(n,50) = properties90.maxpr;
    GLCM(n,51) = properties90.sosvh;
    GLCM(n,52) = properties90.savgh;
    GLCM(n,53) = properties90.idmnc;
    GLCM(n,54) = properties90.indnc;
    GLCM(n,55) = properties90.svarh;
    GLCM(n,56) = properties90.senth;
    GLCM(n,57) = properties90.dvarh;
    GLCM(n,58) = properties90.denth;
    GLCM(n,59) = properties90.inf1h;
    GLCM(n,60) = properties90.inf2h;
    GLCM(n,61) = properties135.autoc;
    GLCM(n,62) = properties135.contr;
    GLCM(n,63) = properties135.cprom;
    GLCM(n,64) = properties135.cshad;
    GLCM(n,65) = properties135.dissi;
    GLCM(n,66) = properties135.energ;
    GLCM(n,67) = properties135.entro;
    GLCM(n,68) = properties135.homom;
    GLCM(n,69) = properties135.homop;
    GLCM(n,70) = properties135.maxpr;
    GLCM(n,71) = properties135.sosvh;
    GLCM(n,72) = properties135.savgh;
    GLCM(n,73) = properties135.idmnc;
    GLCM(n,74) = properties135.indnc;
    GLCM(n,75) = properties135.svarh;
    GLCM(n,76) = properties135.senth;
    GLCM(n,77) = properties135.dvarh;
    GLCM(n,78) = properties135.denth;
    GLCM(n,79) = properties135.inf1h;
    GLCM(n,80) = properties135.inf2h;
    GLCM(n,81) = properties0_2.autoc;
    GLCM(n,82) = properties0_2.contr;
    GLCM(n,83) = properties0_2.cprom;
    GLCM(n,84) = properties0_2.cshad;
    GLCM(n,85) = properties0_2.dissi;
    GLCM(n,86) = properties0_2.energ;
    GLCM(n,87) = properties0_2.entro;
    GLCM(n,88) = properties0_2.homom;
    GLCM(n,89) = properties0_2.homop;
    GLCM(n,90) = properties0_2.maxpr;
    GLCM(n,91) = properties0_2.sosvh;
    GLCM(n,92) = properties0_2.savgh;
    GLCM(n,93) = properties0_2.idmnc;
    GLCM(n,94) = properties0_2.indnc;
    GLCM(n,95) = properties0_2.svarh;
    GLCM(n,96) = properties0_2.senth;
    GLCM(n,97) = properties0_2.dvarh;
    GLCM(n,98) = properties0_2.denth;
    GLCM(n,99) = properties0_2.inf1h;
    GLCM(n,100) = properties0_2.inf2h;
    GLCM(n,101) = properties45_2.autoc;
    GLCM(n,102) = properties45_2.contr;
    GLCM(n,103) = properties45_2.cprom;
    GLCM(n,104) = properties45_2.cshad;
    GLCM(n,105) = properties45_2.dissi;
    GLCM(n,106) = properties45_2.energ;
    GLCM(n,107) = properties45_2.entro;
    GLCM(n,108) = properties45_2.homom;
    GLCM(n,109) = properties45_2.homop;
    GLCM(n,110) = properties45_2.maxpr;
    GLCM(n,111) = properties45_2.sosvh;
    GLCM(n,112) = properties45_2.savgh;
    GLCM(n,113) = properties45_2.idmnc;
    GLCM(n,114) = properties45_2.indnc;
    GLCM(n,115) = properties45_2.svarh;
    GLCM(n,116) = properties45_2.senth;
    GLCM(n,117) = properties45_2.dvarh;
    GLCM(n,118) = properties45_2.denth;
    GLCM(n,119) = properties45_2.inf1h;
    GLCM(n,120) = properties45_2.inf2h;
    GLCM(n,121) = properties90_2.autoc;
    GLCM(n,122) = properties90_2.contr;
    GLCM(n,123) = properties90_2.cprom;
    GLCM(n,124) = properties90_2.cshad;
    GLCM(n,125) = properties90_2.dissi;
    GLCM(n,126) = properties90_2.energ;
    GLCM(n,127) = properties90_2.entro;
    GLCM(n,128) = properties90_2.homom;
    GLCM(n,129) = properties90_2.homop;
    GLCM(n,130) = properties90_2.maxpr;
    GLCM(n,131) = properties90_2.sosvh;
    GLCM(n,132) = properties90_2.savgh;
    GLCM(n,133) = properties90_2.idmnc;
    GLCM(n,134) = properties90_2.indnc;
    GLCM(n,135) = properties90_2.svarh;
    GLCM(n,136) = properties90_2.senth;
    GLCM(n,137) = properties90_2.dvarh;
    GLCM(n,138) = properties90_2.denth;
    GLCM(n,139) = properties90_2.inf1h;
    GLCM(n,140) = properties90_2.inf2h;
    GLCM(n,141) = properties135_2.autoc;
    GLCM(n,142) = properties135_2.contr;
    GLCM(n,143) = properties135_2.cprom;
    GLCM(n,144) = properties135_2.cshad;
    GLCM(n,145) = properties135_2.dissi;
    GLCM(n,146) = properties135_2.energ;
    GLCM(n,147) = properties135_2.entro;
    GLCM(n,148) = properties135_2.homom;
    GLCM(n,149) = properties135_2.homop;
    GLCM(n,150) = properties135_2.maxpr;
    GLCM(n,151) = properties135_2.sosvh;
    GLCM(n,152) = properties135_2.savgh;
    GLCM(n,153) = properties135_2.idmnc;
    GLCM(n,154) = properties135_2.indnc;
    GLCM(n,155) = properties135_2.svarh;
    GLCM(n,156) = properties135_2.senth;
    GLCM(n,157) = properties135_2.dvarh;
    GLCM(n,158) = properties135_2.denth;
    GLCM(n,159) = properties135_2.inf1h;
    GLCM(n,160) = properties135_2.inf2h;

    %% 1st order Statistic features 
    [Mean,Std,Skewness,Kurtosis] = statistic_calculation(intensity); 
    % % save([FileName '_' label '_GLRLMS.mat'],'Mean','Std','Skewness','Kurtosis');
    statta(n,1) = Mean;
    statta(n,2) = Std;
    statta(n,3) = Skewness;
    statta(n,4) = Kurtosis;

    %% Multilevel 2-D wavelet decomposition
    [C1,S1] = wavedec2(cellImg,2,'haar');      %Haar
    [C2,S2] = wavedec2(cellImg,2,'db2');       %Deubechies2
    [C3,S3] = wavedec2(cellImg,2,'sym4');      %Symlet4   
    [Ea1,Eh1,Ev1,Ed1] = wenergy2(C1,S1);
    [Ea2,Eh2,Ev2,Ed2] = wenergy2(C2,S2);
    [Ea3,Eh3,Ev3,Ed3] = wenergy2(C3,S3);
    [C4,S4] = wavedec2(cellImg,4,'haar');      %Haar
    [C5,S5] = wavedec2(cellImg,4,'db2');       %Deubechies2
    [C6,S6] = wavedec2(cellImg,4,'sym4');      %Symlet4   
    [Ea4,Eh4,Ev4,Ed4] = wenergy2(C4,S4);
    [Ea5,Eh5,Ev5,Ed5] = wenergy2(C5,S5);
    [Ea6,Eh6,Ev6,Ed6] = wenergy2(C6,S6);

    Energy_wavelet(n,1) = Ea1;
    Energy_wavelet(n,2) = Eh1(1,1);
    Energy_wavelet(n,3) = Eh1(1,2);
    Energy_wavelet(n,4) = Ev1(1,1);
    Energy_wavelet(n,5) = Ev1(1,2);
    Energy_wavelet(n,6) = Ed1(1,1);
    Energy_wavelet(n,7) = Ed1(1,2);
    Energy_wavelet(n,8) = Ea2;
    Energy_wavelet(n,9) = Eh2(1,1);
    Energy_wavelet(n,10) = Eh2(1,2);
    Energy_wavelet(n,11) = Ev2(1,1);
    Energy_wavelet(n,12) = Ev2(1,2);
    Energy_wavelet(n,13) = Ed2(1,1);
    Energy_wavelet(n,14) = Ed2(1,2);
    Energy_wavelet(n,15) = Ea3;
    Energy_wavelet(n,16) = Eh3(1,1);
    Energy_wavelet(n,17) = Eh3(1,2);
    Energy_wavelet(n,18) = Ev3(1,1);
    Energy_wavelet(n,19) = Ev3(1,2);
    Energy_wavelet(n,20) = Ed3(1,1);
    Energy_wavelet(n,21) = Ed3(1,2);
    Energy_wavelet(n,22) = Ea4;
    Energy_wavelet(n,23) = Eh4(1,1);
    Energy_wavelet(n,24) = Eh4(1,2);
    Energy_wavelet(n,25) = Eh4(1,3);
    Energy_wavelet(n,26) = Eh4(1,4);
    Energy_wavelet(n,27) = Ev4(1,1);
    Energy_wavelet(n,28) = Ev4(1,2);
    Energy_wavelet(n,29) = Ev4(1,3);
    Energy_wavelet(n,30) = Ev4(1,4);
    Energy_wavelet(n,31) = Ed4(1,1);
    Energy_wavelet(n,32) = Ed4(1,2);
    Energy_wavelet(n,33) = Ed4(1,3);
    Energy_wavelet(n,34) = Ed4(1,4);
    Energy_wavelet(n,35) = Ea5;
    Energy_wavelet(n,36) = Eh5(1,1);
    Energy_wavelet(n,37) = Eh5(1,2);
    Energy_wavelet(n,38) = Eh5(1,3);
    Energy_wavelet(n,39) = Eh5(1,4);
    Energy_wavelet(n,40) = Ev5(1,1);
    Energy_wavelet(n,41) = Ev5(1,2);
    Energy_wavelet(n,42) = Ev5(1,3);
    Energy_wavelet(n,43) = Ed5(1,4);
    Energy_wavelet(n,44) = Ed5(1,1);
    Energy_wavelet(n,45) = Ev5(1,2);
    Energy_wavelet(n,46) = Ed5(1,3);
    Energy_wavelet(n,47) = Ed5(1,4);
    Energy_wavelet(n,48) = Ea6;
    Energy_wavelet(n,49) = Eh6(1,1);
    Energy_wavelet(n,50) = Eh6(1,2);
    Energy_wavelet(n,51) = Eh6(1,3);
    Energy_wavelet(n,52) = Eh6(1,4);
    Energy_wavelet(n,53) = Ev6(1,1);
    Energy_wavelet(n,54) = Ev6(1,2);
    Energy_wavelet(n,55) = Ev6(1,3);
    Energy_wavelet(n,56) = Ev6(1,4);
    Energy_wavelet(n,57) = Ed6(1,1);
    Energy_wavelet(n,58) = Ed6(1,2);
    Energy_wavelet(n,59) = Ed6(1,3);
    Energy_wavelet(n,60) = Ed6(1,4);
    group(n,1) = 1;

end

features(:,1) = group;
features(:,2:5) = statta;
features(:,6:165) = GLCM;
features(:,166:209) = GLRLM;
features(:,210:269) = Energy_wavelet;

