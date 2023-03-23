%Stephanie Klumpe
%Midterm
%Problem 4
%Using ode45, we solve the Airy equation. Here, we used a prebuilt ode
%function from mathworks while changing the variables to better fit the
%problem u''=xu.
clear;
close all;
clc;
fprintf('Problem 4\n');
xspan=linspace(10,-10,1000);
u0=[1e-6 1e-6];
[x,u]=ode45(@(x,u) odeairy(x,u), xspan, u0);
plot(x,u(:,1))
title('Solution of the Airy Equation with ODE45');
xlabel('x');
ylabel('u');
function dudx = odeairy(x,u)
  dudx = zeros(2,1);
  dudx(1) = u(2);
  dudx(2) = x.*u(1);
end