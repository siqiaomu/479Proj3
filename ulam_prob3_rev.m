% inputs are: data - generated using gen_ulam.m
%             r - a vector containing the desired resolution in each
%             "dimension" (one for i_{n+1}, one for i_n, one for j_n)
%             ex: [0.2 0.2 0.2]
%             d - a vector specifying how dense you want the discretization
%             in each "dimension" to be 
%             ex: [2 2 2] means we will be sampling twice as many points as
%             the minimum required to cover everything with resolution r

% this code does the same thing as ulam_prob3, except i_n+1 and i_n now
% correspond to the index m-1 and j_n now corresponds to the index m


function [prob3_rev] = ulam_prob3_rev(data,r,d)

    % get M and N from the data input
    sz = size(data);
    M = sz(1); N = sz(2);

    % at how many points in each "dimension" we will sample
    npts1 = d(1) * 4/r(1);
    npts2 = d(2) * 4/r(2);
    npts3 = d(3) * 4/r(3);

    % these are the points (we take them to be uniform/equally spaced)
    pts1 = linspace(-2,2,npts1);
    pts2 = linspace(-2,2,npts2);
    pts3 = linspace(-2,2,npts3);

    % just transposing to help out later
    i_np1_pts = pts1';
    i_n_pts = pts2';
    j_n_pts = pts3';

    % old code, can ignore
    %[x1,x2,x3] = ndgrid(i_np1_pts,i_n_pts,j_n_pts);
    %x1 = x1(:,:)'; x2 = x2(:,:)'; x3 = x3(:,:)';
    %xi = [x1(:) x2(:) x3(:)];

    % output will store joint pdf estimate for each tuple (identified by m), 
    % we discretize over space of all possible i_np1 (i.e., i_n+1), i_n, j_n
    prob3 = zeros(M,npts1,npts2,npts3); 
    
    % take 2d data and turn into set of all 3 tuples of interest
    
    % where we will store the 3 tuples
    tuples3 = zeros(M,N-1,3);
    
    % m = 1
    i_np1 = data(M,2:N); % i_{n+1} 
    i_n = data(M,1:N-1); % i_{n}
    j_n = data(1,1:N-1); % j_{n}

    tuples3(1,:,:) = [i_np1' i_n' j_n'];

    for m = 2:M
        i_np1 = data(m-1,2:N); % i_{n+1}
        i_n = data(m-1,1:N-1); % i_{n}
        j_n = data(m,1:N-1); % j_{n}

        tuples3(m,:,:) = [i_np1' i_n' j_n'];
    end

    % the 3-tuples have been set up

    % estimate joint pdf at each point in the 25 x 25 x 25 grid
    for m = 1:M
        to_test = zeros(N-1,3);
        to_test(:,:) = tuples3(m,:,:);

        % estimate joint pdf at each point in the 25 x 25 x 25 grid
        
        % more old code, ignore
        %p = mvksdensity(to_test,xi,'bandwidth',r,'Kernel','box');
        %szp = size(p);
        %prob3(m,1:szp(1)) = p;
        
        
        for i = 1:npts1
            for j = 1:npts2
                pts = [i_np1_pts(i)*ones(npts3,1) i_n_pts(j)*ones(npts3,1) j_n_pts ];
                % at each sampled point, counts all data in a cube with
                % side lengths of 2*r centered at that point
                prob3(m,i,j,:) = mvksdensity(to_test,pts,'Bandwidth',r,'Kernel','box');
            end
        end
       
    end 

end
   





