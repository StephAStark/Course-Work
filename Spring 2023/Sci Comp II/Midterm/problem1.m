% Stephanie Klumpe
% Midterm
% Problem 1

clear
close all
clc

eps = 0.03;                    % epsilon val
N = 40;                        % discretization
x = linspace(-pi,pi,N);        % domain
u = exp(-10*sin(x/2).^2);      % initial conditions

k = [0:N/2-1 0 -N/2+1:-1];


dt = 1/N;
udata = u;
tdata = 0;

f = @(t,u) -eps*k.^2.*fft(u) + 1i*k.*fft(1/2*u.^2);
                               % Anon function
for n = 1:N-1

  t = (n+1)*dt;

  k_1 = f(t,u);
  k_2 = f(t+0.5*dt,u+0.5*dt*k_1);
  k_3 = f((t+0.5*dt),(u+0.5*dt*k_2));
  k_4 = f((t+dt),(u+k_3*dt));
  u = fft(u) + (1/6)*(k_1+2*k_2+2*k_3+k_4)*dt;

  u = real(ifft(u));

  udata = [udata u];
  tdata = [tdata t];

end

udata = reshape(udata,[N,N]);

surf(x,tdata,udata), colormap(jet);
view(2)
xlabel x, ylabel t, axis([-pi pi 0 1 0 1]), grid off

print('-dpng', 'problem1.png')
