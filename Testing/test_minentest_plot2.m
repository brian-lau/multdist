
fnames = {'test_minentest' 'test_minentest2' 'test_minentest3'};

temp_pm0 = [];
temp_pm1 = [];
temp_pk0 = [];
temp_pk1 = [];
temp_reps = 0;
for i = 1:length(fnames)
   load(fnames{i});
   
   temp_pm0 = cat(3,temp_pm0,pm0);
   temp_pm1 = cat(3,temp_pm1,pm1);
   temp_pk0 = cat(3,temp_pk0,pk0);
   temp_pk1 = cat(3,temp_pk1,pk1);
   temp_reps = temp_reps + reps;
end
clear pm0 pm1 pk0 pk1 reps;
pm0 = temp_pm0;
pm1 = temp_pm1;
pk0 = temp_pk0;
pk1 = temp_pk1;
reps = temp_reps;

model = 3;
len = 5000000;
x = randn(len,2);

vXEdge = linspace(-5,5,70);
vYEdge = linspace(-5,5,70);
xHist2d = hist2d(x,vYEdge,vXEdge);
 
nXBins = length(vXEdge);
nYBins = length(vYEdge);
vXLabel = 0.5*(vXEdge(1:(nXBins-1))+vXEdge(2:nXBins));
vYLabel = 0.5*(vYEdge(1:(nYBins-1))+vYEdge(2:nYBins));

if model == 1
   y = log(abs(randn(len,2)));
   xy = [-2.25 2.25 -2.25 2.25];
elseif model == 2
   Sigma = [1 .6; .6 1]; R = chol(Sigma);
   y = randn(len,2)*R;
   xy = [-2.25 2.25 -2.25 2.25];
elseif model == 3
   y = trnd(2,len,2);
   xy = [-2.25 2.25 -2.25 2.25];
end
vXEdge = linspace(-5,5,70);
vYEdge = linspace(-5,5,70);
yHist2d = hist2d(y,vYEdge,vXEdge);

figure;
ha = tight_subplot(2,2,.1,.1,.1)
axes(ha(2));
contour(vXLabel, vYLabel,xHist2d);
axis(xy)
axis square; axis off

axes(ha(1));
contour(vXLabel, vYLabel,yHist2d);
axis(xy)
axis square; axis off

axes(ha(3));
b(1,1) = sum(squeeze(pm0(model,1,:))<.05)/reps;
b(2,1) = sum(squeeze(pm0(model,2,:))<.05)/reps;
b(3,1) = sum(squeeze(pm0(model,3,:))<.05)/reps;

b(1,2) = sum(squeeze(pk0(model,1,:))<.05)/reps;
b(2,2) = sum(squeeze(pk0(model,2,:))<.05)/reps;
b(3,2) = sum(squeeze(pk0(model,3,:))<.05)/reps;

bar(b,1,'grouped'); box off; hold on
axis([get(gca,'xlim') 0 .1]);
set(gca,'xticklabel',[30 50 100],'ytick',0:.02:.1,'tickdir','out');
plot(get(gca,'xlim'),[0.05 .05],'k--');

axes(ha(4))
b(1,1) = sum(squeeze(pm1(model,1,:))<.05)/reps;
b(2,1) = sum(squeeze(pm1(model,2,:))<.05)/reps;
b(3,1) = sum(squeeze(pm1(model,3,:))<.05)/reps;

b(1,2) = sum(squeeze(pk1(model,1,:))<.05)/reps;
b(2,2) = sum(squeeze(pk1(model,2,:))<.05)/reps;
b(3,2) = sum(squeeze(pk1(model,3,:))<.05)/reps;

bar(b,1,'grouped'); box off; hold on
axis([get(gca,'xlim') 0 1]);
set(gca,'xticklabel',[30 50 100],'ytick',0:.2:1,'tickdir','out');
plot(get(gca,'xlim'),[0.05 .05],'k--');
