% Stephanie Klumpe
% Final Exam
% Problem 3a
% Heat from fire. Fire from heat.

clear
close all
clc

t = linspace(0:0.1:1);

xzero = [x y];

N = length(t);

xzero = [xzero(end,:); xzero; xzero(1,:)];

normal = zeros(N,2);

for j = 2:N+1

    data = xzero(j-1:j+1,:);
    normal(j-1,:) = bestfitnormal(data);

end

xzero([1,N+2],:)=[];
alpha = 0.4;

xplus = xzero+alpha*normal;
xminus = xzero-alpha*normal;

eps = 2;
rho = @(r) exp(-eps*r.^2);
d2rho = @(r) eps^2*exp(-eps*r.^2).*(eps^2*r.^2-1)

M=3*N;
RHS = [zeros(N,1);alpha*ones(N,1);-alpha*ones(N,1)];

A = zeros(M);
A2 = zeros(M);

Xbig = [xzero;xplus;xminus];

for j = 1:M
    for k = 1:M

        A(j,k)= rho(norm(Xbig(j,:)-Xbig(k,:)));
        A2(j,k) = d2rho(norm(Xbig(j,:)-Xbig(k,:)));

    end
end

D = A2\A;

% Functions
function out = bestfitnormal(data)

    [M, ~]=size(data);

    Const = ones(M,1); % Vector of the constant term in the RHS
    out = data\Const; % Find the coefficients

end
