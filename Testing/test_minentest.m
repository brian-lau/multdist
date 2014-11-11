%models = [1 2 3];
models = 4;
n = [30 50 100];
reps = 100;

tic;
for i = 1:length(models)
   for j = 1:length(n)
      for k = 1:reps
         x = randn(n(j),2);
         
         if models(i) == 1
            y1 = log(abs(randn(n(j),2)));
            y2 = log(abs(randn(n(j),2)));
         elseif models(i) == 2
            Sigma = [1 .6; .6 1]; R = chol(Sigma);
            y1 = randn(n(j),2)*R;
            y2 = randn(n(j),2)*R;
         elseif models(i) == 3
            y1 = trnd(2,n(j),2);
            y2 = trnd(2,n(j),2);
         elseif models(i) == 4
            Sigma = [1 0; 0 .1]; R1 = chol(Sigma);
            Sigma = [.1 0; 0 1]; R2 = chol(Sigma);
            y1 = [randn(n(j)/2,2)*R1 ; randn(n(j)/2,2)*R2];
            y2 = [randn(n(j)/2,2)*R1 ; randn(n(j)/2,2)*R2];
         end
         
         pm0(i,j,k) = minentest(y1,y2,'az',500);
         pm1(i,j,k) = minentest(x,y1,'az',500);

         pm0_2(i,j,k) = minentest(y1,y2,'sr',500);
         pm1_2(i,j,k) = minentest(x,y1,'sr',500);
         
         %pk0(i,j,k) = kstest2d2s(y1,y2);
         %pk1(i,j,k) = kstest2d2s(x,y1);
      end
   toc
   end
end

sum(squeeze(pm0(1,1,:))<.05)/reps
sum(squeeze(pm0(1,2,:))<.05)/reps
sum(squeeze(pm0(1,3,:))<.05)/reps

sum(squeeze(pm0_2(1,1,:))<.05)/reps
sum(squeeze(pm0_2(1,2,:))<.05)/reps
sum(squeeze(pm0_2(1,3,:))<.05)/reps

sum(squeeze(pm1(1,1,:))<.05)/reps
sum(squeeze(pm1(1,2,:))<.05)/reps
sum(squeeze(pm1(1,3,:))<.05)/reps

sum(squeeze(pm1_2(1,1,:))<.05)/reps
sum(squeeze(pm1_2(1,2,:))<.05)/reps
sum(squeeze(pm1_2(1,3,:))<.05)/reps

% sum(squeeze(pm0(1,1,:))<.05)/reps
% sum(squeeze(pm0(2,1,:))<.05)/reps
% sum(squeeze(pm0(3,1,:))<.05)/reps
% 
% sum(squeeze(pk0(1,1,:))<.05)/reps
% sum(squeeze(pk0(2,1,:))<.05)/reps
% sum(squeeze(pk0(3,1,:))<.05)/reps
% 
% sum(squeeze(pm0(1,2,:))<.05)/reps
% sum(squeeze(pm0(2,2,:))<.05)/reps
% sum(squeeze(pm0(3,2,:))<.05)/reps
% 
% sum(squeeze(pk0(1,2,:))<.05)/reps
% sum(squeeze(pk0(2,2,:))<.05)/reps
% sum(squeeze(pk0(3,2,:))<.05)/reps
% 
% sum(squeeze(pm0(1,3,:))<.05)/reps
% sum(squeeze(pm0(2,3,:))<.05)/reps
% sum(squeeze(pm0(3,3,:))<.05)/reps
% 
% sum(squeeze(pk0(1,3,:))<.05)/reps
% sum(squeeze(pk0(2,3,:))<.05)/reps
% sum(squeeze(pk0(3,3,:))<.05)/reps
% 
% 
% sum(squeeze(pm1(1,1,:))<.05)/reps
% sum(squeeze(pm1(2,1,:))<.05)/reps
% sum(squeeze(pm1(3,1,:))<.05)/reps
% 
% sum(squeeze(pk1(1,1,:))<.05)/reps
% sum(squeeze(pk1(2,1,:))<.05)/reps
% sum(squeeze(pk1(3,1,:))<.05)/reps
% 
% sum(squeeze(pm1(1,2,:))<.05)/reps
% sum(squeeze(pm1(2,2,:))<.05)/reps
% sum(squeeze(pm1(3,2,:))<.05)/reps
% 
% sum(squeeze(pk1(1,2,:))<.05)/reps
% sum(squeeze(pk1(2,2,:))<.05)/reps
% sum(squeeze(pk1(3,2,:))<.05)/reps
% 
% sum(squeeze(pm1(1,3,:))<.05)/reps
% sum(squeeze(pm1(2,3,:))<.05)/reps
% sum(squeeze(pm1(3,3,:))<.05)/reps
% 
% sum(squeeze(pk1(1,3,:))<.05)/reps
% sum(squeeze(pk1(2,3,:))<.05)/reps
% sum(squeeze(pk1(3,3,:))<.05)/reps
