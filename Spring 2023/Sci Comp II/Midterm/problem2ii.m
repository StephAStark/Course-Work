% Stephanie Klumpe
% Midterm
% Problem 2ii

clear
close all
clc

L = 50;               % interval length
N = 25;               % discretization

[D,cx] = cheb(N);      % cheb matrix
D2 = D^2;             % second order
dt =  1/N^2;

x = 5*cx';              % More initializing
tmax = 1;
tplot = .025;

u = zeros(size(x));        % Define the intitial condition u(0,x)=0
uold = zeros(size(x-dt));

plotgap = round(tplot/dt);
dt = tplot/plotgap;
nplots = round(tmax/tplot);
plotdata = [u; zeros(nplots,N+1)];
tdata = 0;
clf, drawnow,

for i = 1:nplots
    t = dt*i*plotgap;     % Define the time steps used for the left BC

    for n = 1:plotgap
        w = (D2*u')';       % Use cheb matrix not chebfft for easier BC
        w(1) = 0;
        w(N+1) = 0;

        unew = 2*u - uold + dt^2*w;
        uold = u;
        u = unew;

        u(1) = 1;       % BC
        u(end) = 0;

    end
    plotdata(i+1,:) = u;
    tdata = [tdata; dt*i*plotgap];

end

% Plot results:
clf, drawnow,
mesh(x,tdata,plotdata)
axis([-1 5 0 tmax -1 2]), grid on
colormap(jet); ylabel t, zlabel u,

print('-dpng', 'problem2ii.png')
