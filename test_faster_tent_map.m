M=100; % number of x^m on the grid [0,1]
N=2e5; %number of timesteps
eps = 0.02;
tic
[x_series] = tent_map(M, N, eps);
toc
