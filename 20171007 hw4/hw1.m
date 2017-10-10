%%
% ----------------------------------------------------------
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

lambda = [lambda1 0 0; 0 lambda2 0; 0 0 lambda3];


%%
% ----------------------------------------------------------
% hw1-a
% inv(k) * p
clc;

delta = k \ p;
fprintf('%d\n', delta);

% output
% 1.700000e-02
% 6.750000e-03
% 1.250000e-02


%%
% ----------------------------------------------------------
% hw1-b
clc;
isequal(round(k * psi1, 3, 'significant'), round(lambda1 * psi1, 3, 'significant'))
isequal(round(k * psi2, 3, 'significant'), round(lambda2 * psi2, 3, 'significant'))
isequal(round(k * psi3, 3, 'significant'), round(lambda3 * psi3, 3, 'significant'))

% output
% ans =

%   logical

%    1


% ans =

%   logical

%    1


% ans =

%   logical

%    0



%%
% ----------------------------------------------------------
% hw1-c
% transpose() = .'
clc;

isequal(round(phi.' * k * phi, 3, 'significant'), round(lambda, 3, 'significant'))

% output
% ans =

%   logical

%    0

%%
% ----------------------------------------------------------
% hw1-d
clc;

c = lambda \ phi.' * p
delta = phi * c
isequal(round(k * delta, 3, 'significant'), round(p, 3, 'significant'))

% output
% c =

%     0.0013
%     0.0067
%     0.0209


% delta =

%     0.0168
%     0.0067
%     0.0124


% ans =

%   logical

%    0
