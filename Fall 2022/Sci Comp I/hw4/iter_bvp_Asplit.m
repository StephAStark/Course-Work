% Solve 1d BVP obtained by discretizing u''(x) = f(x) 
% with Dirichlet boundary condtions  u(0) = alpha, u(1) = beta
% Discretized using centered difference.
%
% Compare matrix splitting methods:  Jacobi, Gauss-Seidel, and SOR
%
% From  http://www.amath.washington.edu/~rjl/fdmbook/  (2007)

%4.1.a. We iterate through each of the different techinques and 
%       create plots to mirror illustration 4.1

method = 'SOR';   % 'Jacobi' or 'GS' or 'SOR'
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

% set up iteration matrix:
switch method
   case 'Jacobi'
      M = DA;
      N = LA + UA;
   case 'GS'
      M = DA - LA;
      N = UA;
% Added this case to impliment the backwards GS method
   case 'BGS'
      M = DA - UA;
      N = LA;
   case 'SOR'
      % use optimal omega for this problem:

%4.1.b. iterating the SOR method through different omega values commented
%       out below

      omega = 2 / (1 + sin(pi*h));
      %omega = 1.8;
      %omega = 1.95;
      M = 1/omega * (DA - omega*LA);
      N = 1/omega * ((1-omega)*DA + omega*UA);
 end


u = zeros(size(x));   % initial guess for iteration

figure(1)
clf
plot(x,ustar,'r')
hold on
plot(x,u)

error = nan(maxiter+1,1);
error(1) = max(abs(u-ustar));


% Iteration:
% ----------

%Bad iteration method for the SOR method(commented out for use of actual code)
%To run the bad iteration, uncomment lines 90-92 and comment out lines
%94-96

%for iter=1:maxiter
%    uGS = (DA - LA) \ (UA*u + rhs);
%    u = u + omega * (uGS - u);

for iter=1:maxiter

   u = M \ (N*u + rhs);
      
   error(iter+1) = max(abs(u-ustar));
   if mod(iter,nplot)==0
      % plot u every nplot iterations
      plot(x,u)
      title(sprintf('%s: Iteration %4i, error = %9.3e',...
             method,iter,error(iter+1)),'FontSize',15)
      drawnow
      pause(.1)
   end
end

% plot errors vs. iteration:
figure(2)
semilogy(error)
axis([0 maxiter min(error)/10 1])
title('Errors','FontSize',15)
xlabel('iteration')
hold on
%legend({'GS','BGS'},'Location','southwest') used as a legend for the
%comparison grpahs in the command window.

% compute spectral radius of iteration matrix G:
G = M\N;
rhoG = max(abs(eig(full(G))));
disp(sprintf('Spectral radius of G for %s is %5f',method,rhoG))

