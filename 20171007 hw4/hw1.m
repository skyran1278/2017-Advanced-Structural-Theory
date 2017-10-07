% 消除前一次作業
clc; clear; close all;

% kN/m
k = 20000 * [ 1 0 -1; 0 1 0; -1 0 1.36 ];

% kN
p = [ 90; 135; 0 ];

lambda1 = 43922;

psi1 = [ 0.64142; 0; -0.76719 ];

lambda2 = 20000;

psi2 = [ 0; 1; 0 ];

lambda3 = 3278.6;

psi3 = [ 0.76179; 0; 0.64142 ];

phi = [psi1 psi2 psi3];

%%
% hw1-a
% inv(k) * p
delta = k \ p

%%
% hw1-b
k * psi1
lambda1 * psi1

k * psi2
lambda2 * psi2

k * psi3
lambda3 * psi3

%%
% hw1-c
% transpose() = .'
phi.' .* k .* phi
[lambda1 0 0; 0 lambda2 0; 0 0 lambda3]