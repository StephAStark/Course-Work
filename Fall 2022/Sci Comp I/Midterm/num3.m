%Stephanie Klumpe
%Midterm
%Problem 3
%Solving the ODE u'(t)=2(t+1), u(1)=3 using the implicit Runge-Kutta
%method on the interval [1,2].
clear;
close all;
clc;
fprintf('Problem 3\n');
%n=10;
n=50;
%n=100;
t=linspace(1,2);
h=1/(n);
utrue=t.^2+2*t;
up=3;
tp=1;
plot(t,utrue,'r');
hold on
for i=1:n
    uc=up+h*(2*(tp+1));
    plot(tp,up,'bo');
    hold on
    tc=tp+h;
    tp=tc;
    up=uc;
end
title('Actual vs Runge-Kutta Approximation');
xlabel('t');
ylabel('u');
legend('u(t)','Approximation','Location','northwest');