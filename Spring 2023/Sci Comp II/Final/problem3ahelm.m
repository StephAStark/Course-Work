% Stephanie Klumpe
% Final Exam
% Problem 3a
% Eigenpaloza

clear
close all
clc


M = 5;
N = 24;

rho = @(e,r) exp(-(e*r).^2);
d2rho = @(e,r) 2*e^2*exp(-(e*r).^2).*(2*(e*r).^2-1);

[D2,x] = D2RBF(N,rho,d2rho);
D2 = D2(2:N,2:N);

[U, lambda] = eig(-D2);
[evals, ii] = sort(diag(lambda),'ascend');
ii = ii(1:M);
evects = real(U(:,ii));

subplot(2, 3, 1)
semilogy(1:M, evals(1:M), '.')
grid on
axis square

xx = linspace(0, 1);
for i = 1:M
    subplot(2, 3, i+1)
    plot(xx, interp1(x, [0; evects(:, i); 0], xx))
    grid on
    axis square
    title(['\lambda = ' num2str(evects(i), '%15.3f')]);
end

print('problem3ahelm', '-dpng')