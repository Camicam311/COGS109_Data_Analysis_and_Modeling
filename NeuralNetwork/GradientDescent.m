%demo code for gradient descent
clear
close all
x = -10:.1:10;
% equation:
y = (x-1).^2+3;
OptimalPoint = [1,3];

figure;
plot(x,y,'linewidth',3);
xlim([-10 10]);
ylim([-10 150]);
hold on;
set(gca,'fontsize',20);
legend('Error Function');
title('y = (x-1)^2+3');

scatter(OptimalPoint(1),OptimalPoint(2),300,'filled','r');
set(gca,'fontsize',20);
legend('Error Function','Optimal point');
% keyboard
%% Initiate the learning
x_old = -8; 
scatter(x_old,(x_old-1)^2+3,300,'filled','b');
% keyboard
%%
eta = .1; 
while 1
x_new = x_old - eta*2*(x_old-1); %Gradient Descent 
x_old = x_new;
scatter(x_old,(x_old-1)^2+3,300,'filled','b');
pause(1)
    if abs(x_old-OptimalPoint(1))<=.1
        break;
    end
end