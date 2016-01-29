% L = 200; % number of data points
% % generate data for example
% C = [1 2 -1; 2 2 1; -2 0 2];
% X = C * randn (3 , L );
load 3D_data

%% plot original 3D data
figure(1);
subplot(2,3,1);
plot3(X(1,:), X(2,:),X(3,:), 'b.');
grid
box on
m = max (abs(X(:)));
ax = [ -1 1 -1 1 -1 1]* m ;
axis ( ax );
set (gca ,'Projection','perspective');
set(gca,'fontsize',20);
% xlabel('X');
% ylabel('Y');
% zlabel('Z');
% title('Original Data');
keyboard

%% 1. compute the covariance matrix 
n = length(X);
cv = 1/n*X*X';

%% 2. compute eigenvectors of covariance matrix

[Vp, Dp] = eig(cv);

%% 3. Sort eigenvectors

[V, D] = eigsort(Vp,Dp);

subplot(2,3,2);

p0=[0,0,0];
hold on
vectarrow(p0,2*sqrt(D(1,1))*V(:,1)','r');

hold on

vectarrow(p0,1.5*sqrt(D(2,2))*V(:,2)','g');

hold on

vectarrow(p0,sqrt(D(3,3))*V(:,3)','k');
hold on

plot3(X(1,:),X(2,:),X(3,:),'b.');
grid
box on
set(gca,'Projection','perspective');
axis ( ax );
set(gca,'fontsize',20);
% xlabel('X');
% ylabel('Y');
% zlabel('Z');
% title('Eigenvectors of covariance');
keyboard
%% 4. compute principal components

C = V'*X;
figure(1);
subplot(2,3,3);
plot3(C(1,:),C(2,:),C(3,:),'b.');
grid
box on
set(gca,'Projection','perspective');
set(gca,'fontsize',20);
axis ( ax );

hold on
point0 = [0 0 0];
normal0 = [0,0,1]';
d0 = -point0*normal0; %'# dot product for less typing
[xx0,yy0]=ndgrid(-8:8,-8:8);


%# calculate corresponding z
z0 = (-normal0(1)*xx0 - normal0(2)*yy0 - d0)/normal0(3);
h0 = surf(xx0,yy0,z0);
set(h0,'FaceColor',[1 0 0 ], 'FaceAlpha',.5);
set(gca,'Projection','perspective');
% title('Transformed Data');
% xlabel('V1');
% ylabel('V2');
% zlabel('V3');
keyboard
subplot(2,3,4);
plot3(C(1,:),C(2,:),C(3,:),'b.');
grid
box on
set(gca,'Projection','perspective');
set(gca,'fontsize',20);
axis ( ax );

hold on
point0 = [0 0 0];
normal0 = [0,0,1]';
d0 = -point0*normal0; %'# dot product for less typing
[xx0,yy0]=ndgrid(-8:8,-8:8);

%# calculate corresponding z
z0 = (-normal0(1)*xx0 - normal0(2)*yy0 - d0)/normal0(3);
h0 = surf(xx0,yy0,z0);
set(h0,'FaceColor',[1 0 0 ], 'FaceAlpha',.5);
set(gca,'Projection','perspective');



% title('Transformed Data');
% xlabel('V1');
% ylabel('V2');
% zlabel('V3');
% 
plot3(C(1,:),C(2,:),zeros(1,200),'r.');

keyboard
%% 8. Reconstruct zero-meaned pattern z_hat

% recover using V1
V_r1 = V(:,1);
c_r1 = C(1,:);
z_hat1 = V_r1*c_r1;

% recover Using V2
V_r2 = V(:,2);
c_r2 = C(2,:);
z_hat2 = V_r2*c_r2;

% recover Using V1 and V2
V_r12 = V(:,1:2);
c_r12 = C(1:2,:);
z_hat12 = V_r12*c_r12;
%% 5 Reconstruct x_hat

subplot(2,3,5);

%with eigenvector
% p0=[0,0,0];
% hold on
% vectarrow(p0,2*sqrt(D(1,1))*V(:,1)','r');
% hold on
% vectarrow(p0,1.5*sqrt(D(2,2))*V(:,2)','g');
% hold on
% vectarrow(p0,sqrt(D(3,3))*V(:,3)','k');
% hold on


plot3(X(1,:),X(2,:),X(3,:),'b.');
hold on
% plot3(z_hat12(1,:),z_hat12(2,:),z_hat12(3,:),'r.');
grid
box on
set(gca,'Projection','perspective');
axis(ax);
hold on
set(gca,'fontsize',20);
% title('Reduce to 2D');

%draw V1-V2 2D plane:
point = [0 0 0];
normal = V(:,3);
d = -point*normal; %'# dot product for less typing
[xx,yy]=ndgrid(-5:5,-5:5);

%# calculate corresponding z
z = (-normal(1)*xx - normal(2)*yy - d)/normal(3);
h = surf(xx,yy,z);
set(h,'FaceColor',[1 0 0 ], 'FaceAlpha',.5);
set(gca,'Projection','perspective');
% xlabel('X');
% ylabel('Y');
% zlabel('Z');

% keyboard

plot3(z_hat12(1,:),z_hat12(2,:),z_hat12(3,:),'r.','linewidth',3);
