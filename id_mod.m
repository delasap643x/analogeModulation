%%  3.2 AM-Modulation
% Idealer Modulator
%..
%..
k = -10:0.01:10;    %Vektor k

w_s = 2*pi*50;  %Hz cut-off frequency
w_c = 2*pi*1e3;    % träger-Frequenz
T_a = (2*pi/w_s)/2;    %Abtastperiode
A = 1;  %Amplitude des Trägers
phi = 0;    %Phase des trägers

s_kTa = cos(w_s.*k*T_a);    %Quellensignal s(t)=cos(w_s*t)
m_kTa = A*cos(w_c.*k*T_a + phi);  %Trägersignal der das Quellensignal zu hohen Frequenzen trägt m(t) = A*cos(w_c*t + phi)
X_kTa = s_kTa.*m_kTa;    %moduliertes Signal x_(t) durch ein einfacher idealer modulator

%Generierung von s(t) und x(t) mit deren hüllkurven
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
plot(k,up, '--', 'linewidth', 1.5, 'DisplayName', 'Pos envelope')
plot(k,lo, '--', 'linewidth', 1.5, 'DisplayName', 'Neg envelope')
xlabel('t[sec]')
ylabel('Amplitude[Volt]')
legend;
grid on;
hold off
grid on;




