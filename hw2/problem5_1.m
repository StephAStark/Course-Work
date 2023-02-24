% Stephanie Klumpe
% Problem 5.3 edited code

clear
close all
clc

error = zeros(2,7);       %% Set up an error matrix to hold the max errors
counter = 1;                     %% Counter used for indexing
xx = -1:.005:1; clf              %% x space
v=1; %% Used to split the above error matrix into the two different errors
Nval=[4 8 12 16 20 24 28];       %% N-value vector

 for N = Nval

  for i = 1:2

    if i==1, s = 'Equispaced Points'; x = -1 + 2*(0:N)/N; end
    if i==2, s = 'Chebyshev Points';  x = cos(pi*(0:N)/N); end
    subplot(2,2,i)
    u = 1./(1+16*x.^2);
    uu = 1./(1+16*xx.^2);
    p = polyfit(x,u,N);              % interpolation
    pp = polyval(p,xx);              % evaluation of interpolant
    plot(x,u,'.','markersize',13)
    hold off
    line(xx,pp)
    axis([-1.1 1.1 -1 1.5]), title(s)
    error(i,counter) = norm(uu-pp,inf);
    text(-.5,-.5,['max error = ' num2str(error(i,counter))])

  end

  err1=error(1:v,:);             %% Max error vector of equispaced
  err2=error(v+1:end,:);         %% Max error vector for the Cheb nodes
  figure          %% Opens new figure for each of the different N-values
  counter=counter+1;

 end

loglog(Nval,err1)
title('Error of Equispaced Points vs N')
figure
loglog(Nval,err2)
title('Error of Chebyshev Points vs N')
 
