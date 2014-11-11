% Compare two distance metrics

n = [10 100];
delta = [0 .5 .75 1];
reps = 100;

tic;
for i = 1:length(delta)
   for j = 1:length(n)
      for k = 1:reps
         x = randn(n(j),2);
         y = bsxfun(@plus,[0 delta(i)],randn(n(j),2));
         
         p_az(i,j,k) = minentest(x,y,'az',500);
         p_sr(i,j,k) = minentest(x,y,'sr',500);
         
         % add T2 test
      end
   toc
   end
end

sum(squeeze(pm0_az(1,1,:))<.05)/reps
sum(squeeze(pm0_az(1,2,:))<.05)/reps
%sum(squeeze(pm0_az(1,3,:))<.05)/reps

sum(squeeze(pm0_sr(1,1,:))<.05)/reps
sum(squeeze(pm0_sr(1,2,:))<.05)/reps
%sum(squeeze(pm0_sr(1,3,:))<.05)/reps

sum(squeeze(pm1_az(1,1,:))<.05)/reps
sum(squeeze(pm1_az(1,2,:))<.05)/reps
%sum(squeeze(pm1_az(1,3,:))<.05)/reps

sum(squeeze(pm1_sr(1,1,:))<.05)/reps
sum(squeeze(pm1_sr(1,2,:))<.05)/reps
%sum(squeeze(pm1_sr(1,3,:))<.05)/reps

