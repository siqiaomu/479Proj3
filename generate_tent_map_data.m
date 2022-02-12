clear all; format long; format compact;
%construction of time series using tent map
M=100; % number of x^m on the grid [0,1]
N=10000; %number of timesteps
eps = 0.02;
%x_series_left = x_series(:,1:M-1); %stores data for x_{m-1}
%x_series_right = x_series(:, 2:M); %stores data for x_m

x_series = tent_map(M, N, eps);
[trans_probs, conditional_probs_2, conditional_probs_1, transition_tuple] = trans_probability(x_series, N, M);




