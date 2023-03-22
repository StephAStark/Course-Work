% Stephanie Klumpe
% Problem 5.3 edited code

clear
close all
clc

Nspace = 1:12;
xx = -1.01:.005:1.01; clf

limerr = @(N) 1./(factorial(N+1).*2.^N);       % Define the knwon err and
remerr = @(N) ((N+2)./(N+1)) ./factorial(N+1); % the remainder err as 
polyerr = zeros(2, length(Nspace));            % fxns and the polyerr as
                                               % 2x12 matrix for both 
                                               % approximations
for n = 1:length(Nspace)
   N=Nspace(n); 
  for i = 1:2
    if i==1, s = 'Equispaced Points'; x = -1 + 2*(0:N)/N; end
    if i==2, s = 'Chebyshev Points';  x = cos(pi*(0:N)/N); end

    u = exp(x);
    uu = exp(xx);
    p = polyfit(x,u,N);              % interpolation
    pp = polyval(p,xx);              % evaluation of interpolant
    polyerr(i,n) = norm(uu-pp,inf);  % fill in polyerr matrix for the two
                                     % types and the error values

  end
end

hold on;
grid on;


title('foobar')
semilogy(Nspace,remerr(Nspace));     % semilog plots of N vs the errors
semilogy(Nspace,polyerr(1,:));
semilogy(Nspace,limerr(Nspace));
semilogy(Nspace,polyerr(2,:));

print('5_3.png', '-dpng')