function [trans_probs, conditional_probs_2, conditional_probs_1, transition_tuple] = trans_probability_reverse(data, N, M) %tuple of 3
    %outputs each unique 3 tuple and the corresponding probabilities
    %step 1, compile 3-tuples
    tups = zeros((M-1)*(N-1), 3);
    discrete = zeros(N, M);
    discrete(data >=0.5) = 1;
    tups_idx = 0; %index of which tuple we r generating

    for n = 1:(N-1)
        for m = 1:(M - 1)
            tups_idx = tups_idx + 1;
            tups(tups_idx, :) = [discrete(n+1, m) discrete(n, m) discrete(n, m + 1)];
        end
    end

    %step 2, calculate joint probabilities (3 variables)
    [B, ~, ib] = unique(tups, 'rows'); 
    num_occur_3 = accumarray(ib, 1); %number of occurrences for each unique tuple
    trans_probs = num_occur_3/sum(num_occur_3);
    transition_tuple = B; %list of unique tuples
    
    %step 3 calculate the conditional probs 
    conditional_probs_2 = zeros(size(trans_probs));
    for i = 1:length(conditional_probs_2)
        tup = B(i, :);
        conditional_probs_2(i) = num_occur_3(i)/sum(num_occur_3(B(:, 2) == tup(2) & B(:, 3) == tup(3)));    
    end

    %step 4 calculate the other conditional probs (in the denominator)
    conditional_probs_1 = zeros(size(trans_probs));
    for i = 1:length(conditional_probs_1)
        tup = B(i, :);
        conditional_probs_1(i) = sum(num_occur_3(B(:, 1) == tup(1) & B(:, 2) == tup(2)))/sum(num_occur_3(B(:, 2) == tup(2)));    
    end
end
