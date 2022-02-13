%recrete plot of T vs eps from paper

T = zeros(1,100);
eps = 0:.01:1;
M = 100;
N = 110000;


for i = 1:100
    [data] = gen_ulam(M,N,eps);
    T(i) = ulamtrans_entr12(data);
end

plot(eps,T)