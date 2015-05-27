function [ p ] = prob_error_M( Eb, No, M )
    a = 3*Eb;
    b = (M-1)*No;
    p = (1 - (1/sqrt(M)))*qfunc(sqrt(a/b));


end

