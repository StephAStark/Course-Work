% Stpehnaie Klumpe
% Problem 7.1

clear
close all
clc

N = 16;
[D,x] = cheb(N);            % Define the Cheb matrix for both first and
D2 = D^2;                   % second order
D2 = D2(2:end-1, 2:end-1);

f = exp(4*x(2:N));
%f = sin(3*x(2:N));         % Different functions to test with
%f = exp((x(2:N)).^2);
u = D2\f;
u = [0; u; 0];              % Define our ODE and plot our Cheb nodes on our
plot(x,u,'o')               % solution
xx = -1:0.01:1;

ainv = ones(N+1,1);
denom = zeros(length(xx),1);    % Define our a^-1, numerator, and denominator
num = zeros(length(xx),1);      % vectors

for i=1:N+1
    for k=1:N+1
        if k ~= i
            ainv(i) = ainv(i)*(x(i) - x(k));  % Fill out the a^-1 vector
        end
    end
end


for i = 1:N+1

    denom = denom + ainv(i)^(-1)./(xx.' - x(i));    % Fill out the num and
    num = num + ainv(i)^(-1)*u(i)./(xx.' - x(i));   % denom vectors


end

num = num(2:end-1);        % Take off the ends of the num vector and replace
num = [0;num;0];         % them with the boundary conditions

u = num./denom;
hold on
plot(xx, u, '-')
title('Barycentric Iterpolation')
