clc; 

%% ****** Constant variables ***** %%
chanels = 3;
frequency = 899000000; %899Mhz
stability = 80;
amplitude = 1.2;
sampling_time = 0.0000001;	% 100 ns

%% ****** Pilot and noise signals ***** %%
[m_t,t] = pilot_signal(amplitude, frequency, stability, sampling_time);
m_t = binary(m_t, 1, stability);
m_t =round(m_t,3);

R = noise(m_t, chanels, stability);
R =round(R,3);

R = binary(R, chanels, stability);
R =round(R,3);

%% ****** Signal processing ***** %%
Ps = (1/stability) * sum(m_t.*m_t, 2);  % 20 bits in sumatory
Ps =round(Ps,3);

Pn = (1/stability) * sum(R.*R, 2);
Pn =round(Pn,3);

SNRdb = 20*log(Ps ./ Pn);
SNRdb =round(SNRdb,3);

SNR = 10.^(SNRdb ./ 20);
SNR =round(SNR,3);

Pn = Ps ./ SNR;
Pn =round(Pn,3);

An = sqrt(Pn);
An =round(An,3);

An = sort(An);
if length(unique(An)) == length(An)
	disp('All elements are unique')
else
	fprintf('Repited values: %.4f',length(An)-length(unique(An)))
end


%% ****** Ploting signals ***** %%
%figure(1)
%plot(t, m_t, 'b', 'LineWidth',3) 
%xlabel('Time (s)'); ylabel('Voltage')
%grid on
%
%figure(2)
%plot(t, R, 'R', 'LineWidth',3) 
%xlabel('Time (s)'); ylabel('Voltage')
%grid on

clear t stability chanels frequency amplitude;


%% ****** Binary values ***** %%
m_t = dec2bin(m_t*100);			% 11b
R = dec2bin(m_t*100);			% 13b
Ps = dec2bin(Ps*100);			% 15b
Pn = dec2bin(Pn*100);			% 15b
SNRdb = dec2bin(SNRdb*100);		% 8b
SNR = dec2bin(SNR*100);			% 7b
An = dec2bin(An*100);			% 11b


%% ****** Private funcions ***** %%
function [signal,time] = pilot_signal(amplitude, frequency, stability, sampling_time)
	time = 0 : (1 / (stability*(1/sampling_time)-1)) : sampling_time; 	
	w = 2*pi*frequency; %Omega value	
	signal = amplitude*cos(deg2rad(w*time)); 
end 

function noise_signal = noise(m_t, chanels, stability)
	just_noise = zeros(chanels,stability);	
	noise_signal = zeros(chanels,stability);

	for i=1 : 1 : chanels
		just_noise(i, :) = rand(1,stability)*2-1;
	end

	for i=1 : 1 : chanels
		noise_signal(i, :) = just_noise(i, :) + m_t;
	end
end

function dec_2_bin = binary(decimal, chanels, stability)
	dec_2_bin = abs(decimal) * 10000;
	dec_2_bin = dec2bin(dec_2_bin,16);
	dec_2_bin = bin2dec(dec_2_bin);
	dec_2_bin = dec_2_bin/10000;

	dec_2_bin = reshape(dec_2_bin, chanels, stability);
end
