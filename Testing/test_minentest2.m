% Compare energy statistics with KS and parametric Hotelling
% prob_sr replicates Table 1 from 
% Szekely & Rizzo (2004) Testing for equal distributions in high dimensions
% See also 
% Baringhaus & Franz (2004) On a new multivariate two-sample test
% for Hotelling T^2 comparisons

n = [10 15 20 25 30 40 50 75 100];
delta = [0 .5 .75 1];
reps = 2000;
alpha = 0.1;
nboot = 500;

tic;
for i = 1:length(n)
   for j = 1:length(delta)
      for k = 1:reps
         x = randn(n(i),2);
         y = bsxfun(@plus,[0 delta(j)],randn(n(i),2));
         
         pval_az(i,j,k) = minentest(x,y,'az',nboot);
         pval_sr(i,j,k) = minentest(x,y,'sr',nboot);
         pval_T2(i,j,k) = hotell2(x,y);
         pval_ks(i,j,k) = kstest2d(x,y);
      end
      prob_az(i,j) = sum(squeeze(pval_az(i,j,:))<alpha)/reps;
      prob_sr(i,j) = sum(squeeze(pval_sr(i,j,:))<alpha)/reps;
      prob_T2(i,j) = sum(squeeze(pval_T2(i,j,:))<alpha)/reps;
      prob_ks(i,j) = sum(squeeze(pval_ks(i,j,:))<alpha)/reps;
   toc
   end
end

%% Plot
% Table 1 from 
% Szekely & Rizzo (2004) Testing for equal distributions in high dimensions
sr_table1 = [...
10 10 10 12 23 19 40 29 58 42 ;...
15 15 9 11 30 21 53 34 75 52 ;...
20 20 10 12 37 23 64 38 86 58 ;...
25 25 10 11 43 25 73 42 93 65 ;...
30 30 10 11 48 25 81 47 96 70 ;...
40 40 11 10 59 28 90 52 99 78 ;...
50 50 10 11 69 29 95 58 100 82 ;...
75 75 10 11 85 37 99 69 100 93 ;...
100 100 10 10 92 40 100 79 100 100];

sr_table1(:,[1 2 4 6 8 10]) = [];

figure; hold on
plot(n,prob_ks,'s');
plot(n,prob_T2,':');
plot(n,prob_az,'--');
plot(n,prob_sr,'-');
set(gca,'xscale','log')
set(gca,'tickdir','out')
set(gca,'xtick',n);
plot(n,sr_table1./100,'o','markersize',12,'markerfacecolor','w');

% load('test_minentest2_1');
% prob_az1 = prob_az;
% prob_sr1 = prob_sr;
% prob_T21 = prob_T2;
% reps1 = reps;
% 
% load('test_minentest2_2');
% prob_az2 = prob_az;
% prob_sr2 = prob_sr;
% prob_T22 = prob_T2;
% reps2 = reps;
% 
% load('test_minentest2_3');
% prob_az3 = prob_az;
% prob_sr3 = prob_sr;
% prob_T23 = prob_T2;
% prob_ks3 = prob_ks;
% reps3 = reps;
% 
% load('test_minentest2_4');
% prob_ks4 = prob_ks;
% reps4 = reps;
% 
% reps = reps1 + reps2 + reps3;
% 
% prob_az = (reps1/reps)*prob_az1 + (reps2/reps)*prob_az2 + (reps3/reps)*prob_az3;
% prob_sr = (reps1/reps)*prob_sr1 + (reps2/reps)*prob_sr2 + (reps3/reps)*prob_sr3;
% prob_T2 = (reps1/reps)*prob_T21 + (reps2/reps)*prob_T22 + (reps3/reps)*prob_T23;
% prob_ks = (reps3/(reps3+reps4))*prob_ks3 + (reps4/(reps3+reps4))*prob_ks4;
% 
% figure; hold on
% %plot(n,prob_ks,'s');
% plot(n,prob_T2,':');
% plot(n,prob_az,'--');
% plot(n,prob_sr,'-');
% set(gca,'xscale','log')
% set(gca,'tickdir','out')
% set(gca,'xtick',n);
% plot(n,sr_table1./100,'o','markersize',12,'markerfacecolor','w');
% 
