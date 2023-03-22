% Stephanie Klumpe
% Problem 8.5
% chebfft2

clear
close all
clc

t=-1:0.001:1;
[D,x]=cheb(25);                          % Compute Cheb points
v=sin(x);                                % Choose a function
%v=exp(x);
%v=exp(-x.^2);
d2v=-sin(t);                             % Define the second derivative
%d2v=exp(t);
%d2v=exp(-t.^2).*(4.*t.^2-2);
dw=chebfft2(v);                          % Call the new function
plot(x,dw)                               % Plot the actual deriv and the 
hold on                                  % spectral deriv to compare
plot(t,d2v)
title('Actual vs Spectral Derivative')



  function dw = chebfft2(v)
  N = length(v)-1; if N==0, w=0; return, end
  x = cos((0:N)'*pi/N);
  ii = 0:N-1;
  v = v(:); V = [v; flipud(v(2:N))];      % transform x -> theta          
  U = real(fft(V));
  W = real(ifft(1i*[ii 0 1-N:-1]'.*U));
  w = zeros(N+1,1);
  w(2:N) = -W(2:N)./sqrt(1-x(2:N).^2);    % transform theta -> x     
  w(1) = sum(ii'.^2.*U(ii+1))/N + .5*N*U(N+1);     
  w(N+1) = sum((-1).^(ii+1)'.*ii'.^2.*U(ii+1))/N + ...
              .5*(-1)^(N+1)*N*U(N+1);
  dV=[w; flipud(w(2:N))];                 % Repeat the above process
  dU=real(fft(dV));                       % by defininig a vector to be
  dW = real(ifft(1i*[ii 0 1-N:-1]'.*dU)); % the derivative vector. Then
  dw = zeros(N+1,1);                      % compute the spectral deriv.
  dw(2:N) = -dW(2:N)./sqrt(1-x(2:N).^2);
  dw(1) = sum(ii'.^2.*dU(ii+1))/N + .5*N*U(N+1);     
  dw(N+1) = sum((-1).^(ii+1)'.*ii'.^2.*dU(ii+1))/N + ...
              .5*(-1)^(N+1)*N*dU(N+1);
  end

% From this, we can say that if we repeate the same idea as above 
% n times, we can get the nth derivative using Cheb spectral diff via FFT.