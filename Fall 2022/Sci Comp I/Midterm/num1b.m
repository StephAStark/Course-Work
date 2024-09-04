%Stephanie Klumpe
%Midterm
%Problem 1
%Part b
%Using finite differences to solve an eigenvalue problem posed in the form
%of a second order ODE u''=lambda*u with mixed boundry conditions
clear;
close all;
clc;
fprintf('Problem 1\n')
fprintf('Part b\n');
n=10;%n=25; %n=50;
x=linspace(0,1,10000);
h=1/(n+1);
A=full(gallery('tridiag',n,1,-2,1));
I=eye(n-1,n);
R=zeros(1,n);
B=[I;R];
eta=eig(A,B)/h^2
figure
for k=1:3
    lam=-eta(n-k);
    u2true=sin(sqrt(lam)*x);
    plot(x,u2true);
    hold on
end
title('Approximated Eigenvalue Functions with Mixed B.C.''s');
xlabel('x');
ylabel('u');
legend({'y = sin(\lambda_1x)','y = sin(\lambda_2x)','y = sin(\lambda_3x)'},'Location','southwest')