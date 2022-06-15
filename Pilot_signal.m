clc; 

%% ****** Constant variables ***** %%
chanels = 5;
frequency = 1;
stability = 30;
amplitude = 20;

%% ****** Pilot and noice signals ***** %%
[m_t,t] = pilot_signal(amplitude, frequency);
m_t = binary(m_t, 1, stability);
R = noise(m_t, chanels, stability);
R = binary(R, chanels, stability);

%% ****** Signal processing ***** %%
Ps = (1/stability) * sum(m_t.*m_t, 2);  % 20 bits in sumatory
Pn = (1/stability) * sum(R.*R, 2);

SNRdb = 20*log(Ps ./ Pn);
SNR = 10.^(SNRdb ./ 20);

Pn = Ps ./ SNR;
An = sqrt(Pn);

%% ****** Binary values ***** %%
%m_t = dec2bin(m_t*100, 16);			% 11b
%R = dec2bin(m_t*100, 16);			% 13b
%Ps = dec2bin(Ps*100, 16);			% 15b
%Pn = dec2bin(Pn*100, 16);			% 15b
%SNRdb = dec2bin(SNRdb*100, 16);		% 8b
%SNR = dec2bin(SNR*100, 16);			% 7b
%An = dec2bin(An*100, 16);			% 11b

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

%% ****** Private funcions ***** %%
function [m_t,time] = pilot_signal(amplitude, frequency)
	time = 0:(1/29):1; 			%Time vector (30 samples)
	w = 2*pi*frequency; 		%Omega value	
	m_t = amplitude*cos(w*time); %Cosine signal
end 

function R = noise(m_t, chanels, stability)
	n = zeros(chanels,stability);	%noice matrix
	R = zeros(chanels,stability);

	for i=1 : 1 : chanels
		n(i, :) = rand(1,30)*2-1;
	end

	for i=1 : 1 : chanels
		R(i, :) = n(i, :) + m_t;
	end
end

function bit = binary(dec, chanels, stability)
	bit = abs(dec) * 10000;
	bit = dec2bin(bit,16);
	bit = bin2dec(bit);
	bit = bit/10000;

	bit = reshape(bit, chanels, stability);
end
