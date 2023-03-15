% Stephanie Klumpe
% Problem 12.2

clear
close all
clc

Nvals = [1 2 3 4];              % Setting the desired N values to loop thru

for N = Nvals

[x,w] = gauss(N);
xx = -1:0.01:1;
u = exp(4*x);

ainv = ones(N,1);               % Inititalize a^-1 vector
Dij = zeros(N,N);               % Inititalize the diagonal and nondiagonal
Dii = zeros(N,N);               % matrices

for i = 1:N
    for j = 1:N
        if j ~= i
            ainv(i) = ainv(i)*(x(i) - x(j));  % Fill out the a^-1 vector
        end
    end
end

for i = 1:N
    for j = 1:N
        if j != i
           Dij(i,j) = ainv(i)/ainv(j)*(1/(x(i)-x(j)));
           Dii(i,i) = 1/(x(i)-x(j));  % Compute the entries of the matrix
        end
    end
end

Dn = Dij +Dii;                   % Combine the two matrices to get the actual
                                 % diff matrix
fprintf('D%d = \n',N);
disp(Dn)
fprintf('\n')
end
