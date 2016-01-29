% 10/14/2014 Crane 
%% code for perceptron learning simple case
clear
close all

%% import data
x = [-3 3 -1 2.5];
y = [2 4 -2 -1.5];
target= [-1 1 -1 1];

%% initialize the learning algorithm
w1 = 1;
w2 = -1;
b = 3;

%% Perceptron learning
N = length(x); %number of datapoints
M = 200; %maximum number of iteration 

x_test = -4:4;

NumberofIteration = M;
eta =1;        
for iter = 1:M
    err_id=[];   
    y_test = (-w1*x_test-b)/w2;
    
    figure(1);
    clf
    scatter(x(target==-1),y(target==-1),200,'g','filled');
    hold on
    scatter(x(target==1),y(target==1),200,'r','filled');
    plot(x_test,y_test,'k','linewidth',2);
    set(gca,'fontsize',20);
    title('Perceptron learning');
    xlim([-5 5]);
    ylim([-5 5]);
    
    for i = 1:N
        thd=w1*x(i)+w2*y(i)+b;

        if thd>=0
            output(i) = 1;
        else
            output(i) = -1;
        end

        if output(i)==target(i)
            incorrect(i) = 0;
        else
            incorrect(i) = 1;
            err_id=[err_id i];
        end
    end
    
    if any(err_id)     
        %plot misclassifed points
        scatter(x(err_id),y(err_id),700,'k','linewidth',2);
        %update weights     
        w1=w1+eta*(target(err_id(1))-output(err_id(1)))*x(err_id(1));
        w2=w2+eta*(target(err_id(1))-output(err_id(1)))*y(err_id(1));
        b = b+eta*(target(err_id(1))-output(err_id(1)));
        %
    else
        set(gca,'fontsize',20);
        title(sprintf('Found solution: w1 = %.2f, w2=%.2f, b = %.2f',w1,w2,b));
        NumberofIteration = iter %number of iteration to find the solution
        break
    end
 
    if iter==M
        set(gca,'fontsize',20);
        title(sprintf('No solution found in %d iterations!',M));
    end
end
