function [prob2ij] = ulam_prob2ij(data,r,d)

    sz = size(data);
    M = sz(1); N = sz(2);

    npts1 = d(1) * 4/r(1);
    npts2 = d(2) * 4/r(2);

    pts1 = linspace(-2,2,npts1);
    pts2 = linspace(-2,2,npts2);
    
    i_n_pts = pts1';
    j_n_pts = pts2';

    prob2ij = zeros(M,npts1,npts2);
    
    tuples2 = zeros(M,N-1,2);

    % m = 1

    i_n = data(1,1:N-1);
    j_n = data(M,1:N-1);

    tuples2(1,:,:) = [i_n' j_n'];

    for m = 2:M
        i_n = data(m,1:N-1);
        j_n = data(m-1,1:N-1);

        tuples2(m,:,:) = [i_n' j_n'];
    end

    for m = 1:M
        to_test = zeros(N-1,2);
        to_test(:,:) = tuples2(m,:,:);

        for i = 1:npts1
            pts = [i_n_pts(i)*ones(npts2,1) j_n_pts];
            prob2ij(m,i,:) = mvksdensity(to_test,pts,'bandwidth',r,'Kernel','box');
        end
    end

end