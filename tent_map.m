function [x_series] = tent_map(M, N, eps)
    x0 = rand(1, M); %initial condition x_0
    x_series = zeros(N,M); %N in time and M in space
    x_series(1, :) = x0;
    
    % m=1 
    for i=2:N
        temp = eps*x_series(i-1, M)+ (1-eps)*x_series(i-1, 1);
        if temp < 0.5
            x_series(i, 1) = 2*temp;
        else 
            x_series(i, 1) = 2 - 2*temp;
        end
    end
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