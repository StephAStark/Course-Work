% Stephanie Klumpe
% Problem 14.1

clear
close all
clc

N = 25;                 % Set up the nodes
[D,x] = cheb(N);

S = diag([0; 1 ./(1-x(2:N).^2); 0]);

D2=D^2;
D2 = D2(2:N,2:N);
                    % Define and reshape our differential matrices
D3 = (diag(1-x.^2)*D^3 - 6*diag(x)*D^2 - 6*D)*S;
D4 = (diag(1-x.^2)*D^4 - 8*diag(x)*D^3 - 12*D^2)*S;

D3 = D3(2:N,2:N);
D4 = D4(2:N,2:N);

LHS = (1/16)*D4 + (1/8)*D3;
RHS = (1/4)*D2;    % Get the left and right sides of the ODE

[vect, lam] = eig(LHS, RHS);
[evals, ii] = sort(diag(lam), 'descend');
ii = ii(1:5);       % Get the evals/evects and order them
evects = real(vect(:, ii));

figure
disp(evals(1:5))                % Display the evals
xx = linspace(-2, 2);

%Plot the evects
for i = 1:5
    subplot(2, 3, i)
    plot(xx, interp1(2*x, [0; evects(:, i); 0], xx), 'linewidth', 2)
    grid on
    axis square
    title(['\lambda = ' num2str(evals(i), '%15.11f')]);
end

print('-dpng', 'problem14_1_evects.png')
