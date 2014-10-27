
% model 4
load test_minentest4;
x = randn(2000000,2);

vXEdge = linspace(-5,5,70);
vYEdge = linspace(-5,5,70);
xHist2d = hist2d(x,vYEdge,vXEdge);
 
nXBins = length(vXEdge);
nYBins = length(vYEdge);
vXLabel = 0.5*(vXEdge(1:(nXBins-1))+vXEdge(2:nXBins));
vYLabel = 0.5*(vYEdge(1:(nYBins-1))+vYEdge(2:nYBins));

Sigma = [1 0; 0 .1]; R1 = chol(Sigma);
Sigma = [.1 0; 0 1]; R2 = chol(Sigma);
y = [randn(1000000,2)*R1 ; randn(1000000,2)*R2];

vXEdge = linspace(-5,5,70);
vYEdge = linspace(-5,5,70);
yHist2d = hist2d(y,vYEdge,vXEdge);

figure;
ha = tight_subplot(2,2,.1,.1,.1)
axes(ha(2));
contour(vXLabel, vYLabel,xHist2d);
axis([-2 2 -2 2])
axis square; axis off

axes(ha(1));
contour(vXLabel, vYLabel,yHist2d);
axis([-2 2 -2 2])
axis square; axis off

axes(ha(3))
b(1,1) = sum(squeeze(pm0(1,1,:))<.05)/reps;
b(2,1) = sum(squeeze(pm0(1,2,:))<.05)/reps;
b(3,1) = sum(squeeze(pm0(1,3,:))<.05)/reps;

b(1,2) = sum(squeeze(pk0(1,1,:))<.05)/reps;
b(2,2) = sum(squeeze(pk0(1,2,:))<.05)/reps;
b(3,2) = sum(squeeze(pk0(1,3,:))<.05)/reps;

bar(b,1,'grouped'); box off; hold on
axis([get(gca,'xlim') 0 .1]);
set(gca,'xticklabel',[30 50 100],'ytick',0:.02:.1,'tickdir','out');
plot(get(gca,'xlim'),[0.05 .05],'k--');

axes(ha(4))
b(1,1) = sum(squeeze(pm1(1,1,:))<.05)/reps;
b(2,1) = sum(squeeze(pm1(1,2,:))<.05)/reps;
b(3,1) = sum(squeeze(pm1(1,3,:))<.05)/reps;

b(1,2) = sum(squeeze(pk1(1,1,:))<.05)/reps;
b(2,2) = sum(squeeze(pk1(1,2,:))<.05)/reps;
b(3,2) = sum(squeeze(pk1(1,3,:))<.05)/reps;

bar(b,1,'grouped'); box off; hold on
axis([get(gca,'xlim') 0 1]);
set(gca,'xticklabel',[30 50 100],'ytick',0:.2:1,'tickdir','out');
plot(get(gca,'xlim'),[0.05 .05],'k--');
