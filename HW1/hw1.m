%% start code
 % Clean workspace
 clear all; close all; clc

 load subdata.mat % Imports the data as the 262144x49 (space by time) matrix called subdata

 L = 10; % spatial domain
 n = 64; % Fourier modes
 x2 = linspace(-L,L,n+1); x = x2(1:n); y =x; z = x;
 k = (2*pi/(2*L))*[0:(n/2 - 1) -n/2:-1]; ks = fftshift(k);

 [X,Y,Z]=meshgrid(x,y,z);
 [Kx,Ky,Kz]=meshgrid(ks,ks,ks);

 for j=1:49
 Un(:,:,:)=reshape(subdata(:,j),n,n,n);
 M = max(abs(Un),[],'all');
 close all, isosurface(X,Y,Z,abs(Un)/M,0.7)
 axis([-20 20 -20 20 -20 20]), grid on, drawnow
 pause(1)
 end
 

%% plot the averaged signal and find the center frequency
ave =  zeros (64 ,64 ,64);

for j=1:49
    Un(:,:,:)=reshape(subdata(:,j),n,n,n);
    Ut =fftn(Un); 
    ave(: ,: ,:) = ave + abs (reshape(Ut, n ,n, n));
end
ave = ave ./49;
ave = abs (ave) / max (abs(ave(:)));

isosurface (Kx, Ky, Kz, fftshift(ave), 0.7)
axis ([-L L -L L -L L]), grid on, drawnow
xlabel("Kx"), ylabel("Ky"), zlabel("Kz")
title ("Data with the averaging approach on frequency domain")

aveshift = fftshift (ave);
[maximum,index] = max (aveshift(:));
[ii,jj,ll] = ind2sub ([n, n, n ], index);
cx = ks (jj) ; cy = ks (ii) ; cz = ks (ll);  %get the center frequcy

%% plot the path of the submarine 
tau = 0.5; 
filter = exp(-tau*((cx).^2 + (cy).^2 + (cz).^2)); 

spot = zeros(49, 3);
for k = 1:49
 Un(:,:,:)=reshape(subdata(:,k),n,n,n);
 utn = fftn(Un);
 unft= fftshift(filter).*utn; % Apply the filter to the signal in frequency space
 unf= ifftn(unft);
 [Max, index] = max(abs(unf(:)));
 [index_x, index_y, index_z] = ind2sub([n,n,n], index);
 spot(k,:) = [X(index_x, index_y, index_z), Y(index_x, index_y, index_z), Z(index_x, index_y, index_z)];
end

figure;
plot3(spot(:,1), spot(:,2), spot(:,3), "b.--",  "Markersize", 20);
axis([-L L -L L -L L]), grid on
xlabel("x"); ylabel("y"); zlabel("z");
title("Path of Submarine");
set(gca, "Fontsize", 10);

%% find the final location
final_location = [spot(20,1), spot(20,2), spot(20,3)];
