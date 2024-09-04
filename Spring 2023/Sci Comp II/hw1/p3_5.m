clear
close all
clc

for k=[0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15]
    N=2.^k;
    tic
    h = 2*pi/N; x = -pi + (1:N)'*h;
    u=2.*sin(3.*x+2);
    uhat=fft(u,N);
    toc
end
fprintf('\n')
for N = 500:1:520
    tic
    h = 2*pi/N; x = -pi + (1:N)'*h;
    u=2.*sin(3.*x+2);
    uhat=fft(u,N);
    toc
end