function [prob1i] = ulam_prob1i(data,r,d)
    
    sz = size(data);
    M = sz(1); N = sz(2);


    npts1 = d(1) * 4/r(1);
    
    pts1 = linspace(-2,2,npts1);
  
    i_n_pts = pts1';

    prob1i = zeros(M,npts1);

    for m = 1:M
        i_n = data(m,1:N-1);
        prob1i(m,:) = ksdensity(i_n',pts1,'Bandwidth',r,'Kernel','box');


    end

    


end