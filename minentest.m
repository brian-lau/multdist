% minentest                  N-dimensional, 2-sample comparison of 2 distributions
% 
%     [p,phi_nm] = minentest(x,y,nboot);
%
%     Compares d-dimensional data from two samples using a measure based on
%     statistical energy. The test is non-parametric, does not require binning
%     and easily scales to arbitrary dimensions.
%
%     The analytic distribution of the statistic is unknown, and p-values
%     are estimated using a permutation procedure, which works well
%     according to simulations by Aslan & Zech.
%
%     INPUTS
%     x - [n1 x d] matrix
%     y - [n2 x d] matrix
%
%     OUTPUTS
%     p - p-value by permutation
%     D - minimum energy statistic
%
%     REFERENCE
%     Aslan, B, Zech, G (2005) Statistical energy as a tool for binning-free
%       multivariate goodness-of-fit tests, two-sample comparison and unfolding.
%       Nuc Instr and Meth in Phys Res A 537: 626-636
%
%     SEE ALSO
%     kstest2d

%     $ Copyright (C) 2014 Brian Lau http://www.subcortex.net/ $
%     The full license and most recent version of the code can be found on GitHub:
%     https://github.com/brian-lau/multdist
%
%     This program is free software: you can redistribute it and/or modify
%     it under the terms of the GNU General Public License as published by
%     the Free Software Foundation, either version 3 of the License, or
%     (at your option) any later version.
% 
%     This program is distributed in the hope that it will be useful,
%     but WITHOUT ANY WARRANTY; without even the implied warranty of
%     MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%     GNU General Public License for more details.
% 
%     You should have received a copy of the GNU General Public License
%     along with this program.  If not, see <http://www.gnu.org/licenses/>.
%
%     REVISION HISTORY:
%     brian 08.25.11 written

function [p,e_nm] = minentest(x,y,flag,nboot,replace)

% with or without replacement
% with, calculate distance matrix once and cache, permute index
if nargin < 5
   replace = false;
end

if nargin < 4
   nboot = 1000;
end

if nargin < 3
   flag = 'sr';
end

n = size(x,1);
m = size(y,1);

[e_nm,dx,dy,dxy] = energy(x,y,flag);
e_nm_boot = zeros(nboot,1);
pooled = [x ; y];

if replace
   for i = 1:nboot
      ind = randperm(n+m);
      e_nm_boot(i) = energy(pooled(ind(1:n),:),pooled(ind(n+1:end),:),flag);
   end
else
   for i = 1:nboot
      ind = randperm(n+m);
      e_nm_boot(i) = energy(pooled(ind(1:n),:),pooled(ind(n+1:end),:),flag);
   end
end

p = sum(e_nm_boot>e_nm)./nboot;

function [dx,dy,dxy] = dist(x,y)
dx = pdist(x,'euclidean');
dy = pdist(y,'euclidean');
dxy = pdist2(x,y,'euclidean');

function [z,dx,dy,dxy] = energy(x,y,flag)
% FIXME, equal samples will generate infinite values, will produce
% unreliable results, more of a problem for discrete data.
n = size(x,1);
m = size(y,1);
[dx,dy,dxy] = dist(x,y);
switch flag
   case 'az'
      % Aslan & Zech definition of energy statistic 
      z = (1/(n*(n-1)))*sum(-log(dx)) + (1/(m*(m-1)))*sum(-log(dy))...
         - (1/(n*m))*sum(-log(dxy(:)));
   case 'sr'
      % Szekely & Rizzo definition of energy statistic
      % Verified against their R package 'energy'
      % in R:
      %   data(iris)
      %   eqdist.etest(iris[,1:4], c(75,75), R = 199)
      %   E-statistic = 126.0453, p-value = 0.005
      % in Matlab:
      %   load fisheriris;
      %   [p,en] = minentest(meas(1:75,:),meas(76:end,:),'sr')
      z = (2/(n*m))*sum(dxy(:)) - (1/(n^2))*sum(2*dx) - (1/(m^2))*sum(2*dy);
      z = ((n*m)/(n+m)) * z;
   otherwise
      error('Bad FLAG');
end