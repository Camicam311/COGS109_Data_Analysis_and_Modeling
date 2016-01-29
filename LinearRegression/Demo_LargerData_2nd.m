
%check:
%2nd order linear regression of weight-mpg in Data_week1.mat;
%10/07/2014 Crane

clear
close all

load Data_week1

%% plot raw data
figure;
scatter(weight,mpg,200,'filled');
set(gca,'fontsize',20);
xlabel('Car Weight');
ylabel('MPG');
hold on
%% 2nd order model
y = mpg';
x_test = min(weight)-500:max(weight)+500; 
%uncomment following lines, after filling the blanks with your answers of SA1:

A = [weight.^2',weight',ones(length(weight)s,1)]; %fill this
w = A\y;

A_test= [x_test.^2',x_test',ones(length(x_test),1)]; %fill this
y_test = A_test*w;%fill this

plot(x_test,y_test,'r','linewidth',2);
