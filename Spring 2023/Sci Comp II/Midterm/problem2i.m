% Stephanie Klumpe
% Midterm
% Problem 2i

clear
close all
clc
[X,T] = meshgrid(-100:100,0:0.010:1);

u = zeros(101,101);

for i = 1:length(X)

  u = (1+exp(X/sqrt(6) - 5*T/6)).^(-2);
  u = [;,u];

end

figure
mesh(X,T,u), colormap(1e-6*[1 1 1]);
xlabel x, ylabel t, grid off

print('-dpng', 'problem2i1.png')

[t,x] = ode45(@vdp1,[0 100],[1; -0.00001]);

figure
plot(t,x(:,1),'-o',t,x(:,2),'-o')

print('-dpng', 'problem2i2.png')

function dydt = vdp1(t,y)
  c = 5/sqrt(6);

  dydt = [y(2); -c*y(2)-y(1)*(1-y(1))];
end
