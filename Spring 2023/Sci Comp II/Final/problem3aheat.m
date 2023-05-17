% Stephanie Klumpe
% Final Exam
% Problem 3a
% Heat from fire. Fire from heat.

clear
close all
clc

T = 1;
tplot = 0.1;
Amp = 2;

N = 25;

c = 0.02;

rho = @(e,r) exp(-(e*r).^2);
d2rho = @(e,r) 2*e^2*exp(-(e*r).^2).*(2*(e*r).^2-1);

[D2,x] = D2RBF(N,rho,d2rho);
clc

dt = min([10e-6, N^(-4)/c]);
t = 0;
nplots = round(T/tplot);
plotgap = round(tplot/dt);
dt = tplot/plotgap;

u = Amp*sin(pi*x/2).^2;

xspace = 0:0.01:1;
uu = polyval(polyfit(x,u,N),xspace);
plotdata = [uu;zeros(nplots,length(xspace))];
tspace = t;

for i = 1:nplots

    for k = 1:plotgap

        t = t+dt;
        u = u+dt *(c*(D2*u));
        u(1) = 0;
        u(end) = 0;

    end

    uu = polyval(polyfit(x,u,N),xspace);
    plotdata(i+1, :) = uu;
    tspace = [tspace;t];

end

figure
plot(xspace,plotdata)
grid on
xlabel('x');
ylabel('u');
title('Spacial')

print('problem3aheatx', '-dpng')

figure
plot(tspace,plotdata)
grid on
xlabel('t');
ylabel('u');
title('Temporal')

print('problem3aheatt', '-dpng')

figure
surf(xspace,tspace,plotdata)
colormap('cool');
xlabel('x');
ylabel('t');
zlabel('u');
title('Heat Equation Using RBF-PS')

print('problem3aheat', '-dpng')

view(0, 90)

print('problem3aheat2d', '-dpng')