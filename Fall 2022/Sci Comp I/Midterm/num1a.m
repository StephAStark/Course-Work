%Stephanie Klumpe
%Midterm
%Problem 1
%Part a
%Using finite differences to solve an eigenvalue problem posed in the form
%of a second order ODE u''=lambda*u
clear;
close all;
clc;
fprintf('Problem 1\n')
fprintf('Part a\n');
n=10;%n=25; %n=50;
x=linspace(0,1,10000);
h=1/(n+1);
A=full(gallery('tridiag',n,1,-2,1));
mu=eig(A)/h^2
E=[];
for i=1:n
    eval=-(i*pi)^2;
    E=[eval,E];
end
fprintf('The true eigenvalues are:\n');
disp(E')
figure
for j=0:2
    mj=-mu(n-j);
    utrue=sin(sqrt(mj)*x);
    plot(x,utrue);
    hold on
end
hold off
title('Approximated Eigenvalue Functions with Dirichlett B.C.''s');
xlabel('x');
ylabel('u');
legend({'y = sin(\pix)','y = sin(2\pix)','y = sin(3\pix)'},'Location','southwest')