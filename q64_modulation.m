function [B, Y ] = q64_modulation( X,N,E )
    B = 0.125*length(X);
    p = 0.5*erfc(sqrt(E/N)*sin(pi/64));
    s = size(X);
    N = s(1,1);
    E = rand(N,1)<p;                % Error profile
    Y = xor(X,E);                   % Data frame after passing through channel


end

