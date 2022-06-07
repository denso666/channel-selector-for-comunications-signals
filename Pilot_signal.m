clc; clear all;
format short g;

chanels = 5;
stability = 30;
amplitude = 20;
frequency = 1;

[m_t,t] = pilot_signal(amplitude, frequency);
r = noise(m_t, chanels, stability);

bit = abs(r) * 100;
bit = dec2bin(bit);
bit = bin2dec(bit);

bit = reshape(bit, chanels, stability);

figure(1)
plot(t, m_t, 'b', 'LineWidth',3) 
xlabel('Time (s)'); ylabel('Voltage')
grid on

figure(2)
plot(t, r, 'r', 'LineWidth',3) 
xlabel('Time (s)'); ylabel('Voltage')
grid on

figure(3)
plot(t, bit, 'r', 'LineWidth',3) 
xlabel('Time (s)'); ylabel('Voltage')
grid on

function [m_t,time] = pilot_signal(amplitude, frequency)
	time = 0:(1/29):1; 			%Time vector (30 samples)
	w = 2*pi*frequency; 		%Omega value	
	m_t = amplitude*cos(w*time); %Cosine signal
end 

function r = noise(m_t, chanels, size)
	n = zeros(chanels,size);	%noice matrix
	r = zeros(chanels,size);

	for i=1 : 1 : chanels
		n(i, :) = rand(1,30)*2-1;
	end

	for i=1 : 1 : chanels
		r(i, :) = n(i, :) + m_t;
	end
end