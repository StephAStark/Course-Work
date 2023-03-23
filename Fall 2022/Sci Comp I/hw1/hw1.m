% Stephanie Klumpe MATH 5670
% Homework 1
% Part 1.2.b.

clear;
close all;
clc;

fprintf('Problem 1.2');
fprintf('\n');
fprintf('Part b.');
fprintf('\n\n');

fdstencil(2,-2:2);
c=fdcoeffF(2,0,-2:2);
disp(c);

fprintf('Part c.\n\n');

syms x;
hvals=logspace(-1,-4,13);
u=sin(2*x);
d2u=diff(diff(u));
ex=vpa(subs(d2u,x,1));

fprintf('u=%s\n',u);
fprintf('u''''=%s\n',d2u);
disp('');
disp('      h               Error');

for i=1:length(hvals)
    h=hvals(i);
    fd=((-1/12)*sin(2*(1-2*h))+(4/3)*sin(2*(1-h))-(5/2)*sin(2*1) ...
        +(4/3)*sin(2*(1+h))-(1/12)*sin(2*(1+2*h)))/h^2;
    Err(i)=fd-ex;
    disp(sprintf('%2.4e          %2.4e\n',h,Err(i)));
end

fprintf('Approximation=%.10f\n',fd);
fprintf('Exact=%.10f\n',ex);

hold on
loglog(hvals,Err,'o-');
hold off
