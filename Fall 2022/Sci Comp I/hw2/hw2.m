% Stephanie Klumpe
% Sci Comp
% Homework 2
% 2.1 Part a

clear;
close all;
clc;

fprintf('2.1\n');
fprintf('Part a\n\n');

A=(16)*[0.0625 0 0 0 0; 1 -2 1 0 0; 0 1 -2 1 0; 0 0 1 -2 1; 0 0 0 0 0.0625];
disp(A)

%% Part b

fprintf('Part b\n\n');

Ainv=inv(A);
disp(Ainv)

%% Part c

fprintf('Part c\n\n');

syms x
G_0=(0.25*0)*piecewise((0<=x)&(x<=0),(0-1)*x,(0<=x)&(x<=1),0*x-0);
G_1=(0.25*0.25)*piecewise((0<=x)&(x<=0.25),(0.25-1)*x,(0.25<=x)&(x<=1),0.25*x-0.25);
G_2=(0.25*0.5)*piecewise((0<=x)&(x<=0.5),(0.5-1)*x,(0.5<=x)&(x<=1),0.5*x-0.5);
G_3=(0.25*0.75)*piecewise((0<=x)&(x<=0.75),(0.75-1)*x,(0.75<=x)&(x<=1),0.75*x-0.75);
G_4=(0.25*1)*piecewise((0<=x)&(x<=1),(1-1)*x,(1<=x)&(x<=1),1*x-1);

U=G_0+G_1+G_2+G_3+G_4;
u=(1/6)*x^3-(1/6)*x;

hold on
fplot(G_0);
fplot(G_1);
fplot(G_2);
fplot(G_3);
fplot(G_4);
fplot(U);
fplot(u,[0,1]);

legend({'G(x,0)','G(x,0.25)','G(x,0.5)','G(x,0.75)','G(x,1)','U(x)','u(x)'},'Location','northeast');

%% 2.2

fprintf('2.2\n\n');

B=16*[-0.25 0.25 0 0 0; 1 -2 1 0 0; 0 1 -2 1 0; 0 0 1 -2 1; 0 0 0 0 0.0625];
disp(B);
Binv=inv(B);
disp(inv(B));

%% 2.3

fprintf('2.3\n\n');

syms h
A2=[-h h 0 0 0; 1 -2 1 0 0; 0 1 -2 1 0; 0 0 1 -2 1; 0 0 0 h -h];
AT=A2';

disp(AT);
RA=rref(A);
disp(RA);

n=null(AT);
disp(n)
nulity=size(n,2);
disp(nulity);






