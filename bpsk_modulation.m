function [ B, Y ] = bpsk_modulation( X,N,E )
    B = length(X);
    p = 0.5*erfc(sqrt(2*E/N));
    s = size(X);
    N = s(1,1);
    E = rand(N,1)<p;                % Error profile
    Y = xor(X,E);                   % Data frame after passing through channel


end

