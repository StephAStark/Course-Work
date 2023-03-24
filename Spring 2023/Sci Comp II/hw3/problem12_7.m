% Stephanie Klumpe
% Problem 12.7

clear
close all
clc

N = 30;
deg = 20;     % Degree of the desired expansion
realco = zeros(length(deg));
error = zeros(length(deg));

z = @(theta) exp(1i*theta);   % Imaginary part
f = @(z) log(1+z./2);    % Desired function

t = 2*pi*(0:N-1)/N;
rho = z(t);

tayco = real(fft(f(rho),N)/length(rho));

xx=linspace(-6,6);

%fxn = log(1+xx./2);  % Plot the original function

disp(tayco(2:deg))   % Display the 19 coefficients

fprintf('\n\n')
fprintf('T(x) = ')

for i = 1:deg
  fprintf('%ex^%d + ',tayco(i),i-1) % Display the found taylor series
end

for j = 1:deg
 realco(j) = (1/factorial(j))*((-1)^j+1/2^j);
  error(j)=abs(realco(j)-tayco(j));

  semilogy(j-1,error(j),'markersize',12)
  grid on
  hold on
end

title('Error per Computed Taylor Coefficient');
xlabel('Coefficient Index')
ylabel('|T_n-a_n|')

print('-dpng', 'problem12_7.png')
