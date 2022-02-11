%function [prob3] = ulam_prob3(data,r)
    % I suggest running this as follows in your command line, except I 
    % would take M to be pretty small (like 2 or 3 or something)
    % if you just want to get a feel for what the full run time will be.
    % The goal output is to have an estimate of the joint pdf
    % for each 3 tuple of interest (an M x ? array).

    % In command line (maybe adjust M):
    M = 100; N = 10^5; r= [0.2 0.2 0.2];
    data = gen_ulam(M,N,0.3);
    %[prob3] = ulam_prob3(data,r); 

    sz = size(data);
    M = sz(1); N = sz(2);

    npts1 = 1.25 * 4/r(1);
    npts2 = 1.25 * 4/r(2);
    npts3 = 1.25 * 4/r(3);

    pts1 = linspace(-2,2,npts1);
    pts2 = linspace(-2,2,npts2);
    pts3 = linspace(-2,2,npts3);

    %pts_to_test = [pts1 ; pts2 ; pts3]';

    i_np1_pts = pts1';
    i_n_pts = pts2';
    j_n_pts = pts3';

    % output: for each tuple (identified by m), we discretize over space of
    % all possible i_np1, i_n, j_n,
    prob3 = zeros(M,npts1,npts2,npts3); 

    % 2d data into set of all necessary 3 tuples
    tuples3 = zeros(M,N-1,3);

    % m = 1
    for n = 1:N-1 % note: n corresponds to actual n +1
        j_n = data(M, n); i_n = data(1, n); i_np1 = data(1,n+1);
        tuples3(1,n,:) = [i_np1 i_n j_n];
    end
    % estimate joint pdf
    to_test = zeros(N-1,3);
    to_test(:,:) = tuples3(1,:,:);

    for i = 1:npts1
        for j = 1:npts2
            pts = [i_np1_pts(i)*ones(npts3,1) i_n_pts(j)*ones(npts3,1) j_n_pts ];
            [prob3(1,i,j,:),~] = mvksdensity(to_test,pts,'Bandwidth',r);
        end
    end

    for m = 2:M
        for n = 1:N-1
            j_n = data(m-1,n); i_n = data(m,n); i_np1 = data(m,n+1);
            tuples3(m,n,:) = [i_np1 i_n j_n];
        end
        % estimate joint pdf
        to_test = zeros(N-1,3);
        to_test(:,:) = tuples3(m,:,:);

        
        for i = 1:npts1
            for j = 1:npts2
                pts = [i_np1_pts(i)*ones(npts3,1) i_n_pts(j)*ones(npts3,1) j_n_pts ];
                [prob3(m,i,j,:),~] = mvksdensity(to_test,pts,'Bandwidth',r);
            end
        end
    end
    % output will be prob3
%end
