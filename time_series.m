clear all; format long; format compact;
%construction of time series using tent map
M=100; % number of x^m on the grid [0,1]
N=10000; %number of timesteps
x0 = rand(1, M); %initial condition x_0
x_series = zeros(N,M);
x_series(1, :) = x0;
%x_series_left = x_series(:,1:M-1); %stores data for x_{m-1}
%x_series_right = x_series(:, 2:M); %stores data for x_m
eps = 0.02;
for i=2:N
    for j = 2:M
        temp = eps*x_series(i-1, j-1) + (1-eps)*x_series(i-1, j);
        if temp <0.5
            x_series(i,j) = 2*temp;
        else
            x_series(i,j) = 2 - 2*temp;
        end
    end
end
