function [trans_probs, transition_tuple] = trans_probability(data, N, M) %tuple of 3
    discrete = zeros(N, M);
    tups = zeros((M-1)*(N-1), 3);
    discrete(data >=0.5) = 1;
    tups_idx = 0; %which tuple we r generating
    for n = 1:(N-1)
        for m = 1:(M - 1)
            tups_idx = tups_idx + 1;
            tups(tups_idx, :) = [discrete(n, m:m+1) discrete(n+1, m+1)];
        end

    end

    [B, ~, ib] = unique(tups, 'rows');
    numoccurences = accumarray(ib, 1); %number of occurrences for each unique tuple
    trans_probs = numoccurences/sum(numoccurences);
    transition_tuple = B; %list of unique tuples


end
