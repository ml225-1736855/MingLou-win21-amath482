%% 
%% 
clear all ; close all ; clc ;
load ('cam1_1.mat')
load ('cam2_1.mat')
load ('cam3_1.mat')

%% 
numFrames11 = size(vidFrames1_1,4);
for k = 1:numFrames11
    X11(k).cdata = vidFrames1_1(:,:,:,k);
    X11(k).colormap = [];
end
%% 
filter = zeros(480,640);
filter(90:400, 230:360) = 1; 

data1 = [];
for j=1:numFrames11
    X=frame2im(X11(j));
    X2 = double(X);
    Xg = rgb2gray(X);
    Xg2 = double(Xg);
    Xf = Xg2.*filter;
    thresh = Xf > 200;
    indeces = find(thresh);
    [Y, X] = ind2sub(size(thresh),indeces);
    data1 = [data1; mean(X), mean(Y)];
end

%% 
numFrames21 = size(vidFrames2_1,4);
for k = 1:numFrames21
    X21(k).cdata = vidFrames2_1(:,:,:,k);
    X21(k).colormap = [];
end

filter = zeros(480,640);
filter(90:400, 230:360) = 1; 

data2 = [];
for j=1:numFrames21
    X=frame2im(X21(j));
    X2 = double(X);
    Xg = rgb2gray(X);
    Xg2 = double(Xg);
    Xf = Xg2.*filter;
    thresh = Xf > 200;
    indeces = find(thresh);
    [Y, X] = ind2sub(size(thresh),indeces);
    data2 = [data2; mean(X), mean(Y)];
end
data2= data2(1:226,:);
%% 
numFrames31 = size(vidFrames3_1,4);
for k = 1:numFrames31
    X31(k).cdata = vidFrames3_1(:,:,:,k);
    X31(k).colormap = [];
end

filter = zeros(480,640);
filter(200:400, 300:430) = 1; 

data3 = [];
for j=1:numFrames31
    X=frame2im(X31(j));
    X2 = double(X);
    Xg = rgb2gray(X);
    Xg2 = double(Xg);
    Xf = Xg2.*filter;
    thresh = Xf > 200;
    indeces = find(thresh);
    [Y, X] = ind2sub(size(thresh),indeces);
    data3 = [data3; mean(X), mean(Y)];
end
data3= data3(1:226,:);
%% 
collected_data = [data1'; data2'; data3'];
[m,n]= size(collected_data); 
mn = mean (collected_data ,2) ;
collected_data = collected_data - repmat(mn,1,n ) ; 
[U,S,V]= svd(collected_data'/sqrt(n-1));
lambda = diag(S).^2;
Y = collected_data' * V;


%% 
figure(1)
plot(1:6, lambda/sum(lambda), 'rx', 'Linewidth', 3);
title("Case 1: Variance and energy");
xlabel("Variances "); ylabel("Proportion of energy");

figure(2)
subplot(2,1,1)
plot(1:226, collected_data(2,:), 1:226, collected_data(1,:), 'Linewidth', 2)
ylabel("Displacement (pixels)"); xlabel("Time(frames)");
title("Case 1: Displacement along Z axis and XY - plane");
legend("Z", "XY")
subplot(2,1,2)
plot(1:226, Y(:,1),'g','Linewidth', 2)
ylabel("Displacement in pixels)"); xlabel("Time (frames)");
title("Case 1: Displacement along principal component directions");
legend("principle component 1")

%% 2
clear all;close all;clc
load ('cam1_2.mat')
load ('cam2_2.mat')
load ('cam3_2.mat')
%% 
numFrames12 = size(vidFrames1_2,4);
for k = 1:numFrames12
    X12(k).cdata = vidFrames1_2(:,:,:,k);
    X12(k).colormap = [];
end

filter = zeros(480,640);
filter(90:400, 230:360) = 1; 

data1 = [];
for j=1:numFrames12
    X=frame2im(X12(j));
    X2 = double(X);
    Xg = rgb2gray(X);
    Xg2 = double(Xg);
    Xf = Xg2.*filter;
    thresh = Xf > 200;
    indeces = find(thresh);
    [Y, X] = ind2sub(size(thresh),indeces);
    data1 = [data1; mean(X), mean(Y)];
end

%% 
numFrames22 = size(vidFrames2_2,4);
for k = 1:numFrames22
    X22(k).cdata = vidFrames2_2(:,:,:,k);
    X22(k).colormap = [];
end

filter = zeros(480,640);
filter(90:400, 230:360) = 1; 

data2 = [];
for j=1:numFrames22
    X=frame2im(X22(j));
    X2 = double(X);
    Xg = rgb2gray(X);
    Xg2 = double(Xg);
    Xf = Xg2.*filter;
    thresh = Xf > 200;
    indeces = find(thresh);
    [Y, X] = ind2sub(size(thresh),indeces);
    data2 = [data2; mean(X), mean(Y)];
end
data2= data2(1:314,:);

%% 
numFrames32 = size(vidFrames3_2,4);
for k = 1:numFrames32
    X32(k).cdata = vidFrames3_2(:,:,:,k);
    X32(k).colormap = [];
end

filter = zeros(480,640);
filter(200:400, 300:430) = 1; 

data3 = [];
for j=1:numFrames32
    X=frame2im(X32(j));
    X2 = double(X);
    Xg = rgb2gray(X);
    Xg2 = double(Xg);
    Xf = Xg2.*filter;
    thresh = Xf > 200;
    indeces = find(thresh);
    [Y, X] = ind2sub(size(thresh),indeces);
    data3 = [data3; mean(X), mean(Y)];
end
data3= data3(1:314,:);
%% 
collected_data = [data1'; data2'; data3'];
[m,n]= size(collected_data); 
mn = mean (collected_data ,2) ;
collected_data = collected_data - repmat ( mn ,1 , n ) ; 
[U,S,V]= svd(collected_data'/sqrt(n-1));
lambda = diag(S).^2;
Y = collected_data' * V;
%% 
figure (3)
plot (1:6,lambda/sum(lambda),'bx','Linewidth', 2) ;
title("Case 2: Energy of each Diagonal Variance ") ;
xlabel("Variances ") ; ylabel("Proportion of energy") ;
figure(4)
subplot(2 ,1 ,1)
plot(1:314, collected_data(2,:), 1:314, collected_data(1,:), 'Linewidth', 2)
ylabel(" Displacement in pixels"); xlabel ("Time ( frames )") ;
legend("Z" , " XY ")
title("Case 2: Original displacement along Z axis and XY - plane ( cam 1)") ;
subplot(2,1,2)
plot(1:314 , Y (:,1) ,1:314 , Y(:,2) ,'g','Linewidth', 2)
ylabel("Displacement in pixels") ; xlabel("Time ( frames )") ;
title("Case 2: Displacement along principal component directions") ;
legend("principle component 1 " , " principle component 2")
%% 3
clear all ; close all ; clc ;
load ('cam1_3.mat')
load ('cam2_3.mat')
load ('cam3_3.mat')
%% 
numFrames13 = size(vidFrames1_3,4);
for k = 1:numFrames13
    X13(k).cdata = vidFrames1_3(:,:,:,k);
    X13(k).colormap = [];
end

filter = zeros(480,640);
filter(90:400, 230:360) = 1; 

data1 = [];
for j=1:numFrames13
    X=frame2im(X13(j));
    X2 = double(X);
    Xg = rgb2gray(X);
    Xg2 = double(Xg);
    Xf = Xg2.*filter;
    thresh = Xf > 200;
    indeces = find(thresh);
    [Y, X] = ind2sub(size(thresh),indeces);
    data1 = [data1; mean(X), mean(Y)];
end
data1= data1(1:237,:);
%% 
numFrames23 = size(vidFrames2_3,4);
for k = 1:numFrames23
    X23(k).cdata = vidFrames2_3(:,:,:,k);
    X23(k).colormap = [];
end

filter = zeros(480,640);
filter(90:400, 230:360) = 1; 

data2 = [];
for j=1:numFrames23
    X=frame2im(X23(j));
    X2 = double(X);
    Xg = rgb2gray(X);
    Xg2 = double(Xg);
    Xf = Xg2.*filter;
    thresh = Xf > 200;
    indeces = find(thresh);
    [Y, X] = ind2sub(size(thresh),indeces);
    data2 = [data2; mean(X), mean(Y)];
end
data2= data2(1:237,:);

%% 
numFrames33 = size(vidFrames3_3,4);
for k = 1:numFrames33
    X33(k).cdata = vidFrames3_3(:,:,:,k);
    X33(k).colormap = [];
end

filter = zeros(480,640);
filter(200:400, 300:430) = 1; 

data3 = [];
for j=1:numFrames33
    X=frame2im(X33(j));
    X2 = double(X);
    Xg = rgb2gray(X);
    Xg2 = double(Xg);
    Xf = Xg2.*filter;
    thresh = Xf > 200;
    indeces = find(thresh);
    [Y, X] = ind2sub(size(thresh),indeces);
    data3 = [data3; mean(X), mean(Y)];
end
%% 
collected_data = [data1'; data2'; data3'];
[m,n]= size(collected_data); 
mn = mean (collected_data ,2) ;
collected_data = collected_data - repmat ( mn ,1 , n ) ; 
[U,S,V]= svd(collected_data'/sqrt(n-1));
lambda = diag(S).^2;
Y = collected_data' * V;
%% 
figure (5)
plot(1:6 , lambda / sum ( lambda ) , 'bx', 'Linewidth', 2) ;
title("Case 3: Energy of each Diagonal Variance") ;
xlabel("Variances ") ; ylabel ("Proportion of energy") ;
figure (6)
subplot (2 ,1 ,1)
plot (1:237 , collected_data(2 ,:), 1:237, collected_data(1,:),'Linewidth',2)
ylabel (" Displacement in pixels") ; xlabel("Time (frames)") ;
legend("Z" , " XY ")
title (" Case 3: Original displacement along Z axis and XY - plane ") ;
subplot (2 ,1 ,2)
plot (1:237 , Y(: ,1) , 1:237 , Y(: ,2) , 1:237 , Y(: ,3) ,'r','Linewidth', 2)
ylabel(" Displacement in pixels ) ") ; xlabel("Time( frames )") ;
title(" Case 3: Displacement along principal component directions ") ;
legend(" principle component 1 " , " principle component 2 " , "principle component 3 ")

%% 
clear all ; close all ; clc ;
load ('cam1_4.mat')
load ('cam2_4.mat')
load ('cam3_4.mat')
%% 
numFrames14 = size(vidFrames1_4,4);
for k = 1:numFrames14
    X14(k).cdata = vidFrames1_4(:,:,:,k);
    X14(k).colormap = [];
end

filter = zeros(480,640);
filter(90:400, 230:360) = 1; 

data1 = [];
for j=1:numFrames14
    X=frame2im(X14(j));
    X2 = double(X);
    Xg = rgb2gray(X);
    Xg2 = double(Xg);
    Xf = Xg2.*filter;
    thresh = Xf > 200;
    indeces = find(thresh);
    [Y, X] = ind2sub(size(thresh),indeces);
    data1 = [data1; mean(X), mean(Y)];
end
%% 
numFrames24 = size(vidFrames2_4,4);
for k = 1:numFrames24
    X24(k).cdata = vidFrames2_4(:,:,:,k);
    X24(k).colormap = [];
end

filter = zeros(480,640);
filter(90:400, 230:360) = 1; 

data2 = [];
for j=1:numFrames24
    X=frame2im(X24(j));
    X2 = double(X);
    Xg = rgb2gray(X);
    Xg2 = double(Xg);
    Xf = Xg2.*filter;
    thresh = Xf > 200;
    indeces = find(thresh);
    [Y, X] = ind2sub(size(thresh),indeces);
    data2 = [data2; mean(X), mean(Y)];
end
data2= data2(1:392,:);
%% 
numFrames34 = size(vidFrames3_4,4);
for k = 1:numFrames34
    X34(k).cdata = vidFrames3_4(:,:,:,k);
    X34(k).colormap = [];
end

filter = zeros(480,640);
filter(90:400, 230:360) = 1; 


data3 = [];
for j=1:numFrames34
    X=frame2im(X34(j));
    X2 = double(X);
    Xg = rgb2gray(X);
    Xg2 = double(Xg);
    Xf = Xg2.*filter;
    thresh = Xf > 200;
    indeces = find(thresh);
    [Y, X] = ind2sub(size(thresh),indeces);
    data3 = [data3; mean(X), mean(Y)];
end
data3= data3(1:392,:);

%% 
collected_data = [data1'; data2'; data3'];
[m,n]= size(collected_data); 
mn = mean (collected_data ,2) ;
collected_data = collected_data - repmat ( mn ,1 , n ) ; 
[U,S,V]= svd(collected_data'/sqrt(n-1));
lambda = diag(S).^2;
Y = collected_data' * V; 
%% 
figure(7)
plot(1:6 , lambda / sum(lambda) , 'bx', 'Linewidth', 2) ;
title(" Case 4: Energy of each Diagonal Variance") ;
xlabel("Variances") ; ylabel ("Proportion of Energy") ;
figure(8)
subplot(2 ,1 ,1)
plot(1:392 , collected_data(2 ,:) , 1:392, collected_data(1,:),'Linewidth',2)
ylabel("Displacement in pixels") ; xlabel("Time ( frames )") ;
title("Case 4: Original displacement along Z axis and XY - plane ") ;
subplot(2 ,1 ,2)
plot(1:392 , Y(: ,1) , 1:392 , Y(: ,2) , 1:392 , Y(: ,3) , 'Linewidth', 2)
ylabel("Displacement in pixels )") ; xlabel("Time ( frames )") ;
title("Case 4: Displacement along principal component directions") ;
legend("principle component 1" , "principle component 2" , "principle component 3")

