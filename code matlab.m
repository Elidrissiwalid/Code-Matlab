clear all
close all
clc
clf
Isc=3.45 ;%courant court-circuit
Voc=43.5 ;%tension circuit ouvert
Impp=3.15 ;%(courant optimale) le courant au point de puissance maximale
Vmpp=35 ;%(tension optimale) la tension au point de puissance maximale
K1=0.01175 ;
K4=log((1+K1)/(K1));
K3=log((Isc*(1+K1)-Impp)/(K1*Isc));
m=(log(K3/K4))/(log(Vmpp/Voc));
K2=(K4/(Voc^m)) ;
Vpv=0:0.1:50;
Ipv=Isc*(1-K1*(exp(K2*(Vpv.^m)-1)));
%pour ne pas avoir un courant négative
for i=1:size(Ipv,2)
if Ipv(i)<0
Ipv(i)=0;
end
end
 figure(1)
Ppv=Vpv.*Ipv;
subplot(2,1,1);
x = linspace(0,10);
plot(Vpv,Ipv)
title('la courbe I-V')
xlabel('la tension V')
ylabel('Le courant I')

subplot(2,1,2); 
plot(Vpv,Ppv)
title('la courbe P-V')
xlabel('la tension V')
ylabel('La puissance P')


%-----------------------------------------------------------------------
%Tc; T a condition quelconque
%G; l'intensité a condition quelconque
%dIpv variation de courant en fonction des conditions climatiques
%dVpv variation de tension en fonction des conditions climatiques
Tstc=25; %T a condition standard
Gstc=1000;% insolation a condition standard
a=1.4e-3 ;%alpha(sc) coefficient de température d'incrémentation du courant Isc quand la température de surface augment de un degré {A/C}
b=-152e-3;%beta(oc) coefficient de température d'incrémentation du courant Voc quand la température de surface augment de un degré {V/C}
Rs=0.614 ; %résistance série
%l'effet de Température sur PV
for Tc=0:15:75
G=1000;
dTc=Tc-Tstc;
dIpv=a*(G/Gstc)*dTc+(G/Gstc-1)*Isc;
dVpv=-b*dTc-Rs*dIpv;
Vnouv=Vpv+dVpv;
Inouv=Ipv+dIpv;
Pnouv=Vnouv.*Inouv;
for i=1:size(Inouv,2)
if Inouv(i)<0
Inouv(i)=0;
end
end
for i=1:size(Vnouv,2)
if Vnouv(i)<0
Vnouv(i)=0;
end
end
for i=1:size(Pnouv,2)
if Pnouv(i)<0
Pnouv(i)=0;
end
end
 figure(2)
subplot(2,1,1);
hold on
x = linspace(0,10);
plot(Vnouv,Inouv)
legend('0C°','15C°','30C°','45C°','50C°','75C°');
title('influence de la temperature I-V')
xlabel('la tension V')
ylabel('Le courant I')
subplot(2,1,2); 
hold on
plot(Vnouv,Pnouv)
legend('0C°','15C°','30C°','45C°','50C°','75C°');
title('influence de la temperature P-V')
xlabel('la tension V')
ylabel('La puissance P')
end
%l'effet de l'irradiation sur PV
for G=200:200:1000
T=25;
dTc=Tc-Tstc;
dIpv=a*(G/Gstc)*dTc+(G/Gstc-1)*Isc;
dVpv=-b*dTc-Rs*dIpv;
Vnouv=Vpv+dVpv;
Inouv=Ipv+dIpv;
for i=1:size(Inouv,2)
if Inouv(i)<0
Inouv(i)=0;
end
end
for i=1:size(Vnouv,2)
if Vnouv(i)<0
Vnouv(i)=0;
end
end
for i=1:size(Pnouv,2)
if Pnouv(i)<0
Pnouv(i)=0;
end
end

 figure(3)
 
subplot(2,1,1);
hold on
plot(Vnouv,Inouv)
legend('200w/m2','400w/m2','600w/m2','800w/m2','1000w/m2');
title('influence de l'irradiation I-V')
xlabel('la tension V')
ylabel('Le courant I')

subplot(2,1,2); 
Pnouv=Vnouv.*Inouv;
hold on
plot(Vnouv,Pnouv)
legend('200w/m2','400w/m2','600w/m2','800w/m2','1000w/m2');
title('influence de l'irradiation P-V')
xlabel('la tension V')
ylabel('La puissance P')


end