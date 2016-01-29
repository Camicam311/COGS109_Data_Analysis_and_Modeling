clear
close all

%% create data
x1 = [2 2 3 3];
y1 = [4 5 4 5];

x2 = [5   5   6   6  ];
y2 = [4.5 5.5 4.5 5.5];

x3 = [3.5  3.5 4.5 4.5];
y3 = [ .5  1.5  .5 1.5];

x = [x1, x2, x3];
y = [y1, y2, y3];

N = length(x);  %sample size
M = 100;        %maximum number of iterations

% visualize the data
figure;
scatter(x,y,200,'filled','k');hold on;
xlim([1 7]);
ylim([0 6]);
set(gca,'fontsize',20);

keyboard
%% Step 1: initiate the algorithem
% randomly choose 3 centers
k_x0 = [2 4 6];
k_y0 = [3 3 3];

h1 = plot(k_x0(1),k_y0(1),'x','linewidth',3,'markersize',30,'color','r');
h2 = plot(k_x0(2),k_y0(2),'x','linewidth',3,'markersize',30,'color','b');
h3 = plot(k_x0(3),k_y0(3),'x','linewidth',3,'markersize',30,'color','g');

pause;

k_x(1,:) = k_x0;
k_y(1,:) = k_y0;

for n = 2:M
    %% Step 2: assign each data point to its cloest center
    for k = 1:3 %compute distance to each center for each data point
        d(:,k) = sqrt((x-k_x(n-1,k)).^2+(y-k_y(n-1,k)).^2);  
    end

    for i = 1:N
        [~,g(i)] = min(d(i,:)); %Group to the category with the shortest distance
    end

    %visualize the grouping
    if n>2
        delete(v1,v2,v3);
    end
    v1=scatter(x(g==1),y(g==1),200,'filled','r');
    v2=scatter(x(g==2),y(g==2),200,'filled','b');
    v3=scatter(x(g==3),y(g==3),200,'filled','g');
    pause;
   
    %% Step 3: compute the new center
    for k = 1:3
        k_x(n,k) = mean(x(g==k));
        k_y(n,k) = mean(y(g==k));
    end

    %visualize the new center
    delete(h1);delete(h2);delete(h3);
    h1 = plot(k_x(n,1),k_y(n,1),'x','linewidth',3,'markersize',30,'color','r');
    h2 = plot(k_x(n,2),k_y(n,2),'x','linewidth',3,'markersize',30,'color','b');
    h3 = plot(k_x(n,3),k_y(n,3),'x','linewidth',3,'markersize',30,'color','g');

    %% Repeat step 2 and 3
    if n>1 && sum((k_x(n,:)-k_x(n-1,:)))==0 && sum((k_y(n,:)-k_y(n-1,:)))==0
        title(sprintf('Find Solution in %d steps!',n-1));
        break
    end
    pause;
end