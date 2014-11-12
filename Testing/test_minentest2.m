% Compare two distance metrics

n = [10 50];%[10 15 20 25 30 40 50 75 100];
delta = [0 .5];%[0 .5 .75 1];
reps = 10;
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
         
         % add T2 test
      end
      prob_az(i,j) = sum(squeeze(pval_az(i,j,:))<alpha)/reps;
      prob_sr(i,j) = sum(squeeze(pval_sr(i,j,:))<alpha)/reps;
   toc
   end
end
