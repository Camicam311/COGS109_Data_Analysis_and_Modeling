%10/06/2014 Crane

%% Please use this demo code to see the linear fit for following models:
% Demo1 : 1st order model y = w_1*x+w_0 for 3 datapoints (1,3), (2,5) and (3,4)
% Demo2 : 2nd order model y = w_2*x^2+w_1*x+w_0 for 3 data points (1,3), (2,5) and (3,4)

clear
close all

demo = 1; %change to "2" if you want to see Demo2

% input data:
x = [1 2 3]';
y = [3 5 4]';
n = length(x);

if demo ==1
    %% Step1: model
    % y = w_1*x+w_0;
    
    %% Step2: Put data in matrix form
    A = [x,ones(n,1)];
    
    %% Step3: Solve model in matrix form
    w = A\y;  %add ';' to suppress output to Command Window
    
    %% step4: Report model
    % y = w(1)x+w(2);
    
    %% Step5: visualize data
    % plot original data
    figure;
    scatter(x,y,200,'filled');
    xlim([0 4]);
    ylim([2 6]);
    hold on;
    set(gca,'fontsize',20);
    
    % plot model prediction
    x_test = min(x)-1:max(x)+1; %indicating x_test value, (flexible, as long as it covers 'x')
    A_test = [x_test',ones(length(x_test),1)];
    y_test = A_test*w; %computing y_test of x_test 
    
    plot(x_test,y_test,'k','linewidth',2); %Plot the regression line
    legend('Data','Model');
    title('1st order linear regression model');
elseif demo ==2
        
        %% Step1: model
        % y = w_2*x^2+w_1*x+w_0;
        
        %% Step2: Put data in matrix form
        A = [x.^2, x,ones(n,1)];
        
        %% Step3: Solve model in matrix form
        w = A\y;  %add ';' to supress output to Command Window
        
        %% step4: Report model
        % y = w(1)x^2+w(2)x+w(3);
        
        %% Step5: visualize data
        % plot original data
        figure;
        scatter(x,y,200,'filled');
        xlim([0 4]);
        ylim([2 6]);
        hold on;
        set(gca,'fontsize',20);
        
        % plot model prediction
        x_test = min(x)-1:.1:max(x)+1; %indicating x_test value (flexible, as long as it covers 'x')
        A_test = [x_test.^2',x_test',ones(length(x_test),1)];
        y_test = A_test*w; %computing y_test of x_test 
        
        plot(x_test,y_test,'g','linewidth',2); %Plot the regression line
        legend('Data','Model');
        title('2nd order linear regression model');
end
