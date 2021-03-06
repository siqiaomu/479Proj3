clear all; format long; format compact;
%construction of time series using tent map
M=100; % number of x^m on the grid [0,1]
N=2000; %number of timesteps
%eps = 0.02;
%x_series_left = x_series(:,1:M-1); %stores data for x_{m-1}
%x_series_right = x_series(:, 2:M); %stores data for x_m

%eps = linspace(0.001, 0.05, 20);
%trans_entropy = zeros(1, 20);
%error = zeros(2,20); %for errorbar. records the length below mean and above mean
% for i=1:length(eps)
%     temp = zeros(1,10); %records entropy of each of the 10 runs
%     for k=1:10 %take the average of 10 runs
%         x_series = tent_map(M, N, eps(i));
%         [trans_probs, conditional_probs_2, conditional_probs_1, transition_tuple] = trans_probability(x_series(N/2+1:N, :), N/2, M);
%         temp(k) = tent_map_entropy(trans_probs, conditional_probs_2, conditional_probs_1);
%     end
%     %trans_entropy(i) = temp;
%     trans_entropy(i) = mean(temp);
% %     error(1,i) = mean(temp) - min(temp);
% %     error(2,i) = max(temp) - mean(temp);
% end

eps = 0.03;
trans_entropy = zeros(1, 21);
N = linspace(100, 2100, 21);
error = zeros(2,21);
for i=1:length(N)
    temp = zeros(1, 10);
    for k=1:10
        x_series = tent_map(M, N(i),eps);
        [trans_probs, conditional_probs_2, conditional_probs_1, transition_tuple] = trans_probability(x_series(N(i)/2+1:N(i), :), N(i)/2, M);
        temp(k) = tent_map_entropy(trans_probs, conditional_probs_2, conditional_probs_1);
    end
    trans_entropy(i) = mean(temp);
    error(1,i) = mean(temp) - min(temp);
    error(2,i) = max(temp) - mean(temp);

end
errorbar(N, trans_entropy, error(1,:), error(2,:), 'd',...
   'MarkerEdgeColor', 'red', 'MarkerFaceColor', 'red')
xlabel('N')
ylabel('Entropy')
title('T_{I^{m-1}\rightarrow I^m} versus number of iterations (\epsilon = 0.03)')




%errorbar(eps, trans_entropy, error(1,:), error(2,:), 'd',...
%   'MarkerEdgeColor', 'red', 'MarkerFaceColor', 'red')
%hold on;
%plot(eps, trans_entropy)
%plot(eps, 0.77^2*eps.^2./log(2), '-b'); 
% xlabel('\epsilon')
% ylabel('transfer entropy T_{I^{m-1}\rightarrow I^m}')
% legend('error bars', 'theoretical line')
% figure()
% plot(eps.^2, trans_entropy, '-g')
% xlabel('\epsilon^2')
% ylabel('T_{I^{m-1}\rightarrow I^m}')


