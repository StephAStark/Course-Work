% Stephanie Klumpe
% Problem 10

clear
close all
clc

A4 = [1 -1 0 -1;
      -1 1 -1 0;
      0 -1 1 -1;
      -1 0 -1 1];
A5 = [1 -1 0 0 -1;
      -1 1 -1 0 0;
      0 -1 1 -1 0;
      0 0 -1 1 -1;
      -1 0 0 -1 1];
A6 = [1 -1 0 0 0 -1;
      -1 1 -1 0 0 0;
      0 -1 1 -1 0 0;
      0 0 -1 1 -1 0;
      0 0 0 -1 1 -1;
      -1 0 0 0 -1 1];

S4 = smithForm(A4)
S5 = smithForm(A5)
S6 = eig(A6)