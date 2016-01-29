close all
clear

%prior
p_weighted0 = .25;

%likelihood of observaing head given it's weighted
p_head_weighted = .8;
p_head_fair = .5;

p_tail_weighted = 1-p_head_weighted;
p_tail_fair = .5;

N = 20;
obs1 = ones(N,1); %all heads
obs2 = zeros(N,1); %all tails
obs3 = [1 1 0 0 1 1 1 0 1 1 1 1 1 0 1 1 1 1 1 1]; %mixed

obs = obs1;

figure;
subplot(1,2,1);
h=bar([p_weighted0,1-p_weighted0]);
set(gca,'fontsize',20);
set(gca,'xticklabel',{'weighted','fair'});
xlim([.5 2.5])
ylim([0 1]);
title('Probability');

subplot(1,2,2);
h1=bar([0,0]);
set(gca,'fontsize',20);
set(gca,'xticklabel',{'head','tail'});
xlim([.5 2.5]);
ylim([0 20]);
title('Coin Count');

for i = 1:N
 if i ==1
     p_weighted = p_weighted0;
 end
delete(h);
delete(h1);
%posterior
if obs(i)==1 %observe head
   p_weighted = p_head_weighted*p_weighted/(p_head_weighted*p_weighted...
    +p_head_fair*(1-p_weighted));

else   %observe tail
   p_weighted = p_tail_weighted*p_weighted/(p_tail_weighted*p_weighted...
    +p_tail_fair*(1-p_weighted));
end
subplot(1,2,1);
h=bar([p_weighted,1-p_weighted]);
set(gca,'fontsize',20);
set(gca,'xticklabel',{'weighted','fair'});
xlim([.5 2.5])
ylim([0 1]);
hold on;
title('Probability')

subplot(1,2,2);
h1=bar([sum(obs(1:i)),i-sum(obs(1:i))]);
set(gca,'fontsize',20);
set(gca,'xticklabel',{'head','tail'});
title('Coin Count');
xlim([.5 2.5])
ylim([0 20]);

pause(.5);
end

