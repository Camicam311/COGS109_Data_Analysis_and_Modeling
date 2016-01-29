%10/26/2014 One Layer Neural Network using sigmoid function

%% code for perceptron learning simple case
clear
close all

%% import data
load perceptron_data

% load dbmoon_1
% x = data(:,1);
% y = data(:,2);
% target = data(:,3);
% target(target==0) = -1;


x1 = x;
x2 = y;
y = [];
x_test = -10:10;

N = length(x1); %number of datapoints
%% initialize the learning algorithm
w1 = 1;
w2 = 1;
b = 1;

eta = .1; %learning rate
M = 2000; %maximum number of iteration 

%% train the network
for iter = 1:M
    net = w1*x1+w2*x2+b; 
    y = 1./(1+exp(-net));
    %compute gradients
    g_w1 = sum((y-target).*y.*(1-y).*x1);
    g_w2 = sum((y-target).*y.*(1-y).*x2);
    g_b = sum((y-target).*y.*(1-y));

    w1 = w1-eta*g_w1;
    w2 = w2-eta*g_w2;
    b  = b-eta*g_b;
   
    
    figure(100);
    clf;
    subplot(2,2,1);
    scatter(x1(target==-1),x2(target==-1),200,'b','filled');
    hold on
    scatter(x1(target==1),x2(target==1),200,'r','filled');
    set(gca,'fontsize',20);
    title('Nerual Network -data');
%     if iter==1
%     keyboard;
%     end
    subplot(2,2,2);
    scatter(x1,x2,200,y,'filled');
    set(gca,'fontsize',20);
    title('Nerual Network -model');
 
    if g_w1^2+g_w2^2+b^2<.5 %G is sufficiently small
        break
    end
    
    ot(y>=.5)=1;
    ot(y<.5) = -1;
    
    E = sum((ot-target).^2);
    
    figure(200);
%     if iter==1
%         keyboard;
%     end
    scatter(iter,E,200,'filled');hold on;
    set(gca,'fontsize',20);
    title('Sum of Squared Error (SSE)');
end


%% test data
x1_test = [-6 0  0 9];
x2_test = [3 -10 1 3];

figure(100);
subplot(2,2,3);
scatter(x1_test,x2_test,400,'k');
hold on
scatter(x1(target==-1),x2(target==-1),200,'b','filled');
hold on
scatter(x1(target==1),x2(target==1),200,'r','filled');
set(gca,'fontsize',20);
title('Add test data');

%% predict test output
net = w1*x1_test+w2*x2_test+b; 
y_test = 1./(1+exp(-net));

output(y_test>=.5)=1;
output(y_test<.5) = -1;

figure(100);
subplot(2,2,4);
scatter(x1(target==-1),x2(target==-1),200,'b','filled');
hold on
scatter(x1(target==1),x2(target==1),200,'r','filled');
scatter(x1_test(output==-1),x2_test(output==-1),200,'b','filled');
scatter(x1_test(output==1),x2_test(output==1),200,'r','filled');
% scatter(x1_test,x2_test,200,y_test,'filled');
scatter(x1_test,x2_test,400,'k');
set(gca,'fontsize',20);
hold on
title('Model-test result');
