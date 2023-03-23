clear;
close all;
clc;

for i=1:10

a = 0; 
b = 1; 
m = 40*2*i;
h = (b-a)/(m+1);
x = linspace(a,b,m+2);   % grid points x including boundaries
y = linspace(a,b,m+2);   % grid points y including boundaries


[X,Y] = meshgrid(x,y);      % 2d arrays of x,y values
X = X';                     % transpose so that X(i,j),Y(i,j) are
Y = Y';                     % coordinates of (i,j) point

Iint = 2:m+1;              % indices of interior points in x
Jint = 2:m+1;              % indices of interior points in y
Xint = X(Iint,Jint);       % interior points
Yint = Y(Iint,Jint);

f = @(x,y) 1.25*exp(x+y/2);         % f(x,y) function

rhs = f(Xint,Yint)+(h^2/12)*1.25*f(Xint,Yint);        % evaluate f at interior points for right hand side
                           % rhs is modified below for boundary conditions.

utrue = exp(X+Y/2);        % true solution for test problem

% set boundary conditions around edges of usoln array:

usoln = utrue;              % use true solution for this test problem
                            % This sets full array, but only boundary values
                            % are used below.  For a problem where utrue
                            % is not known, would have to set each edge of
                            % usoln to the desired Dirichlet boundary values.


% form matrix A:
I = speye(m);
e = ones(m,1);
T= spdiags([(4/h^2)*e (-10/h^2 - 10/h^2)*e (4/h^2)*e], [-1 0 1], m, m);
T2=spdiags([(1/h^2)*e (2/h^2 + 2/h^2)*e (1/h^2)*e], [-1 0 1], m, m);
K = spdiags([e 4*e e],[-1 0 1],m,m);
S = spdiags([e e],[-1 1],m,m);
A =(1/6)*(kron(I,T) + kron(S,T2));

% adjust the rhs to include boundary terms:
rhs(:,1) = rhs(:,1) - K*usoln(Iint,1)/(6*h^2);
rhs(:,m) = rhs(:,m) - K*usoln(Iint,m+2)/(6*h^2);
rhs(1,:) = rhs(1,:) - (usoln(1,Jint)*K)/(6*h^2);
rhs(m,:) = rhs(m,:) - (usoln(m+2,Jint)*K)/(6*h^2);
rhs(1,1) = rhs(1,1) - usoln(1, 1)/(6*h^2);
rhs(1,m) = rhs(1,m) - usoln(1, m+2)/(6*h^2);
rhs(m,1) = rhs(m,1) - usoln(m+2, 1)/(6*h^2);
rhs(m,m) = rhs(m,m) - usoln(m+2, m+2)/(6*h^2);


% convert the 2d grid function rhs into a column vector for rhs of system:
F = reshape(rhs,m*m,1);

% Solve the linear system:
uvec = A\F;  

% reshape vector solution uvec as a grid function and 
% insert this interior solution into usoln for plotting purposes:
% (recall boundary conditions in usoln are already set) 

usoln(Iint,Jint) = reshape(uvec,m,m);

% assuming true solution is known and stored in utrue:
err = max(max(abs(usoln-utrue)));   
fprintf('Error relative to true solution of PDE = %10.3e \n',err)

% plot results:

clf
hold on

% plot grid:
% plot(X,Y,'g');  plot(X',Y','g')

% plot solution:
contour(X,Y,usoln,30,'k')

axis([a b a b])
daspect([1 1 1])
title('Contour plot of computed solution')
hold off

end

error_loglog(h,err);

