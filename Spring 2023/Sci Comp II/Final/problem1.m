% Stephanie Klumpe
% Final Exam
% Problem 1

clear
close all
clc

a = 0.5;
t = (0:0.1:2*pi)';
x = a*(3*cos(t)-cos(3*t));  % Nephroid
y = a*(3*sin(t)-sin(3*t));
% x = 2*cos(t)+0.1*rand(length(t),1);
% y = 3*sin(t);             % Elipse

xzero = [x y];

N = length(t);

plot(x,y,'k.')
axis equal

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

plot(xzero(:,1),xzero(:,2),'ro')
hold on
plot(xplus(:,1),xplus(:,2),'b*')
plot(xminus(:,1),xminus(:,2),'gd')
axis([-4 4 -4 4])

print('-dpng', 'problem1norm.png')

figure(2), clf
plot3(xzero(:,1),xzero(:,2),zeros(N,1),'ro')
hold on
plot3(xplus(:,1),xplus(:,2),alpha*ones(N,1),'b*')
plot3(xminus(:,1),xminus(:,2),-alpha*ones(N,1),'gd')
axis([-4 4 -4 4 -5*alpha 5*alpha])

grid on
hold on

print('-dpng', 'problem1ext.png')

eps = 2;
% rho = @(r) exp(-eps*r.^2);
rho = @(r) 1./sqrt(1+eps^2*r.^2);

M=3*N;
RHS = [zeros(N,1);alpha*ones(N,1);-alpha*ones(N,1)];

A = zeros(M);

Xbig = [xzero;xplus;xminus];

for j = 1:M
    for k = 1:M
        A(j,k)=rho(norm(Xbig(j,:)-Xbig(k,:)));
    end
end

C = A\RHS;

[Xplot,Yplot] = meshgrid(-4:0.1:4,-4:0.1:4);

Zplot = zeros(size(Xplot));
Dist = zeros(M,1);

for j = 1:size(Xplot,1)
    for k = 1:size(Yplot,1)
        Zplot(j,k) = FunctInterp([Xplot(j,k) Yplot(j,k)],C,Xbig,rho);
    end
end

surf(Xplot,Yplot,Zplot)

figure(3), clf
plot(xzero(:,1),xzero(:,2),'bo')
hold on                            % Level curve
axis([-4 4 -4 4])
v=[-alpha,0,alpha];
v=[0,0.001];
contour(Xplot,Yplot,Zplot,v,'Color','r')


print('-dpng', 'problem1lvl.png')

% Functions
function out = bestfitnormal(data)

    [M, dim]=size(data);

    Const = ones(M,1); % Vector of the constant term in the RHS
    out = data\Const; % Find the coefficients

end

function Fout = FunctInterp(Xin,C,Xbig,rho)

    M = size(Xbig,1);
    Dist = zeros(M,1);

    for s = 1:M
        Dist(s) = norm(Xin-Xbig(s,:));
    end

    Fout = C'*rho(Dist);

end