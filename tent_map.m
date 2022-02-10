clear all; format long; format compact;
%construction of time series using tent map
M=100; % number of x^m on the grid [0,1]
N=10000; %number of timesteps
eps = 0.02;
%x_series_left = x_series(:,1:M-1); %stores data for x_{m-1}
%x_series_right = x_series(:, 2:M); %stores data for x_m

x_series = tent_map(M, N, eps);
[trans_probs, transition_tuple] = trans_probability(x_series, N, M);



function [x_series] = tent_map(M, N, eps)
    x0 = rand(1, M); %initial condition x_0
    x_series = zeros(N,M);
    x_series(1, :) = x0;
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
end

function [trans_probs, transition_tuple] = trans_probability(data, N, M)
    discrete = zeros(N, M);
    discrete(find(data >=0.5)) = 1;
    transition_tuple = zeros(N, M, 3);
    count = zeros(1,4); %count the number of cases for each possibility of transition tuples
    trans_probs = zeros(N,M);
    for i=2:N
        for j=2:M
            transition_tuple(i, j, 1) = discrete(i, j);
            transition_tuple(i, j, 2) = discrete(i,j-1);
            transition_tuple(i, j, 3) = discrete(i-1, j-1);
            if transition_tuple(i,j,1) == 1 && transition_tuple(i,j,2) == 0 ...
                && transition_tuple(i,j,3) == 1
                count(1) = count(1) +1;
            elseif transition_tuple(i,j,1) == 1 && transition_tuple(i,j,2) == 0 ...
                && transition_tuple(i,j,3) == 0
                count(2) = count(2) + 1;
            elseif transition_tuple(i,j,1) == 0 && transition_tuple(i,j,2) == 0 ...
                && transition_tuple(i,j,3) == 0
                count(3) = count(3) + 1;
            elseif transition_tuple(i,j,1) == 1 && transition_tuple(i,j,2) == 1 ...
                && transition_tuple(i,j,3) == 0
                count(4) = count(4) + 1;   
            end
        end
    end

    for i=2:N
        for j=2:M
            if transition_tuple(i,j,1) == 1 && transition_tuple(i,j,2) == 0 ...
                && transition_tuple(i,j,3) == 1
                trans_probs(i,j) = count(1)/sum(count);
            elseif transition_tuple(i,j,1) == 1 && transition_tuple(i,j,2) == 0 ...
                && transition_tuple(i,j,3) == 0
                trans_probs(i,j) = count(2)/sum(count);
            elseif transition_tuple(i,j,1) == 0 && transition_tuple(i,j,2) == 0 ...
                && transition_tuple(i,j,3) == 0
                trans_probs(i,j) = count(3)/sum(count);
            elseif transition_tuple(i,j,1) == 1 && transition_tuple(i,j,2) == 1 ...
                && transition_tuple(i,j,3) == 0
                trans_probs(i,j) = count(4)/sum(count);
            end
        end
    end

end
