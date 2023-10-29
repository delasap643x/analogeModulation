
AM=1;
w_c = 10000;
phi = 0;
%phi_2 = 180;
N = 8;
w_m = 1/16*pi;
Omega_c = pi*w_c;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Erzeugung von s(kTa) Quellensignal                                        %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
k = 0:1:80;
S_kTa = 8.*sin((pi/8).*(k-40))/pi.*(k-40);
x_kTa = S_kTa.*0.5.*(cos((k.*2*Omega_c) + phi) + cos(phi));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Erzeugung des butterworth filter                            %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[B,A] = butter(N, w_m); % mit N=8 und w_m=1/16pi
g_kTa = filter(B,A,x_kTa);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Erzeugung von modulation -und Demodulationssignal           %                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
m1_kTa = AM*cos(Omega_c.*k);
m2_kTa = AM*cos(Omega_c.*k + phi);
s_m1_kTa = S_kTa.*m1_kTa;
y_kTa = s_m1_kTa.*m2_kTa;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Erzeugung von Diagrammen                                    %                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
plot(k, S_kTa, 'DisplayName', 's(kTA)');
hold on;
plot(k, g_kTa, 'DisplayName', 'g(kTA)');
grid on;
hold off;
lgd = legend;
lgd.NumColumns = 1;

figure;
subplot(2,1,1);
plot(k,s_m1_kTa, 'DisplayName', 's(kTA)m1(kTa)');
lgd = legend;
lgd.NumColumns = 1;

subplot(2,1,2);
plot(k,y_kTa,'r', 'DisplayName', 'y(kTA)m2(kTa)');
lgd = legend;
lgd.NumColumns = 1;

figure;
plot(abs(freqz(B,A,N)));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Erzeugung Signal mit Rauschen                               %                                                             %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure;
awgn = rand(size(k));   % AWGN Rauschen der Länge k
x_kTa_awgn = AM*(S_kTa.*(cos(k.*Omega_c) + awgn)).*cos(k.*Omega_c + phi); % signal vor dem TP Filter
g_kTa_awgn = filter(B,A,x_kTa_awgn);    % Signal nach dem TP Filter
plot(k, g_kTa_awgn, 'DisplayName', 'g(kTa with awgn)');
lgd = legend;
lgd.NumColumns = 1;

y = filter([1],[1 a],x_kTa);
