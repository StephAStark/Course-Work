% Stephanie Klumpe
% Sci Comp
% Homework 7
% Problem 10.8.b,c.
clear
close all
clc

for m=[49,99,199]
    advection_UW_pbc(0.4,m)
    figure
    hold on
end
hold off

for p=[0.4,0.2,0.1]
    advection_UW_pbc(p,199)
    figure
    hold on
end
close