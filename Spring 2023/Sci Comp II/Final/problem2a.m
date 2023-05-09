% Stephanie Klumpe
% Final Exam
% Problem 2a

clear
close all
clc

a = 0.5;
t = (0:0.1:2*pi)';
% x = a*(3*cos(t)-cos(3*t));  % Nephroid
% y = a*(3*sin(t)-sin(3*t));
x = 2*cos(t)+0.1*rand(length(t),1);
y = 3*sin(t);             % Elipse

xzero = [x y];

N = length(t);

xzero = [xzero(end,:); xzero; xzero(1,:)];

normal = zeros(N,2);

for j = 2:N+1

    data = xzero(j-1:j+1,:);
    normal(j-1,:) = bestfitnormal(data);

end

xzero([1,N+2],:)=[];
xzt = xzero';

alpha = 0.4;

xplus = xzero+alpha*normal;
xminus = xzero-alpha*normal;

eps = 2;
% rho = @(r) exp(-eps*r.^2);
rho = @(r) 1./sqrt(1+eps^2*r.^2);

M=3*N;
RHS = [zeros(N,1);alpha*ones(N,1);-alpha*ones(N,1)];
RHS = [RHS;0;0;0];

A = zeros(M);

Xbig = [xzero;xplus;xminus];

for j = 1:M
    for k = 1:M
        A(j,k)=rho(norm(Xbig(j,:)-Xbig(k,:)));
    end
end

zz = zeros(2,3);
un = ones(M,1);
unt = un';
unt = [unt 0 0 0];
xbt = Xbig';
xbt = [xbt zz];
Apol = [A un Xbig; unt; xbt];

C = Apol\RHS;
C(end-2:end)

% [Xplot,Yplot] = meshgrid(-4:0.1:4,-4:0.1:4);
% 
% Zplot = zeros(size(Xplot));
% Dist = zeros(M,1);
% 
% for j = 1:size(Xplot,1)
%     for k = 1:size(Yplot,1)
%         Zplot(j,k) = FunctInterp([Xplot(j,k) Yplot(j,k)],C,Xbig,rho);
%     end
% end

% Functions
function out = bestfitnormal(data)

    [M, ~]=size(data);

    Const = ones(M,1); % Vector of the constant term in the RHS
    out = data\Const; % Find the coefficients

end

function Fout = FunctInterp(Xin,C,Xbig,rho)

    M = size(Xbig,1);
    Dist = zeros(M,1);

    for s = 1:M
        Dist(s) = norm(Xin-Xbig(s,:));
    end

    Fout = C'.*rho(Dist);

end