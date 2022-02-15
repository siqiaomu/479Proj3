clear all; format long; format compact;

%this is generating tent map with different epsilon values
M=100; N=100;
eps = linspace(0, 0.1, 4);
x1 = tent_map(M, N, eps(1));
x2 = tent_map(M, N, eps(2));
plot(1:N, x1(:, 40))
xlabel('n')
ylabel('x_n^40')

figure();
plot(1:N, x2(:, 40))
xlabel('n')
ylabel('x_n^40')

