%Stephanie Klumpe
%Midterm
%Problem 2
%Solving the ODE u'(t)=2(t+1), u(1)=3 using the 2 step Milne's method. In
%order to get the first step so that we have the first two conditions, we
%impliment the forward Euler's method. After that, it is Milne's method.
clear;
close all;
clc;
fprintf('Problem 2\n');
%n=10;
n=50;
%n=100;
t=linspace(1,2);
h=1/n;
utrue=t.^2+2*t;
up=3;
uc=3+h*4;
tp=1;
plot(t,utrue,'r');
hold on
for i=1:n
    un=up+(h/3)*(2*(tp+1)+4*2*(tp+h+1)+2*(tp+(2*h)+1));
    plot(tp,up,'bo');
    hold on
    tc=tp+h;
    tp=tc;
    up=uc;
    uc=un;
end
title('Actual vs 2-Step Milne Approximation');
xlabel('t');
ylabel('u');
legend('u(t)','Approximation','Location','northwest');