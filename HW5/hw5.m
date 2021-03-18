%%
cd('C:\Users\75638\OneDrive - UW\Desktop');
ski = VideoReader('ski_drop_low.mp4')
monte = VideoReader('monte_carlo_low.mp4')

dt = 1/ski.Framerate;
dt = 1/monte.Framerate;
%%
ski1 = [];
while hasFrame(ski)
 frame_ski = readFrame(ski);
 frame_ski = rgb2gray(frame_ski);
 frame_ski = reshape (frame_ski, [], 1);
 ski1 = [ski1, frame_ski];
end
ski_length = size(ski1,2);
%%
ski1 = [];
while hasFrame(ski)
 frame_monte = readFrame(ski);
 frame_monte = rgb2gray(frame_monte);
 frame_monte = reshape (frame_monte, [], 1);
 ski1 = [ski1, frame_monte];
end
monte_length = size(ski1,2);

%%
ski1 = double(ski1); 
X1 = ski1(:,1:end-1);
X2 = ski1(:,2:end);
[U, Sigma, V] = svd(X1,'econ');

%%
sv = diag(Sigma);
plot(linspace(1,length(sv),length(sv)),sv,'o')
title('Energy for Singular Values')
print('-dpng','svd.png')


%% only two modes are significant
U = U(:,1:2);
Sigma = Sigma(1:2,1:2);
V = V(:,1:2);
%%
S = U'*X2*V*diag(1./diag(Sigma));
[eV, D] = eig(S);
mu = diag(D);
omega = log(mu)/dt;
Phi = U*eV;
%%
y0 = Phi\X1(:,1); 
t = 0:dt:ski.Duration;
u_modes = zeros(length(y0),length(t)-1);
for iter = 1:(length(t)-1)
    u_modes(:,iter) = y0.*exp(omega*t(iter));
end
u_dmd = Phi*u_modes;

%%
X_sparse = X1-abs(u_dmd);
R = X_sparse.*(X_sparse<0);
foreground = X_sparse - R;
background = R + abs(u_dmd);
X_r = foreground+background;

%%
recon = reshape(X_r, [540,960,453]);
 background = reshape(u_dmd, [540,960,453]);
 foreground = reshape(X_sparse, [540,960,453]);
 original = reshape(X1, [540,960,453]);
%%
subplot(3,1,1)
imshow(uint8(original(:,:,50)));
title("Original Video");

subplot(3,1,2)
imshow(background(:,:,50))
title('Background Video')

subplot(3,1,3)
imshow(foreground(:,:,50))
title('Foreground Video')


