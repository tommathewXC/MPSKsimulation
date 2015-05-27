clear;
clc;
M = 20;
data_frane_length = 10;                         %   data frame length
X = round(rand(data_frane_length,1));           %   generate random data
Eb = 20;                                        %   Average bit energy
num_of_channels = 50;                           %   number of channels in the range
fmin = 100;                                     %   min freq
fmax = 1000;                                    %   max freq
channel_separation = 5;                         %   minimum separation
packet_drop_threshold = 0.3;
Noise_amplitude = 1000;


% define a K communication systems on that range all on QPSK
C = linspace(fmin,fmax,num_of_channels);
V = zeros(size(C));

%------------QPSK modulation over the entire spectrum---------------------
% P_D = 1:Noise_amplitude;
% E_V = P_D;
% S_B = E_V;
% for k =1:Noise_amplitude
%     Noise_vector = k*rand(size(C));
%     error_vales = V;
%     packet_drops = V;
%     successful_bits = V;
%     for j = 1:length(C)
%         er = 0;
%         pack = 0;
%         bits_transfered = 0;
%         for i = 1:M
%             [bits, Y] = qpsk_modulation(X,Noise_vector(j),Eb);
%             if bit_error(X,Y) > packet_drop_threshold
%                 pa = 1;
%             else
%                 pa = 0;
%             end
%             bits_transfered = bits_transfered + (bits*(1 - bit_error(X,Y)));
%             pack = pack + pa;
%             er = er + bit_error(X,Y);
%         end
%         successful_bits(j) = bits_transfered;
%         packet_drops(j) = 100*pack/M;
%         error_values(j) = er/M;
%     end
%     P_D(k) = mean(packet_drops);
%     E_V(k) = mean(error_values);
%     S_B(k) = mean(successful_bits);
% end
% 
% figure
% plot(10*log10(Eb./(1:Noise_amplitude)),P_D);
% xlabel('SNR')
% ylabel('Packets dropped')
% title('Packets dropped vs. Noise with no FFR')
% grid on
% 
% figure
% plot(10*log10(Eb./(1:Noise_amplitude)),E_V);
% xlabel('SNR')
% ylabel('Average error value')
% title('Average symbol error vs. Noise with no FFR')
% grid on
% 
% figure
% plot(10*log10(Eb./(1:Noise_amplitude)),S_B);
% xlabel('SNR')
% ylabel('Average bits sent')
% title('Bits sent over channel vs. Noise with no FFR')
% grid on

%--------------------------------------------------------------------------



%-------------------Static FFR---------------------------------------------
% P_D = 1:Noise_amplitude;
% E_V = P_D;
% S_B = E_V;
% for k =1:Noise_amplitude
%     Noise_vector = k*rand(size(C));
%     packet_drops = V;
%     successful_bits = V;
%     for j = 1:length(C)
%         SNR = Eb/Noise_vector(j);
%         
%         if SNR>20
%             pack = 0;
%             bits_transfered = 0;
%             for i = 1:M
%                 [bits, Y] = qpsk_modulation(X,Noise_vector(j),Eb);
%                 if bit_error(X,Y) > packet_drop_threshold
%                     pa = 1;
%                     BB = 1;
%                 else
%                     pa = 0;
%                     BB = bit_error(X,Y);
%                 end
%                 bits_transfered = bits_transfered + (bits*(1 - BB));
%                 pack = pack + pa;
%             end
%             successful_bits(j) = bits_transfered;
%             packet_drops(j) = 100*pack/M;
%         end
% 
%      end
% %     P_D(k) = mean(packet_drops);
%     S_B(k) = mean(successful_bits);
% end
% 
% % figure
% % plot(10*log10(Eb./(1:Noise_amplitude)),P_D);
% % xlabel('SNR')
% % ylabel('Packets dropped')
% % title('Packets dropped vs. Noise with static FFR')
% % grid on
% 
% figure
% plot(10*log10(Eb./(1:Noise_amplitude)),S_B);
% xlabel('SNR')
% ylabel('Average bits sent')
% title('Bits sent over channel vs. Noise with static FFR')
% grid on
%--------------------------------------------------------------------------




%---------------------------Adaptive FFR-----------------------------------
P_D = 1:Noise_amplitude;
E_V = P_D;
S_B = E_V;
for k =1:Noise_amplitude
    Noise_vector = k*rand(size(C));
    error_vales = V;
    packet_drops = V;
    successful_bits = V;
    for j = 1:length(C)
        er = 0;
        pack = 0;
        bits_transfered = 0;
        for i = 1:M
            [bits, Y] = smart_modulation(X,Noise_vector(j),Eb);
            if bit_error(X,Y) > packet_drop_threshold
                pa = 1;
                BB = 1;
            else
                pa = 0;
                BB = bit_error(X,Y);
            end
            bits_transfered = bits_transfered + (bits*(1 - BB));
            pack = pack + pa;
            er = er + bit_error(X,Y);
        end
        successful_bits(j) = bits_transfered;
        packet_drops(j) = 100*pack/M;
        error_values(j) = er/M;
    end
    P_D(k) = mean(packet_drops);
    E_V(k) = mean(error_values);
    S_B(k) = mean(successful_bits);
end

figure
plot(10*log10(Eb./(1:Noise_amplitude)),P_D);
xlabel('SNR')
ylabel('Packets dropped')
title('Packets dropped vs. Noise with adaptive FFR')
grid on

figure
plot(10*log10(Eb./(1:Noise_amplitude)),E_V);
xlabel('SNR')
ylabel('Average error value')
title('Average symbol error vs. Noise with adaptive FFR')
grid on

figure
plot(10*log10(Eb./(1:Noise_amplitude)),S_B);
xlabel('SNR')
ylabel('Average bits sent')
title('Bits sent over channel vs. Noise with adaptive FFR')
grid on

%--------------------------------------------------------------------------




% E = 0.0001:0.01:1000;
% N = 1;
% p = 2*qfunc(sqrt(2*E/N));
% pp = 2*qfunc(sqrt(2*E/N)*sin(pi/16));
% ppp = 2*qfunc(sqrt(2*E/N)*sin(pi/64));
% plot(E,p)
% hold on
% plot(E,pp,'r')
% plot(E,ppp,'g')
% grid on