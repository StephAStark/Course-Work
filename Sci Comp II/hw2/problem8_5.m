% Stephanie Klumpe
% Problem 8.5

clear
close all
clc

tic

% Grid and initial data:
  N = 24;
  x = cos(pi*(0:N)/N);
  y = x';
  dt = 6/N^2;
  [D,x] = cheb(N);
  D2 = D^2;
  
  D2 = D2(2:N,2:N);
  I = eye(N-1);
  L = kron(I,D2) + kron(D2,I); 

  [xx,yy] = meshgrid(x,y);
  plotgap = round((1/3)/dt);
  dt = (1/3)/plotgap;
  vv = exp(-40*((xx-.4).^2 + yy.^2));
  vv=vv(2:N,2:N);
  vvold = vv; 

% Time-stepping by leap frog formula:
  for n = 0:3*plotgap
    t = n*dt;

    U=vv(:); RHS=L*U; RHS=reshape(RHS,N-1,N-1);
    vvnew = 2*vv - vvold + dt^2*RHS; 
    vvold = vv;
  end

  toc
% Elapsed time was about 0.0065 seconds