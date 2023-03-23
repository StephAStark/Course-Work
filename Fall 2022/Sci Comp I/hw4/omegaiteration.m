%Stephanie Klumpe
%4.1.c.
%Spectral radius iterated over omega values between 0 and 2
clear;
close all;
clc;
nplot = 10;          % iterate u is plotted every nplot iterations
maxiter = 500;        % number of iterations to take

m = 39;
ax = 0;
bx = 1;
alpha = 0;
beta = 0;
f = @(x) ones(size(x));   % f(x) = 1

h = (bx-ax) / (m+1);
x = linspace(ax, bx, m+2)';

% determine exact solution to linear system by setting up
% system Au = f and solving with backslash:
e = ones(m+2,1);

A = 1/h^2 * spdiags([e -2*e e], [-1 0 1], m+2, m+2);
A(1,1:2) = [1 0];
A(m+2,m+1:m+2) = [0 1];
rhs = f(x);
rhs(1) = alpha;
rhs(m+2) = beta;
ustar = A\rhs;


% Decompose A = DA - LA - UA:
DA = diag(diag(A));   % diagonal part of A
LA = DA - tril(A);    % strictly lower triangular part of A (negated)
UA = DA - triu(A);    % strictly upper triangular part of A (negated)
omega=linspace(1e-16,2);
for i=1:length(omega)
    M = 1/omega(i) * (DA - omega(i)*LA);
    N = 1/omega(i) * ((1-omega(i))*DA + omega(i)*UA);
    u = zeros(size(x));   % initial guess for iteration
    G = M\N;
    rhoG(i) = max(abs(eig(full(G))));
end
figure
axis([0 2 0.84 1])
xlabel('\omega')
ylabel('g(\omega)')
hold on;
plot(omega, rhoG);
hold off;
