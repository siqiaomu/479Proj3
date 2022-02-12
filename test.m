clear;
A = [ 1     2     3
      1     2     3
      2     2     3
      3     2     1
      1     2     3
      3     2     1];
[B, ia, ib] = unique(A, 'rows');
numoccurences = accumarray(ib, 1);
indices = accumarray(ib, find(ib), [], @(rows){rows}); 