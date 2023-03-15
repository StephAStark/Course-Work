% Stephanie Klumpe
% Problem 13.3 edited code

clear
close all
clc

  N = 80;
  [D,cx] = cheb(N);          % Initialize eveerything
  D2 = D^2;

  D2(N+1,:) = D(N+1,:);      % Set up Neumann BC at x=-1

  x = cx';
  dt = 8/N^2;                % More initializing
  tmax = 5;
  tplot = .025;

  v = zeros(size(x));        % Define the intitial condition v(0,x)=0
  vold = zeros(size(x-dt));

  plotgap = round(tplot/dt);
  dt = tplot/plotgap;
  nplots = round(tmax/tplot);
  plotdata = [v; zeros(nplots,N+1)];
  tdata = 0;
  clf, drawnow,

  for i = 1:nplots
    t = dt*i*plotgap;     % Define the time steps used for the left BC

    for n = 1:plotgap
      w = (D2*v')';       % Use cheb matrix not chebfft for easier BC
      w(1) = 0;
      w(N+1) = 0;

      vnew = 2*v - vold + dt^2*w;
      vold = v;
      v = vnew;

      v(1) = sin(10*t);       % Dirichlet BC at x=1

    end
    plotdata(i+1,:) = v;
    tdata = [tdata; dt*i*plotgap];

  end

% Plot results:
  clf, drawnow, waterfall(x,tdata,plotdata)
  axis([-1 1 0 tmax -2 2]), view(10,70), grid off
  colormap(1e-6*[1 1 1]); ylabel t, zlabel u,