% Diode demodulator: Abb. 14 in AM-Versuchsbeschreibung
% Letzte Modifikation: 10.10.2018 / T.Kreul
% Parameter settings
%% 1. Quellsignal ist ein Sinus
%
%
clear all
k = -10:0.01:10;    %Vektor k
w_s = 2*pi*10;  %Hz cut-off frequency
w_c = 2*pi*100;    % träger-Frequenz
T_a1 = (2*pi/w_s)/2;    %Abtastperiode
A = 1;  %Amplitude des Trägers
phi = 180;    %Phase des trägers
m=1;
tau=4;
%noise = rand(size(k));
s_kTa = cos(w_s.*k*T_a1);    %Quellensignal s(t)=cos(w_s*t)
m_kTa = A*cos(w_c.*k*T_a1 + phi);  %Trägersignal der das Quellensignal zu hohen Frequenzen trägt m(t) = A*cos(w_c*t + phi)
X_kTa = s_kTa.*m_kTa;    %moduliertes Signal x_(t) durch ein einfacher idealer modulator
deltat=k(2)-k(1);

s=A*(1+m*s_kTa);
x_AM=s.*m_kTa;
hx_AM=plot(k,x_AM);
xlabel('t [s]')
ylabel('Amplitude [Volt]')
set(hx_AM,'LineWidth',[1]);
hold on
hs=plot(k,abs(s),'--');
set(hs,'LineWidth',[3]);
hms=plot(k,-abs(s),':');
set(hms,'LineWidth',[3]);
grid on

n=1;
g_DRC(n)=x_AM(n);
for thilf=k(1:length(k)-1)
  n=n+1;
  if (x_AM(n)>x_AM(n-1))|(x_AM(n)>x_AM(n-1)*exp(-deltat/tau))
    if g_DRC(n-1)>x_AM(n-1)
       g_DRC(n)=exp(-deltat/tau)*g_DRC(n-1); %discharging period
    else
       g_DRC(n)=x_AM(n); %charging period
    end
  else 
     g_DRC(n)=exp(-deltat/tau)*g_DRC(n-1); %discharging period
  end
end
hg_DRC=plot(k,g_DRC,'-');
set(hg_DRC,'LineWidth',[2]);
hold off
grid on
set(gca,'XLim',[0 k(end)]);
%set(gca,'YLim',[-A*(1+m)-0.2 A*(1+m)+0.2]);
%set(gca,'XColor',[1 1 1])
%set(gca,'YColor',[1 1 1])
set(gca,'FontName','Times-Roman');
xlabel('t [s]')
ylabel('Amplitude [Volt]')
%set(gcf,'PaperPosition',[0.25 2.5 6.5 2.2]); %The 3 means a half-plot, 6 is usual
%set(gca,'XTickLabel',[]);
%set(gca,'YTickLabel',[]);
%set(gca,'XTick',[]);
%set(gca,'YTick',[]);
set(gcf,'Color',[1 1 1]);
%print -deps DRCdemod.eps

%% 2. Bandlimites Signal
%
%
%%  Generierung eines AM-Signals mit einem Bandlimitierten Quellsignal
clear all;
close all;
k = -10:0.01:10;    %Vektor k
w_sf = 2*pi*1;   %cut-off frequency in Hz
w_0 = 2*pi*2;    % signal frequencs in Hz
w_c1 = 2*pi*5;  % trägerfrequenz in Hz
A = 1;  % Amplitude in Volt
a = 0.75;   % constant
T_a1 = (2*pi/w_sf)/2;    %Abtastperiode in s
m_AM1 = 1;     %Modulationsordnung
phi_1 = 0;      %Phase des Trägers
tau_1 = 5;    % zeitkonstante $\tau = RC$
deltat=k(2)-k(1);

%noise = rand(size(k));
m_kTa1 = A*cos(w_c1.*k*T_a1 + phi_1);  %Trägersignal der das Quellensignal zu hohen Frequenzen trägt m(t) = A*cos(w_c*t + phi)
% Generierung des Bandbegrenztes Signal Sr(t) im Zeitbereich
Sr_kTa = (((w_sf+w_0/2)/pi)*sinc((w_sf+w_0/2).*k*T_a1)) - ...
    ((a*(w_sf-w_0/2)/pi)*sinc((w_sf-w_0/2).*k*T_a1)) - ...
    (w_sf*(1-a)/pi)*sinc(w_sf.*k*T_a1).*sinc((w_0.*k*T_a1)/2);
x_AM=A*(1 + m_AM1*Sr_kTa).*m_kTa1;
hx_AM=plot(k,x_AM);
xlabel('t [s]')
ylabel('Amplitude [Volt]')
set(hx_AM,'LineWidth',[1]);
hold on
hs=plot(k,abs(Sr_kTa),'--');
set(hs,'LineWidth',[3]);
hms=plot(k,-abs(Sr_kTa),':');
set(hms,'LineWidth',[3]);
grid on

n=1;
g_DRC(n)=x_AM(n);
for thilf=k(1:length(k)-1)
  n=n+1;
  if (x_AM(n)>x_AM(n-1))|(x_AM(n)>x_AM(n-1)*exp(-deltat/tau_1))
    if g_DRC(n-1)>x_AM(n-1)
       g_DRC(n)=exp(-deltat/tau_1)*g_DRC(n-1); %discharging period
    else
       g_DRC(n)=x_AM(n); %charging period
    end
  else 
     g_DRC(n)=exp(-deltat/tau_1)*g_DRC(n-1); %discharging period
  end
end
hg_DRC=plot(k,g_DRC,'-');
set(hg_DRC,'LineWidth',[2]);
hold off
grid on
%set(gca,'XLim',[0 k(end)]);
%set(gca,'YLim',[-A*(1+m)-0.2 A*(1+m)+0.2]);
%set(gca,'XColor',[1 1 1])
%set(gca,'YColor',[1 1 1])
set(gca,'FontName','Times-Roman');
xlabel('t [s]')
ylabel('Amplitude [Volt]')
%set(gcf,'PaperPosition',[0.25 2.5 6.5 2.2]); %The 3 means a half-plot, 6 is usual
%set(gca,'XTickLabel',[]);
%set(gca,'YTickLabel',[]);
%set(gca,'XTick',[]);
%set(gca,'YTick',[]);
set(gcf,'Color',[1 1 1]);
%print -deps DRCdemod.eps
