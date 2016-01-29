%% check overfitting of 1st, 3rd and 6th order linear model of xy.mat data
close all
clear

load xy

N = length(x);

whichorder = 1; %indicate which order model you would like to check

%initialize error
t_err1=0;
t_err3=0;
t_err6=0;


figure;
for i = 1:N
    xleftout = x(i);%leave out one data point at a time
    subplot(2,4,i);
    scatter(xleftout, y(i),500,'b','linewidth',3);
    if i==1 %leave out the first one
        xuse = x(2:N);
        yuse = y(2:N);
    elseif i==N %leave out the last one
        xuse = x(1:N-1);
        yuse = y(1:N-1);
    else %leave out datapoint in between
        xuse = x([1:i-1, i+1:N]);
        yuse = y([1:i-1, i+1:N]);
    end
    hold on
    scatter(xuse,yuse,500,'b','filled');
    xlim([-.5 6.5]);
    ylim([-20 45]);
    set(gca,'fontsize',20);
    hold on
    %% ------------compute A matrix---------------- %%
    
    %%compute the A matrix for 1st order fit
    A1=[xuse ones(length(xuse),1)];
    
    %%compute the A matrix for 3nd order fit
    A3=[xuse.^3 xuse.^2 xuse ones(length(xuse),1)];
    
    %%compute the A matrix for 6th order fit
    A6=[xuse.^6 xuse.^5 xuse.^4  xuse.^3 xuse.^2 xuse ones(length(xuse),1)];
    
    %% ------------solve parameters---------------- %%
    %%solve for 1st orderfit
    w1=A1\yuse;
    w3=A3\yuse;
    w6=A6\yuse;
    
    %% ------------Visualize model prediction ---------------- %%
    x_test = -1:.1:6.5;
    x_test = x_test';
    
    %%compute the A_test matrix, and y1_test for 1st order fit
    A1_test=[x_test ones(length(x_test),1)];
    y1_test = A1_test*w1;
    
    %%compute the A_test matrix for 2nd order fit (make it red)
    A3_test=[x_test.^3 x_test.^2 x_test ones(length(x_test),1)];
    y3_test = A3_test*w3;
    
    %%compute the A_test matrix for 5th order fit (make it green)
    A6_test=[x_test.^6 x_test.^5 x_test.^4 x_test.^3 x_test.^2 x_test ones(length(x_test),1)];
    y6_test = A6_test*w6;
    
    if whichorder==1
        plot(x_test,y1_test,'k','linewidth',2); %plot the model fit for (xuse,yuse)
    elseif whichorder ==3
        plot(x_test,y3_test,'r','linewidth',2); %plot the model fit for (xuse,yuse)
    else
        plot(x_test,y6_test,'g','linewidth',2); %plot the model fit for (xuse,yuse)
    end
    
    %% ------------compute yleftout ---------------- %%
    %%yleftout for 1st order fit
    yleftout1=[xleftout 1]*w1;
    
    %%yleftout for 3rd order fit
    yleftout3=[xleftout^3 xleftout^2 xleftout 1]*w3;
    
    %%yleftout for 6th order fit
    yleftout6=[xleftout^6 xleftout^5 xleftout^4 xleftout^3 xleftout^2 xleftout 1]*w6;
    
    %% ------------compute squared error for leftout point ---------------- %%
    
    %%square error for 1st order fit
    sqerr1 = (yleftout1-y(i))^2;
    
    %%square error for 3rd order fit
    sqerr3 = (yleftout3-y(i))^2;
    
    %%square error for 6th order fit
    sqerr6 = (yleftout6-y(i))^2;
    
    
    %% add error to the total error
    
    %%total error for 1st order fit
    t_err1=t_err1+sqerr1;
    
    %%total error for 3rd order fit
    t_err3=t_err3+sqerr3;
    
    %%total error for 6th order fit
    t_err6=t_err6+sqerr6;   
    
    if whichorder==1
        scatter(xleftout,yleftout1,500,'k','linewidth',3); %plot the model fit for (xuse,yuse)
    elseif whichorder ==3
        scatter(xleftout,yleftout3,500,'r','linewidth',3); %plot the model fit for (xuse,yuse)
    else
        scatter(xleftout,yleftout6,500,'g','linewidth',3); %plot the model fit for (xuse,yuse)
    end
    
    
    if whichorder==1
        title(sprintf('Test err = %.2f',sqerr1));
        
    elseif whichorder ==3
        title(sprintf('Test err = %.2f',sqerr3));
        
    elseif whichorder==6
        title(sprintf('Test err = %.2f',sqerr6));
    end
    pause(.5)
end

if whichorder==1
    legend(sprintf('Total Test Error for 1st order fit: %.2f',t_err1));
elseif whichorder ==3
    legend(sprintf('Total Test Error for 3rd order fit: %.2f',t_err3));
else
    legend(sprintf('Total Test Error for 6th order fit: %.2f',t_err6));
end

