function [prob2ii] = ulam_prob2ii(data,r,d)

    sz = size(data);
    M = sz(1); N = sz(2);

    npts1 = (d(1) * 4/r(1)) + 1;
    npts2 = (d(2) * 4/r(2)) + 1;

    pts1 = linspace(-2,2,npts1);
    pts2 = linspace(-2,2,npts2);
  
    i_np1_pts = pts1';
    i_n_pts = pts2';

    prob2ii = zeros(M,npts1,npts2);

    tuples2 = zeros(M,N-1,2);

    for m = 1:M
        i_np1 = data(m,2:N);
        i_n = data(m,1:N-1);

        tuples2(m,:,:) = [i_np1' i_n'];
    end

    for m = 1:M
        to_test = zeros(N-1,2);
        to_test(:,:) = tuples2(m,:,:);

        for i = 1:npts1
            pts = [i_np1_pts(i)*ones(npts2,1) i_n_pts];
            prob2ii(m,i,:) = mvksdensity(to_test,pts,'bandwidth',r,'Kernel','box');
        end
    end

    prob2ii = prob2ii./(M * d(1) * d(2));

end