% p9.m - polynomial interpolation in equispaced and Chebyshev pts
clear
close all
clc
error=zeros(7,2);
  for N = [4 8 12 16 20 24 28]
  xx = -1:.005:1; clf
  for i = 1:2
    if i==1, s = 'equispaced points'; x = -1 + 2*(0:N)/N; end
    if i==2, s = 'Chebyshev points';  x = cos(pi*(0:N)/N); end
    subplot(2,2,i)
    u = 1./(1+16*x.^2);
    uu = 1./(1+16*xx.^2);
    p = polyfit(x,u,N);              % interpolation
    pp = polyval(p,xx);              % evaluation of interpolant
    plot(x,u,'.','markersize',13)
    hold off
    line(xx,pp)
    axis([-1.1 1.1 -1 1.5]), title(s)
    error(N,i) = norm(uu-pp,inf);
    text(-.5,-.5,['max error = ' num2str(error(N,i))])
  end
  figure
 loglog(N,error(N,i))
  end
