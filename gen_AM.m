%%  3.2
%B.

%..
%..
% 1)...

k = -10:0.01:10;    %Vektor k

w_s = 2*pi*50;  %cut-off frequency in Hz
w_c = 2*pi*1e3;    % träger-Frequenz in Hz
T_a = (2*pi/w_s)/2;    %Abtastperiode in s
A = 1;  %Amplitude des Trägers in Volt
phi = 0;    %Phase des trägers in grad
m_AM = 1; %Modulationsgrad m_AM = -min(s(t)) <= 1;

s_kTa = cos(w_s.*k*T_a);    %Quellensignal s(t)=cos(w_s*t)
m_kTa = A*cos(w_c.*k*T_a + phi);  %Trägersignal der das Quellensignal zu hohen Frequenzen trägt m(t) = A*cos(w_c*t + phi)
X_kTa = (1 + m_AM.*s_kTa).*m_kTa;    %Amplitudenmoduliertes Signal Xam_(t)=A(1+m_AMs(t))cos(wc.t + phi);

%Generierung von s(t) und Xam(t)
subplot(2,1,1);
plot(k,s_kTa, 'DisplayName', 's(t)');
[up,lo]=envelope(s_kTa,100,'analytic');
hold on
plot(k,up, '--', 'linewidth', 1.5, 'DisplayName', 'Pos envelope')
plot(k,lo, '--', 'linewidth', 1.5, 'DisplayName', 'Neg envelope')
xlabel('t[sec]')
ylabel('Amplitude[Volt]')
legend;
grid on;
hold off

subplot(2,1,2);
plot(k,X_kTa, 'DisplayName', 'Xam(t)');
[up2,lo2]=envelope(X_kTa,100,'analytic');
hold on
plot(k,up2, '--', 'linewidth', 1.5, 'DisplayName', 'Pos envelope')
plot(k,lo2, '--', 'linewidth', 1.5, 'DisplayName', 'Neg envelope')
xlabel('t[sec]')
ylabel('Amplitude[Volt]')
legend;
grid on;
hold off

%%  Generierung eines AM-Signals mit einem Bandlimitierten Quellsignal
w_sf = 2*pi*1;   %cut-off frequency in Hz
w_0 = 2*pi*1;    % signal frequencs in Hz
w_c1 = 2*pi*12;  % trägerfrequenz in Hz
A = 1;  % Amplitude in Volt
a = 0.75;   % constant
T_a1 = (2*pi/w_sf)/2;    %Abtastperiode in s
m_AM1 = 1;     %Modulationsordnung

m_kTa1 = A*cos(w_c1.*k*T_a1 + phi);  %Trägersignal der das Quellensignal zu hohen Frequenzen trägt m(t) = A*cos(w_c*t + phi)
% Generierung des Bandbegrenztes Signal Sr(t) im Zeitbereich
Sr_kTa = (((w_sf+w_0/2)/pi)*sinc((w_sf+w_0/2).*k*T_a1)) - ...
    ((a*(w_sf-w_0/2)/pi)*sinc((w_sf-w_0/2).*k*T_a1)) - ...
    (w_sf*(1-a)/pi)*sinc(w_sf.*k*T_a1).*sinc((w_0.*k*T_a1)/2);
figure;
subplot(2,1,1);
plot(k,Sr_kTa, 'DisplayName', 'Sr(t)');
[up,lo]=envelope(Sr_kTa,100,'analytic');
hold on
plot(k,up, '--', 'linewidth', 1.5, 'DisplayName', 'Pos envelope')
plot(k,lo, '--', 'linewidth', 1.5, 'DisplayName', 'Neg envelope')
xlabel('t[sec]')
ylabel('Amplitude[Volt]')
legend;
grid on;
hold off

% Generierung des Amplitudenmoduliertes Signal Xam,r(t) im Zeitbereich
XrAM_kTa = (1+m_AM1*Sr_kTa).*m_kTa1;
subplot(2,1,2);
plot(k,XrAM_kTa, 'DisplayName', 'Xam,r(t)');
[up,lo]=envelope(XrAM_kTa,100,'analytic');
hold on
plot(k,up, '--', 'linewidth', 1.5, 'DisplayName', 'Pos envelope')
plot(k,lo, '--', 'linewidth', 1.5, 'DisplayName', 'Neg envelope')
xlabel('t[sec]')
ylabel('Amplitude[Volt]')
legend;
grid on;
hold off




