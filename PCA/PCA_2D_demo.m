clear
close all

load PCA_2Ddemo_Data

% load 2D_PCA
x = z(1,:);
y = z(2,:);
figure;
subplot(1,2,1);
scatter(z(1,:),z(2,:),200,'linewidth',2);
set(gca,'fontsize',20);
axis([-15 15 -15 15]);
title('Original Data');

n = length(z); % sample size
% keyboard
%% 1. compute the covariance matrix 

cv = 1/n*z*z';
% keyboard
%% 2. compute eigenvectors of covariance matrix

[Vp, Dp] = eig(cv);
% keyboard

%% 3. Sort eigenvectors -> principal components

[V, D] = eigsort(Vp,Dp);
% keyboard

%% 4. transform using principal components

C = V'*z; %rows of V' are the principal components of z

subplot(1,2,2);
scatter(C(1,:),C(2,:),200,'b','linewidth',3);
set(gca,'fontsize',20);
axis([-15 15 -15 15]);
title('Transformed Data');

%cov_C = 1/n*C*C'
% keyboard

%% 5. Reconstruct zero-meaned pattern z_hat
% fullly recover
V_r = V;
C_r = C;
z_hat = V_r*C_r;

% recover using V1
V_r1 = V(:,1);
C_r1 = C(1,:);
z_hat1 = V_r1*C_r1;

% recover Using V2
V_r2 = V(:,2);
C_r2 = C(2,:);
z_hat2 = V_r2*C_r2;
%% 5 Reconstruct x_hat

figure(3)
subplot(2,2,1)
scatter(x,y,'b')  % original
set(gca,'fontsize',20);
title('Original Data');
set(gca,'fontsize',20);
axis([-15 15 -15 15]);

subplot(2,2,2)
scatter(z_hat(1,:),z_hat(2,:)); % full recovered
set(gca,'fontsize',20);
title('Fully recovered');
axis([-15 15 -15 15]);


subplot(2,2,3)
scatter(x,y,'b')  % orginal
hold on
scatter(z_hat1(1,:),z_hat1(2,:),'r'); % recover using V1
set(gca,'fontsize',20);
title('Recover Using V1');
axis([-15 15 -15 15]);

subplot(2,2,4);
scatter(x,y,'b')  % orginal
hold on
scatter(z_hat2(1,:),z_hat2(2,:),'g'); % recover using V2
set(gca,'fontsize',20);
title('Recover Using V2');
axis([-15 15 -15 15]);
