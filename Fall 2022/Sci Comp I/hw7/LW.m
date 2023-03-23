% Stephanie Klumpe
% Sci Comp
% Homework 7
% Problem 10.8.a.
clear
close all
clc

for m=[49,99,199]
    advection_LW_pbc(1,m)
    figure
    hold on
end
%close

for m=[49,99,199]
    advection_LW_pbc(0.1,m)
    figure
    hold on
end
close