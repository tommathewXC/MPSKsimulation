function [ err ] = bit_error( X,Y )
    M = length(X);
    err = sum(abs(X-Y))/M;
end

