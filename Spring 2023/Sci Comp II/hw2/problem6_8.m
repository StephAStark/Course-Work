% Stephanie Klumpe
% Problem 6.8
% (Cheb matrix_N)^(N+1)=0 code

clear
close all
clc

[Df,x] = cheb(5);                   % Define the cheb matrices
[Dt,y] = cheb(20);

D6 = (Df)^6;                        % Raise them to powers
D21 = (Dt)^(20);

D5err = norm(D6,2)                  % Compute the L2 norm of the powers
% 6.0832e-11
D20err = norm(D21,2)
% 1.2906e+24