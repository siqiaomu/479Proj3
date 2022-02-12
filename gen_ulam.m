% modification of JD's program to generate ulam data

% inputs: M - the number of different variables (coupled with each other)
%         ex: M = 100
%         N - total number of time iterations 
%         ex: N = 110000, NOT 10^5

function [data] = gen_ulam(M,N,eps)

    x = zeros(M,N);

    x(:,1) = -2 + 4*rand(M,1); % generate uniformly distributed values (-2,2);

    % we simultate out to 10^5 + 10,000 more
    for n = 2:N
        % m = 1
        y = eps*x(M, n-1) + (1-eps)*x(1,n-1);
        x(1,n) = 2 - y^2;
        for m = 2:M
            y = eps*x(m-1,n-1) + (1-eps)*x(m,n-1);
            x(m,n) = 2 - y^2;
        end
    end
    data = x(:,N-9999:N); % we take only the last 10,000 points
end





