function [ B, Y ] = staticFFR_modulation( X,N, Eb )
    SNR = Eb/N;
    if SNR > 600
        [ B, Y ] = q64_modulation(X,N,Eb);
    elseif SNR < 600 && SNR > 50
        [ B, Y ] = q16_modulation(X,N,Eb);
    elseif SNR < 50 && SNR > 1
        [ B, Y ] = qpsk_modulation(X,N,Eb);
    else
        [ B, Y ] = bpsk_modulation(X,N,Eb);
    end

end

