function [x_series] = tent_map(M, N, eps)
    x0 = rand(1, M); %initial condition x_0
    x_series = zeros(N,M); %N in time and M in space
    x_series(1, :) = x0;
   
    for i=2:N
        temp0 = eps*x_series(i-1, M) + (1-eps)*x_series(i-1, 1); %m=1
        if temp0<0.5
            x_series(i, 1) = 2*temp0;
        else
            x_series(i,1) = 2 - 2*temp0;
        end
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