% Stephanie Klumpe
% Problem 2b

clear
close all
clc

R = 1;
r = 0.5;

[theta,phi] = meshgrid(linspace(0,2*pi,40));
% theta = (0:0.1:2*pi)';
% phi = (0:0.1:2*pi)';

x = (R + r.*cos(theta)).*cos(phi)+0.1*rand(length(phi),1);
y = (R + r.*cos(theta)).*sin(phi)+0.1*rand(length(phi),1);
z = r.*sin(theta+0.5*rand(length(phi),1));


plot3(x,y,z,'k.')
axis equal

print('-dpng', 'problem2bcloud.png')

xzero = [x y z];

N = length(theta);

xzero = [xzero(end,:); xzero; xzero(1,:)];

normal = zeros(N,3*N);

for j = 2:N+1

    data = xzero(j-1:j+1,:);
    normal(j-1,:) = bestfitnormal(data);

end

xzero([1,N+2],:) = [];
alpha = 0.2;

xplus = xzero+alpha*normal;
xminus = xzero-alpha*normal;

figure
plot3(xzero(:,1:40),xzero(:,41:80),xzero(:,81:120),'ro')
hold on
plot3(xplus(:,1:40),xplus(:,41:80),xplus(:,81:120),'b*')
plot3(xminus(:,1:40),xminus(:,41:80),xminus(:,81:120),'gd')

print('-dpng','problem2bnorm.png')

eps = 2;
% rho = @(r) exp(-eps*r.^2);
rho = @(r) 1./sqrt(1+eps^2*r.^2);

M = 3*N;
RHS = [zeros(N,1);alpha*ones(N,1);-alpha*ones(N,1)];

A = zeros(M);

Xbig = [xzero;xplus;xminus];

for j = 1:M
    for k = 1:M

        A(j,k) = rho(norm(Xbig(j,:)-Xbig(k,:)));

    end
end

C = A\RHS;

[Xplot,Yplot,Zplot] = meshgrid(-1:0.1:1,-1:0.1:1,-1:0.1:1);

Tplot = zeros(size(Xplot));
Dist = zeros(M,1);

for j =1:size(Xplot,1)
    for k = 1:size(Yplot,1)
        for l = 1:size(Zplot,1)

            Tplot(j,k,l) = FunctInterp([Xplot(j,k,l);Yplot(j,k,l);Zplot(j,k,l)],C,Xbig,rho);

        end
    end
end

%surf(Xplot,Yplot,Zplot,Tplot)

X=reshape(Tplot,[],3);
figure
plot3(X(:,1),X(:,2),X(:,3),'bo')



function out = bestfitnormal(data)

    [M, ~]=size(data);

    Const = ones(M,1); % Vector of the constant term in the RHS
    out = Const\data; % Find the coefficients

end

function Fout = FunctInterp(Xin,C,Xbig,rho)

    M = size(Xbig,1);
    Dist = zeros(M,1);

    for s = 1:M
        Dist(s) = norm(Xin-Xbig(s,:));
    end

    Fout = C'*rho(Dist);

end
