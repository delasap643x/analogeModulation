%%3    Versuchdurchführung AM
%% 3.1  Grundlagen, Systemmodell
%1.
%Parameter definition
clear all;
close all;

Fs=1000;    %sample frequency
Fc=100; %carrier frequency
Fm=10; %message Frequency in 1/s
phase=22.5;   %angle phi of carrier signal
a=1;    %Amplitude
k=0:1/Fs:80;    %Vector definition k
s_kTa=sinc(pi/8.*(k-40));    %compute of signal s(kTa)
m1_kTa=a*cos(2*pi*Fc*k);   %compute of carrier signal m1(kTa)=cos(wc*k*Ta)
m2_kTa=a*cos(2*pi*Fc*k+phase); %compute of carrier signal m2(kTa)=cos(wc*k*Ta + phase)

[B,A]=butter(1, 0.125);   %compute of the lowpass filter with N=8 and Wn=1/16*pi

g_kTa=filter(B, A, s_kTa.*m1_kTa.*m2_kTa);    %output signal nach dem Lowpass
plot(k, s_kTa, 'DisplayName', 's(kT_A)');
hold on
plot(k, g_kTa, 'DisplayName', 'g(kT_A)')
hold off
grid on
title('plot of s(kTa) and g(kTa)')
xlabel('t[sec]')
ylabel('Amplitude[Volt]')
legend

%%  plot of signals s(kTa)m1(kTa) and y(kTa)m2(kTa)
figure
subplot(2,1,1);
plot(k, s_kTa.*m1_kTa, 'r');
grid on
title('plot of s(kTa)m1(kTa)')
xlabel('t[sec]')
ylabel('Amplitude[Volt]')
subplot(2,1,2);
plot(k, s_kTa.*m1_kTa.*m2_kTa, 'b');
grid on
title('plot of y(kTa)m2(kTa)')
xlabel('t[sec]')
ylabel('Amplitude[Volt]')

%%  2.
% Siehe Ausarbeitung mit Parameter value

%%  3.
noise = rand(size(k));
g_kTa_noise = filter(B, A, (s_kTa.*m1_kTa + noise).*m2_kTa);
snr_1 = snr(s_kTa.*m1_kTa, noise);
figure
plot(k, g_kTa_noise, ':diamondr')
grid on
title('plot of g(kTa) with add noise')
xlabel('t[sec]')
ylabel('Amplitude[Volt]')

%%  Amplitude Modulation



