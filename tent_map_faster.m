function [x_series] = tent_map_faster(M, N, eps)
    x0 = rand(1, M); %initial condition x_0
    x_series = zeros(N,M); %N in time and M in space
    x_series(1, :) = x0;
    % m=1 
    for n=2:N
        shifted = [x_series(n-1, M), x_series(n-1, 1:(end-1))];
        temp = eps * shifted + (1 - eps) * x_series(n-1, :);
        x_series(n, :) = (2 * temp).*(temp < 0.5) + (2 - 2 * temp).*(temp >= 0.5);

    end
end