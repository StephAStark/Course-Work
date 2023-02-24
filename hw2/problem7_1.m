% Stephanie Klumpe
% Problem 7.1 edited code

clear
close all
clc

  N = 16;
  [D,x] = cheb(N);        
  D2 = D^2;              
  D2 = D2(2:N,2:N);                   % boundary conditions
  f = exp(4*x(2:N));           
  u = D2\f;                           % Poisson eq. solved here
  u = [0;u;0];              
  clf, subplot('position',[.1 .4 .8 .5])
  plot(x,u,'.','markersize',16)
  xx = -1:.01:1;
  uu = polyval(polyfit(x,u,N),xx);    % interpolate grid data
  line(xx,uu)
  grid on
  exact = ( exp(4*xx) - sinh(4)*xx - cosh(4) )/16; 
  title(['max err = ' num2str(norm(uu-exact,inf))],'fontsize',12)

  %inva = 1./prod(x_j-x_k)
  %uu=

% M=length(data);     N=length(x);
% Compute the barycentric weights
% X=repmat(data(:,1),1,M);
% matrix of weights
% W=repmat(1./prod(X-X.'+eye(M),1),N,1);
% Get distances between nodes and interpolation points
% xdist=repmat(x,1,M)-repmat(data(:,1).',N,1);
% Find all of the elements where the interpolation point is on a node
% [fixi,fixj]=find(xdist==0);
% Use NaNs as a place-holder
% xdist(fixi,fixj)=NaN;
% H=W./xdist;
% Compute the interpolated polynomial
% p=(H*data(:,2))./sum(H,2);
% Replace NaNs with the given exact values. 
% p(fixi)=data(fixj,2);
