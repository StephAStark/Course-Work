clear
close all
clc
M=39;   %Comment out one of these 2 lines to test differnt grids
%M=38;
heat_CN(M);
function [h,k,error] = heat_CN(m)

clf              % clear graphics
hold on          % Put all plots on the same graph (comment out if desired)

ax = -1;
bx = 1;
kappa = .02;               % heat conduction coefficient:
tfinal = 1;                % final time

h = (bx-ax)/(m+1);         % h = delta x
x = linspace(ax,bx,m+2)';  % note x(1)=0 and x(m+2)=1
                           % u(1)=g0 and u(m+2)=g1 are known from BC's
k = 4*h;                   % Comment out one of these lines to test different time steps.
%k=(1/4)*h;

nsteps = round(tfinal / k);    % number of time steps
%nplot = 1;      % plot solution every nplot time steps
                 % (set nplot=2 to plot every 2 time steps, etc.)
nplot = nsteps;  % only plot at final time


% true solution for comparison:
utrue = @(x,t) 1/2 * erfc(x/(sqrt(4*kappa*t)));

% initial conditions:
u0 = utrue(x,0);


% Each time step we solve MOL system U' = AU + g using the Trapezoidal method

% set up matrices:
r = (1/2) * kappa* k/(h^2);
e = ones(m,1);
A = spdiags([e -2*e e], [-1 0 1], m, m);
A1 = eye(m) - r * A;
A2 = eye(m) + r * A;


% initial data on fine grid for plotting:
xfine = linspace(ax,bx,1001);
ufine = utrue(xfine,0);

% initialize u and plot:
tn = 0;
u = u0;

plot(x,u,'b.-', xfine,ufine,'r')
legend('computed','true')
title('Initial data at time = 0')

%input('Hit <return> to continue  ');


% main time-stepping loop:

for n = 1:nsteps
     tnp = tn + k;   % = t_{n+1}

     % boundary values u(0,t) and u(1,t) at times tn and tnp:

     g0n = u(1);
     g1n = u(m+2);
     g0np = utrue(ax,tnp);
     g1np = utrue(bx,tnp);

     % compute right hand side for linear system:
     uint = u(2:(m+1));   % interior points (unknowns)
     rhs = A2*uint;
     % fix-up right hand side using BC's (i.e. add vector g to A2*uint)
     rhs(1) = rhs(1) + r*(g0n + g0np);
     rhs(m) = rhs(m) + r*(g1n + g1np);

     % solve linear system:
     uint = A1\rhs;

     % augment with boundary values:
     u = [g0np; uint; g1np];

     % plot results at desired times:
     if mod(n,nplot)==0 || n==nsteps
        ufine = utrue(xfine,tnp);
        plot(x,u,'b.-', xfine,ufine,'r')
        title(sprintf('t = %9.5e  after %4i time steps with %5i grid points',...
                       tnp,n,m+2))
        error = max(abs(u-utrue(x,tnp)));
        disp(sprintf('at time t = %9.5e  max error =  %9.5e',tnp,error))
        if n<nsteps, input('Hit <return> to continue  '); 
        end
     end

     tn = tnp;   % for next time step
end
end
