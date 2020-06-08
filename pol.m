% Este scripte permite la visualizacion de la polarizabilidad
% de una esfera y de prolatos 

% Para ello es necesario tener valores de la función dieléctrica 
% para particulas nanometricas
% una buena aproximación es para particulas nanometricas de 
% r=10nm y r=20 nm
eh=1.4;

%% Datos de las esferas inmersas de oro

filename = 'corr2040y80nm.xlsx';
lambda = xlsread(filename,'A1:ZY1');  % Energia

eRe_10 = xlsread(filename,'A2:ZY2');  % Parte real       R=10 nm
eIm_10 = xlsread(filename,'A3:ZY3');  % Parte imaginaria
eRe10 = complex(eRe_10,eIm_10);
eRe_20 = xlsread(filename,'A4:ZY4');  % Parte real       R=20nm
eIm_20 = xlsread(filename,'A5:ZY5');  % Parte imaginaria
eRe20= complex(eRe_20,eIm_20);
eRe_80 = xlsread(filename,'A6:ZY6');  % Parte real       R=20nm
eIm_80 = xlsread(filename,'A7:ZY7');  % Parte imaginaria
eRe80= complex(eRe_80,eIm_80);
%% calculos
% CONVERSION  A ENERGIA
energia=(12.39*10^(-7))./lambda;
%%
 l=length(eRe_10);
% for i=1:l
%     alpha10=3*(eRe10(i)-eh)/(eRe10(i)+(2*eh));
%     alpha20=3*(eRe20(i)-eh)/(eRe20(i)+(2*eh));
%     
%     alpha10m(i)=alpha10*conj(alpha10);
%     alpha20m(i)=alpha20*conj(alpha20);
%     
% end
%% Calculo de L
%% relacion de aspecto 1
A=1.5;
% B =C  condicion A > B
B=1;
Ra=A/B;
% Excentricidad 
e=sqrt(1-(B/A)^2) ;
L1=((1-e^2)/(e^2))*(-1+(1/(2*e))*log((1+e)/(1-e)));
% Calulamos Pc=Pb
L2=(1-L1)/2;
L3=L2;
%%  Nanorods Campo paralelo al eje mayor tomando
%  la configuración de Bhoren
for i=1:l
    alphaNR10(i)=(eRe10(i)-eh)/(eh+(L1*(eRe10(i)-eh)));
    alphaNR20(i)=(eRe20(i)-eh)/(eh+(L1*(eRe20(i)-eh)));
    alphaNR80(i)=(eRe80(i)-eh)/(eh+(L1*(eRe80(i)-eh)));
    
    alpha10NRm(i)=alphaNR10(i)*conj(alphaNR10(i));
    alpha20NRm(i)=alphaNR20(i)*conj(alphaNR20(i));
    alpha80NRm(i)=alphaNR80(i)*conj(alphaNR80(i));
end

%% Buscar las condiciones para la maxima polarizabilidad 
% % Esfera 10nm
% imaxalpha10m=find( max(alpha10m)== alpha10m);
% maxalpha10m=alpha10m(imaxalpha10m);
% alt=int8(maxalpha10m);
% emaxalpha10m=energia(imaxalpha10m);
% lmaxalpha10m=lambda(imaxalpha10m)
% esf10 = [emaxalpha10m lmaxalpha10m maxalpha10m];
% 
% % Esfera 20nm
% imaxalpha20m=find( max(alpha20m)== alpha20m);
% maxalpha20m=alpha20m(imaxalpha20m);
% emaxalpha20m=energia(imaxalpha20m);
% lmaxalpha20m=lambda(imaxalpha20m);
% esf20 = [emaxalpha20m lmaxalpha20m maxalpha20m];

% Nanorod 10nm
imaxalpha10NRm=find( max(alpha10NRm)== alpha10NRm);
maxalpha10NRm=alpha10NRm(imaxalpha10NRm);
emaxalpha10NRm=energia(imaxalpha10NRm);
lmaxalpha10NRm=lambda(imaxalpha10NRm);
nr10 = [emaxalpha10NRm lmaxalpha10NRm maxalpha10NRm];
% Nano rod 20nm
imaxalpha20NRm=find( max(alpha20NRm)== alpha20NRm);
maxalpha20NRm=alpha20NRm(imaxalpha20NRm);
eimaxalpha20NRm=energia(imaxalpha20NRm);
limaxalpha20NRm=lambda(imaxalpha20NRm);
nr20 = [eimaxalpha20NRm limaxalpha20NRm maxalpha20NRm];

% Nano rod 80nm
imaxalpha80NRm=find( max(alpha80NRm)== alpha80NRm);
maxalpha80NRm=alpha80NRm(imaxalpha80NRm);
eimaxalpha80NRm=energia(imaxalpha80NRm);
limaxalpha80NRm=lambda(imaxalpha80NRm);
nr80 = [eimaxalpha80NRm limaxalpha80NRm maxalpha80NRm];
%% Concentrado 
val = [nr10;nr20;nr10;nr80 ];
%%               MLWA 
k=(2*pi./lambda);
%%
for i=1:l
    c=alphaNR10(i)/(4*pi);
    d= (k(i)*k(i)/(A*1e-9)) +(.66*j*k(i)*k(i)*k(i));
    den=1-(c*d);
    alml20(i)=alphaNR10(i)/(den);
    alml20m=alml20(i)*conj(alml20(i));
    
    c1=alphaNR20(i)/(4*pi);
    den1=1-(c1*d);
    alml40(i)=alphaNR20(i)/(den1);
    alml40m(i)=alml40(i)*conj(alml40(i));
    
    c2=alphaNR80(i)/(4*pi);
    den2=1-(c2*d);
    alml80(i)=alphaNR80(i)/(den2);
    alml80m(i)=alml80(i)*conj(alml80(i));
end

%%
plot(lambda,alml80m)
%%
























%%
% plot(lambda,alpha10m,'b')
% % txt = '\Re(\epsilon) \approx -2 \epsilon_{h}';
% % txt = '\Re(\epsilon) \approx - \frac{1-L_{x}}{L_{x}} \epsilon_{h}';
% % text(1,2,txt);
% hold on
% plot(lambda,alpha20m,'b+')
hold on
plot(lambda,alpha10NRm,'k')
hold on
plot(lambda,alpha20NRm,'k+')
hold on
plot(lambda,alpha80NRm,'k+')
ax = gca;
ax.XAxis.Exponent = -9;
% axis([480*10^(-9) 650*10^(-9) 0 150])
%legend({'Esfera, R=10 nm','Esfera, R = 20 nm','AuNR, R = 10 nm','AuNR,R = 20 nm'},'Location','southwest','FontSize',12)
legend({'AuNr, R=20 nm','AuNr, R = 40 nm','AuNR, R = 80 nm'},'Location','southwest','FontSize',12)
xlabel('\lambda','FontSize',18,'FontWeight','bold')
ylabel('|\alpha| / v','FontSize',18,'FontWeight','bold')

% plot(energia, alpha10NRmp,'g')



