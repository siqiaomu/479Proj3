eps = 0.6;
M = 100; N = 10^5 + 10000;
data = gen_ulam(M,N,eps);

r = [0.2 0.2 0.2];
d = [1 1 1];
[prob3_rev] = ulam_prob3_rev(data,r,d);
r = [0.2 0.2];
d = [1 1];
[prob2ij_rev] = ulam_prob2ij_rev(data,r,d);
r = [0.2 0.2];
d = [1 1];
[prob2ii] = ulam_prob2ii(data,r,d);
r = 0.2;
d = 1;
[prob1i] = ulam_prob1i(data,r,d);



T = 0; 

%for m = 1:size(prob3,1)

m = 2;
    for in1 = 1:size(prob3,2)
        for in = 1:size(prob3,3)
            for j = 1:size(prob3,4)
                
                if prob3_rev(m,in1,in,j) ~= 0 && prob2ij_rev(m,in,j) ~= 0 && prob2ii(m,in1,in) ~= 0 && prob1i(m,in) ~= 0
                    p3 = prob3_rev(m,in1,in,j);
                    p2 = p3/prob2ij_rev(m,in,j);
                    p1 = prob2ii(m,in1,in)/prob1i(m,in);
                    T = T + p3*log2(p2/p1);
                end
            end
        end
    end
        
%end








%end