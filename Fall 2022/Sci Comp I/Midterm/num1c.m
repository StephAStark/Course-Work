%Stephanie Klumpe
%Midterm
%Problem 1
%Part c
%Using the 5 point Laplacian to solve an eigenvalue problem posed in the
%form \delta(u)=lambda*u in the closed unit square with Dirichlet boundry
%conditions.
clear;
close all;
clc;
fprintf('Problem 1\n')
fprintf('Part c\n');
n=10;
%n=25;
%n=50;
m=10;
%m=25;
%m=50;
x=linspace(0,1,n+2);
y=linspace(0,1,m+2);
[X, Y] = meshgrid(x, y);
hx=1/(n+1);
hy=1/(m+1);
Ix = speye(n);
Iy=speye(m);
ex = ones(n,1);
ey=ones(m,1);
T = spdiags([ex -4*ex ex],[-1 0 1],n,n);
S = spdiags([ey ey],[-1 1],m,m);
A = (kron(Iy,T) + kron(S,Ix)) / (hx*hy);
mu=eig(A)
E=[];
for i=1:n
    for j=1:m
        eval=-(i^2+j^2)*pi^2;
        E=[eval,E];
    end
end
fprintf('The true eigenvalues are:\n');
disp(E')
figure;
u11=sin(X).*sin(Y);
surf(X,Y,u11);
title('Eigenfunction for m,n=1');
figure;
u22=sin(2*X).*sin(2*Y);
surf(X,Y,u22);
title('Eigenfunction for m,n=2');
figure;
u12=sin(X).*sin(2*Y);
surf(X,Y,u12);
title('Eigenfunction for n=1,m=2');
figure;
u21=sin(2*X).*sin(Y);
surf(X,Y,u21);
title('Eigenfunction for n=2,m=1');
figure;
u44=sin(4*X).*sin(4*Y);
surf(X,Y,u44);
title('Eigenfunction for m,n=4');