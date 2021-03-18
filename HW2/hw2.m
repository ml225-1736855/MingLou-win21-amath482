%%
figure(1)
[y, Fs] = audioread('Floyd.m4a');
n=length(y); 
L=n/Fs; %record time in seconds
t=(1:n)/Fs;
k=(Fs/n)*[0:(n-1)/2 -(n-1)/2:-1];
ks=fftshift(k);
S = y';
St = fft(S);

subplot(2, 1, 1);
plot(t, S);
xlabel('Time [sec]'); ylabel('Amplitude');
title('Floyd');

subplot(2, 1, 2);
plot(ks, abs(fftshift(St))/max(abs(St)), 'r');
set(gca, 'XLim', [0 2e3]);
xlabel('frequency'); ylabel('Amplitude');


%%    
a = 20;
tau = 0:1:L;
for j = 1:length(tau)
    g = exp(-a*(t - tau(j)).^2);
    Sg = g.*S;
    Sgt = fft(Sg);
    Sgt_spec(:,j) = fftshift(abs(Sgt));
end


pcolor(tau,ks,Sgt_spec)
shading interp
set(gca,'ylim',[0 4000],'Fontsize',16)
colormap(hot)
colorbar 
xlabel('time (t)'), ylabel('frequency (k)')

%% %% GNR
clear variables;
figure(2)
[y, Fs] = audioread('GNR.m4a');
n=length(y); 
L=n/Fs; %record time in seconds
t=(1:n)/Fs;
k=(Fs/n)*[0:(n-1)/2 -(n-1)/2:-1];
ks=fftshift(k);

S = y';
St = fft(S(1:659121));


subplot(2, 1, 1);
plot(t, S);
xlabel('Time [sec]'); ylabel('Amplitude');
title('GNR');

subplot(2, 1, 2);
plot(ks, abs(fftshift(St))/max(abs(St)), 'r');
set(gca, 'XLim', [0 2e3]);
xlabel('frequency'); ylabel('Amplitude');



%% 
a = 20;
tau = 0:1:L;
for j = 1:length(tau)
    g = exp(-a*(t - tau(j)).^2);
    Sg = g.*S;
    Sgt = fft(Sg);
    Sgt_spec(:,j) = fftshift(abs(Sgt));
end


pcolor(tau,ks,Sgt_spec)
shading interp
set(gca,'ylim',[0 4000],'Fontsize',16)
colormap(hot)
colorbar 
xlabel('time (t)'), ylabel('frequency (k)')





