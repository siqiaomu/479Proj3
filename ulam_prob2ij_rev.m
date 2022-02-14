% now i_n corresponds to m-1 and j_n corresponds to m

% while it probably isn't necessary to make a whole new script for this (we could just manipulate the results of ulam_prob2ij,
% it's more convenient to do this. 
function [prob2ij_rev] = ulam_prob2ij_rev(data,r,d)

    sz = size(data);
    M = sz(1); N = sz(2);

    npts1 = (d(1) * 4/r(1)) + 1;
    npts2 = (d(2) * 4/r(2)) + 1;

    pts1 = linspace(-2,2,npts1);
    pts2 = linspace(-2,2,npts2);
    
    i_n_pts = pts1';
    j_n_pts = pts2';

    prob2ij_rev = zeros(M,npts1,npts2);
    
    tuples2 = zeros(M,N-1,2);

    % m = 1

    i_n = data(M,1:N-1);
    j_n = data(1,1:N-1);

    tuples2(1,:,:) = [i_n' j_n'];

    for m = 2:M
        i_n = data(m-1,1:N-1);
        j_n = data(m,1:N-1);

        tuples2(m,:,:) = [i_n' j_n'];
    end

    for m = 1:M
        to_test = zeros(N-1,2);
        to_test(:,:) = tuples2(m,:,:);

        for i = 1:npts1
            pts = [i_n_pts(i)*ones(npts2,1) j_n_pts];
            prob2ij_rev(m,i,:) = mvksdensity(to_test,pts,'bandwidth',r,'Kernel','box');
        end
    end

    prob2ij_rev = prob2ij_rev ./(M * d(1) * d(2)); 
end