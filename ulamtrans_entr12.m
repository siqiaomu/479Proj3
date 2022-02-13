 %Tj-i

function [T] = ulamtrans_entr12(data)

r = [0.2 0.2 0.2];
d = [2 2 2];


[prob3] = ulam_prob3(data,r,d);
[prob1i] = ulam_prob1i(data,r,d);
[prob2ii] = ulam_prob2ii(data,r,d);
[prob2ij] = ulam_prob2ij(data,r,d);
T = 0;

for m = 1:size(prob3,1)
    for in1 = 1:size(prob3,2)
        for in = 1:size(prob3,3)
            for j = 1:size(prob3,4)
                
                p3 = prob3(m,in1,in,j);
                p2 = p3/prob2ij(m,in,j);
                p1 = prob2ii(m,in1,in)/prob1i(m,in);
                T = T + p3*log2(p2/p1);
            end
        end
    end
        
end









end