function [trans_entropy] = tent_map_entropy(trans_probs, conditional_probs2,...
    conditional_probs1)
    
    trans_entropy = sum(trans_probs.*(log2(conditional_probs2) - log2(conditional_probs1)));



end