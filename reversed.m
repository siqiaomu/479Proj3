clear all; format long; format compact;
%construction of time series using tent map
M=100; % number of x^m on the grid [0,1]
N=2e5; %number of timesteps
%eps = 0.02;
%x_series_left = x_series(:,1:M-1); %stores data for x_{m-1}
%x_series_right = x_series(:, 2:M); %stores data for x_m

eps = linspace(0.001, 0.05, 20);
trans_entropy = zeros(1, 20);
error = zeros(2,20); %for errorbar. records the length below mean and above mean
for i=1:length(eps)
    temp = zeros(1,10); %records entropy of each of the 10 runs
    for k=1:10 %take the average of 10 runs
        x_series = tent_map(M, N, eps(i));
        [trans_probs, conditional_probs_2, conditional_probs_1, transition_tuple] = trans_probability_reverse(x_series(1e5+1:2e5, :), 1e5, M);
        temp(i) = tent_map_entropy(trans_probs, conditional_probs_2, conditional_probs_1);
    end
    trans_entropy(i) = mean(temp);
    error(1,i) = mean(temp) - min(temp);
    error(2,i) = max(temp) - mean(temp);
end

%errorbar(eps, trans_entropy, error(1,:), error(2,:), 'd',...
%    'MarkerEdgeColor', 'red', 'MarkerFaceColor', 'red')
%hold on;
plot(eps, trans_entropy, '-d'); %mean 
xlabel('\epsilon')
ylabel('transfer entropy T_{I^{m-1}\rightarrow I^m}')
figure()
plot(eps, trans_entropy./(eps.^2), '-g')
xlabel('\epsilon')
ylabel('T_{I^{m-1}\rightarrow I^m}/\epsilon^2')


