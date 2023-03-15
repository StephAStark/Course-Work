% Stephanie Klumpe
% Problem 7.2

clear
close all
clc

N = 50;
[D,x] = cheb(N);
D2 = D^2;                          % Here, we define our Cheb points and
D2 = D2(2:end-1,2:end-1);          % our 1st and 2nd order Cheb diff
D1 = D(2:end-1,2:end-1);           % matrices

evec = exp(x);
evec(1) = [];
evec(end) = [];
f = sin(8*x);                      % We set up our RHS and our e^x vectors
f(1) = [];                         
f(end) = [];
ematr = diag(evec);

U = D2+4*D1+ematr;
u = U\f;                           % Solving for our function u(x)
u = [0;u;0];

fprintf('u(0)=%0.12f',u(26));
plot(x,u)