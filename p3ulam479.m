

M = 10;
N = 100;
r=5;
x = zeros(M,N);
eps = 0.3;

x(:,1) = -2 + 4*rand(M,1);


for n = 1:N
    x(1,n+1) = 2-((1-eps)*x(1,n))^2;
    for m = 2:M
        x(m,n+1) = 2-(eps*x(m-1,n) + (1-eps)*x(m,n))^2;
    end
end


x12 = [x(1,:)',x(2,:)'];
X = [x(:,1),x(:,1),x(:,2)];
pts = [(1:N-1)',(2:N)',(2:N)'];


% figure
% [f,xi] = ksdensity(x12,'Bandwidth',0.2);
% plot(xi,f);
% xlabel('xi')
% ylabel('f')
% 
% figure
% ksdensity(x12,xi,'Bandwidth',0.2);


% f = mvksdensity(X,pts,'Bandwidth',0.2);








