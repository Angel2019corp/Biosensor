clear all
format long
lambda=632.8e-9; %Longitud de onda (nm)
% DECLARACI�N DE PAR�METROS DE LAS MONOCAPAS
% Los �ndices de refracci�n (el n�mero complejo n + k) y los grosores de
% las distintas capas (en nan�metros) son registrados en primer lugar.
% Para las capas de los extremos, s�lo n y k.
% En este caso, se utilizan cinco materiales distintos.
% 1: Prisma de vidrio SF14
n_prisma=1.723;
k_prisma=0;
% 2: Oro
n_oro=0.1726; %Valor en 633 nm
k_oro=3.4218; %Valor en 633 nm
d_oro=47; %Valor arbitrario para una pel�cula delgada comercial (47 nm)
% 3: Monocapa prote�na 1 (Alb�mina de Suero de Bovino)
n_pr1=1.445; %�ndice de refracci�n de la prote�na
k_pr1=0;
d_pr1=14; %Tama�o de la prote�na (14 nm)
% 4: Monocapa prote�na 2 (valores arbitrarios)
n_pr2=1.41;
k_pr2=0;
d_pr2=12; %(12 nm)
% 5: Agua (medio)
n_med=1.333;
k_med=0;
% Creaci�n de matrices para n, k y d y c�lculo de la constante
% diel�ctrica de cada capa
en(1)=n_prisma;
ek(1)=0;
en(2)=n_oro;
ek(2)=k_oro;
d(2)=1e-9*(d_oro); % Grosor en nm
en(3)=n_pr1;
ek(3)=k_pr1;
d(3)=1e-9*(d_pr1); % Grosor en nm
en(4)=n_pr2;
ek(4)=k_pr2;
d(4)=1e-9*(d_pr2); % Grosor en nm

en(5)=n_med;
ek(5)=k_med;
for x=1:length(en);
er=en(x)^2-ek(x)^2;
ei=2*en(x)*ek(x);
e(x)=complex(er,ei);
end
% *************************************************************************
% C�LCULOS
theta_deg=50:.01:80; % Rango: 50� a 80�. Intervalos: 0.01�
theta_ext=theta_deg/180*pi;
theta0=(pi/4)+asin(1/en(1)*sin(theta_ext-(pi/4)));
for jtheta=1:length(theta0);
theta=theta0(jtheta);
q1=sqrt(e(1)-en(1)^2*sin(theta)^2)/e(1);
qn=sqrt(e(end)-en(1)^2*sin(theta)^2)/e(end);
for j=2:(length(e)-1)
beta=d(j)*2*pi/lambda*sqrt(e(j)-en(1)^2*sin(theta)^2);
q=sqrt(e(j)-en(1)^2*sin(theta)^2)/e(j);
em(j,1,1)=cos(beta);
em(j,1,2)=-i*sin(beta)/q;
em(j,2,1)=-i*sin(beta)*q;
em(j,2,2)=cos(beta);
end
emtot=[1 0; 0 1];
for j=2:(length(e)-1)
emtot1(:,:)=em(j,:,:);
emtot=emtot*emtot1;
end
rp=((emtot(1,1)+emtot(1,2)*qn)*q1-(emtot(2,1)+emtot(2,2)*qn))/...
((emtot(1,1)+emtot(1,2)*qn)*q1+(emtot(2,1)+emtot(2,2)*qn));
ref=rp*conj(rp);
refle(jtheta)=ref;
end
refmin=find(refle==min(refle));
thetacr=theta_deg(refmin); % Posici�n del �ngulo cr�tico (m�n. reflectancia)
% *************************************************************************
% DIBUJO DE LA GR�FICA
figure(1)
clf
plot(theta_deg,refle,'k')
legend(['\thetamin = ', num2str(thetacr), '�'])
title('SIMULACI�N DE MONTAJE SPR')
ylabel('Reflectancia (u.a.)')
xlabel('�ngulo (�)')
