%% Parameter definition
clear all;
close all;

m=1;
Fs = 1000;
k = -10:1/Fs:10;    %Vektor k

w_s = 2*pi*10;  %Hz cut-off frequency in Hz
w_c = 2*pi*1e2;    % träger-Frequenz in Hz
T_a = (2*pi/w_s)/2;    %Abtastperiode in sec
A_1 = 1;  %Amplitude des Trägers in V
phi = 0;    %Phase des trägers
phi_1 = 0;
s_kTa = cos(w_s.*k*T_a);    %Quellensignal s(t)=cos(w_s*t)
m1_kTa = A_1*cos(w_c.*k*T_a + phi);  %Trägersignal der das Quellensignal zu hohen Frequenzen trägt m1(t) = A*cos(w_c*t + phi)
m2_kTa = A_1*cos(w_c.*k*T_a + phi_1);  %Trägersignal der das Quellensignal zu hohen Frequenzen trägt m2(t) = A*cos(w_c*t + phi')

X_kTa = (1+m*s_kTa).*m1_kTa;    %moduliertes Signal x_(t) durch ein einfacher idealer modulator
Y_kTa = X_kTa;      %y_am(t) = x_am(t), weil n(t)=0. Keine additive Rauschen
Z_avd = Y_kTa.*m2_kTa;     %z_avd(t) = y_am(t)m2(t)
f_high = w_s;
f_low = -w_s;

[B,A]=butter(1, f_high/Fs,"low");   %compute of the lowpass filter with N=1 and Wn=0.25
figure
freqz(B, A, [],w_s/2*pi)    %Dartsellung des Frequenzgangs des Tiefpassfilters
h_kTa = sinc(2*pi*12.5*k*T_a);      %Compute the lowpass filter h(kTa) with Grenzfrequenz 12.5Hz

subplot(2,1,1)
plot(k, s_kTa);
xlabel('t [s]')
ylabel('Amplitude [Volt]')
title('Quellensignal s(kTA)')
grid on
subplot(2,1,2)
plot(k, m1_kTa);
xlabel('t [s]')
ylabel('Amplitude [Volt]')
title('Modulation m(kTA)')
grid on

figure
subplot(2,1,1)
plot(k, Y_kTa);
xlabel('t [s]')
ylabel('Amplitude [Volt]')
hold on
plot(k, abs(A_1*(1+m*s_kTa)),'--');
plot(k, -abs(A_1*(1+m*s_kTa)),'--');
title('Eingangssignal des Receivers Y(kTA)')
grid on
hold off
subplot(2,1,2)
plot(k, Z_avd);
xlabel('t [s]')
ylabel('Amplitude [Volt]')
%hold on
%plot(k, abs(A_1*(1+m*s_kTa)),':diamondr');
title('Ausgangssignal des Receivers z_{DAM}(kTA)')
grid on
%hold off

figure
plot(k, h_kTa)
grid on
xlabel('t [s]')
ylabel('Amplitude [Volt]')
g_kTa = conv(Z_avd, h_kTa, 'same');     %Berechnug der Faltung zur emittlung von g(kTa)
figure
plot(k, g_kTa)
grid on


%%  2.    Bandlimites Signal
clear all;
close all;

m=1;
Fs = 100;
k = -10:1/Fs:10;    %Vektor k

w_sf = 2*pi*1;   %cut-off frequency in Hz
w_0 = 2*pi*2;    % signal frequencs in Hz
w_c1 = 2*pi*5;  % trägerfrequenz in Hz
A_1 = 1;  % Amplitude in Volt
a = 0.75;   % constant
T_a1 = (2*pi/w_sf)/2;    %Abtastperiode in s
phi_1 = 0;    %Phase des trägers
phi_2 = 0;    %Phase des trägers

m1_kTa1 = A_1*cos(w_c1.*k*T_a1 + phi_1);  %Trägersignal der das Quellensignal zu hohen Frequenzen trägt m1(t) = A*cos(w_c*t + phi)
m2_kTa1 = A_1*cos(w_c1.*k*T_a1 + phi_2);  %Trägersignal der das Quellensignal zu hohen Frequenzen trägt m2(t) = A*cos(w_c*t + phi')

% Generierung des Bandbegrenztes Signal Sr(t) im Zeitbereich
Sr_kTa = (((w_sf+w_0/2)/pi)*sinc((w_sf+w_0/2).*k*T_a1)) - ...
    ((a*(w_sf-w_0/2)/pi)*sinc((w_sf-w_0/2).*k*T_a1)) - ...
    (w_sf*(1-a)/pi)*sinc(w_sf.*k*T_a1).*sinc((w_0.*k*T_a1)/2);
X_kTa = (1+m*Sr_kTa).*m1_kTa1;    %moduliertes Signal x_(t) durch ein einfacher idealer modulator
Y_kTa = X_kTa;      %y_am(t) = x_am(t), weil n(t)=0. Keine additive Rauschen
Z_avd = Y_kTa.*m2_kTa1;  %compute the Signal vor dem Lowpass
f_high = w_sf;
f_low = -w_sf;
[B,A]=butter(1, f_high/Fs,"low");   %compute of the lowpass filter with N=1 and Wn=0.25
figure
freqz(B, A, [],w_sf/2*pi)    %Dartsellung des Frequenzgangs des Tiefpassfilters
h_kTa = sinc(2*pi*12.5*k*T_a1);      %Compute the lowpass filter h(kTa) with Grenzfrequenz 25Hz

subplot(2,1,1)
plot(k, Sr_kTa)
xlabel('t [s]')
ylabel('Amplitude [Volt]')
title('Quellensignal sr(kTA)')
grid on
subplot(2,1,2)
plot(k, m1_kTa1);
xlabel('t [s]')
ylabel('Amplitude [Volt]')
title('Modulation m(kTA)')
grid on

figure
subplot(2,1,1)
plot(k, Y_kTa);
xlabel('t [s]')
ylabel('Amplitude [Volt]')
hold on
plot(k, abs(A_1*(1+m*Sr_kTa)),'--');
plot(k, -abs(A_1*(1+m*Sr_kTa)),'--');
title('Eingangssignal des Receivers Y(kTA)')
grid on
hold off
subplot(2,1,2)
plot(k, Z_avd);
xlabel('t [s]')
ylabel('Amplitude [Volt]')
hold on
plot(k, abs(A_1*(1+m*Sr_kTa)),':diamondr');
title('Ausgangssignal des Receivers Y(kTA)')
grid on
hold off

figure
plot(k, h_kTa)
grid on
xlabel('t [s]')
ylabel('Amplitude [Volt]')
%ylim([-50,50])
g_kTa = conv(Z_avd, h_kTa, 'same');     %Berechnug der Faltung zur emittlung von g(kTa)
figure
plot(k, g_kTa)
xlabel('t [s]')
ylabel('Amplitude [Volt]')
title('lowpass output g(kTa)')
grid on