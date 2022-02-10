% modification of JD's program to generate ulam data
function [data] = gen_ulam(M,N,eps)

    x = zeros(M,N);

    x(:,1) = -2 + 4*rand(M,1); % generate uniformly distributed values (-2,2);


    for n = 2:N
        % m = 1
        y = eps*x(M, n-1) + (1-eps)*x(1,n-1);
        x(1,n) = 2 - y^2;
        for m = 2:M
            y = eps*x(m-1,n-1) + (1-eps)*x(m,n-1);
            x(m,n) = 2 - y^2;
        end
    end
    data = x;

end





