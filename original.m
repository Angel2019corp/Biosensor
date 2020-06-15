
R =10e-9;       % Radio de esfera
%%
c=2.99792458e8; %Velocidad de la luz en el vacío
%    Parametros del Oro Bulk
vf=1.4e6;       %Velocidad de Fermi (m/s)
Ts_gold=3e-14;  %Tiempo de colisión estática
w0=1/Ts_gold;   %Frecuencia de colisión
gamma0=w0;
wp=1.39e16;     %Frecuencia de plasma


% Función dieléctrica del oro (bulk), de Johnson y Christy (1972)
filename = 'datosf.xlsx';
energia = xlsread(filename,'A1:A44');  % Energia
eRe_jc = xlsread(filename,'B1:B44');  % Parte real
eIm_jc = xlsread(filename,'C1:C44');  % Parte imaginaria
 
%% OPeraciones
% Se realiza la conversion a longitud de onda
lambda_jc = (12.39*10^(-7))./energia;% lambda= 2*pi*c/energia
%%
lambda=300e-9:1*10^(-9):1000e-9;  % Para crear interpolacion con mas valores
 
% se crea una interpolacion entre los valores teoricos 
eRe=interp1(lambda_jc,eRe_jc,lambda);
eIm=interp1(lambda_jc,eIm_jc,lambda);


% Calculo de modelos
A=1;
%% Dependiente del radio
w0r=w0+vf/R;    %Frecuencia de colisión dependiente del tamaño [w0r=w0(R)]

for x=1:length(lambda)
w(x)=2*pi*c/(lambda(x)); % convierte a frecuencia angular
% Kreibig y Vonfragstein (1969)

% DRUDE SIN DEPENDENICA DEL RADIO
A1=1-(((wp)^2)/(((w(x))^2)+((w0)^2))); 
A2=(((wp)^2)*(w0))/((w(x))*(((w(x))^2)+((w0)^2)));
A1plot(x)=A1; %Parte real
A2plot(x)=A2; %Parte imaginaria
% % APORTACION DE ELECTRONES LIGADOS
B1=eRe(x)-A1;
B2=eIm(x)-A2;
% 
% 
% % DRUDE CON DEPENDENCIA DEL RADIO
A1r=1-(((wp)^2)/(((w(x))^2)+((w0r)^2)));
A2r=(((wp)^2)*(w0r))/((w(x))*(((w(x))^2)+((w0r)^2)));
% 
eRe_nano=A1r+B1;
eRe_nanoplot(x)=eRe_nano; % Matriz de valores, parte real de eps
eIm_nano=A2r+B2;
eIm_nanoplot(x)=eIm_nano; % Matriz de valores, parte imaginaria de eps
% 
% % Hovel et al. (1993)
% eps_wR(x)=eRe(x)+i*eIm(x)+(((wp)^2)/(((w(x))^2)+(w(x))*(gamma0)*i))-...
%      (((wp)^2)/(((w(x))^2)+((w(x))*(gamma0+(A*vf/R))*i)));
end
% %% Diferente radio
% % Calculo de modelos
A=1;
R =20e-9; 
% Dependiente del radio
w0r=w0+vf/R;    %Frecuencia de colisión dependiente del tamaño [w0r=w0(R)]

for x=1:length(lambda)
w(x)=2*pi*c/(lambda(x)); % convierte a frecuencia angular
% Kreibig y Vonfragstein (1969)

% DRUDE SIN DEPENDENICA DEL RADIO
A1=1-(((wp)^2)/(((w(x))^2)+((w0)^2))); 
A2=(((wp)^2)*(w0))/((w(x))*(((w(x))^2)+((w0)^2)));
A1plot(x)=A1; %Parte real
A2plot(x)=A2; %Parte imaginaria
% % APORTACION DE ELECTRONES LIGADOS
B1=eRe(x)-A1;
B2=eIm(x)-A2;
% 
% 
% % DRUDE CON DEPENDENCIA DEL RADIO
A1r=1-(((wp)^2)/(((w(x))^2)+((w0r)^2)));
A2r=(((wp)^2)*(w0r))/((w(x))*(((w(x))^2)+((w0r)^2)));
% 
eRe_nano=A1r+B1;
eRe_nanoplot1(x)=eRe_nano; % Matriz de valores, parte real de eps
eIm_nano=A2r+B2;
eIm_nanoplot1(x)=eIm_nano; % Matriz de valores, parte imaginaria de eps

end
% 
% %% Diferente radio
% % Calculo de modelos
A=1;
R =100e-9; 
% Dependiente del radio
w0r=w0+vf/R;    %Frecuencia de colisión dependiente del tamaño [w0r=w0(R)]

for x=1:length(lambda)
w(x)=2*pi*c/(lambda(x)); % convierte a frecuencia angular
% Kreibig y Vonfragstein (1969)

% DRUDE SIN DEPENDENICA DEL RADIO
A1=1-(((wp)^2)/(((w(x))^2)+((w0)^2))); 
A2=(((wp)^2)*(w0))/((w(x))*(((w(x))^2)+((w0)^2)));
A1plot(x)=A1; %Parte real
A2plot(x)=A2; %Parte imaginaria
% % APORTACION DE ELECTRONES LIGADOS
B1=eRe(x)-A1;
B2=eIm(x)-A2;
% 
% 
% % DRUDE CON DEPENDENCIA DEL RADIO
A1r=1-(((wp)^2)/(((w(x))^2)+((w0r)^2)));
A2r=(((wp)^2)*(w0r))/((w(x))*(((w(x))^2)+((w0r)^2)));
% 
eRe_nano=A1r+B1;
eRe_nanoplot2(x)=eRe_nano; % Matriz de valores, parte real de eps
eIm_nano=A2r+B2;
eIm_nanoplot2(x)=eIm_nano; % Matriz de valores, parte imaginaria de eps

end

%% Comparacion de resultados

% Real


% plot(lambda,A1plot,'g')
 %hold on
% plot (lambda,eRe_nano,'k')

% imaginario
% plot(lambda_jc,eIm_jc,'r-')
% hold on
% plot(lambda,A2plot,'b-')
% 
% plot(lambda,eIm_nanoplot,'g.')
% hold on
% plot(lambda,imag(eps_wR),'k-')


%% Graficado 
% 
% subplot(1,2,1)
% % plot(lambda_jc,eRe_jc,'ro') % bulto experimental
% % hold on
% plot(lambda,eRe,'b-') % interpolacion
% hold on
% plot(lambda,A1plot,'m-') % Drude 
% hold on
% plot(lambda,eRe_nanoplot,'k-') % Dependencia deltamaño
% x1=[500*10^(-9) 500*10^(-9)];
% y=[-45, 0];
% plot(x1,y,'r-.')
% 
% ax = gca;
% ax.XAxis.Exponent = -9;
% legend({'Au','Drude','AuNpsk'},'Location','southwest')
% dim = [.35 .5 .3 .3];
% str =  {'Zona de transiciones','de interbanda'};
% annotation('textbox',dim,'String',str,'FitBoxToText','on');
% grid on
% xlabel('\lambda','FontSize',15,'FontWeight','bold')
% ylabel('\Re(\epsilon)','FontSize',15,'FontWeight','bold')
% %Ejes parte real
% axis([300*10^(-9) 1000*10^(-9) -45 0])
% 
% subplot(1,2,2)% Imaginaria
% % plot(lambda_jc,eIm_jc,'ro') % bulto experimental
% % hold on
% plot(lambda,eIm,'b-') % interpolacion
% hold on
% plot(lambda,A2plot,'m-') % Drude
% hold on
% plot(lambda,eIm_nanoplot,'k-') % Dependencia del tamaño
% 
% x1=[500*10^(-9) 500*10^(-9)];
% y=[0, 9];
% plot(x1,y,'r-.')
% ax = gca;
% ax.XAxis.Exponent = -9;
% ax.GridColor = [0 .5 .5];
% 
% legend({'Au','Drude','AuNpsk'},'Location','southwest')
% xlabel('\lambda','FontSize',15,'FontWeight','bold')
% ylabel('\Im(\epsilon)','FontSize',15,'FontWeight','bold')
% dim = [.75 .5 .3 .3];
% str =  {'Zona de transiciones','de interbanda'};
% annotation('textbox',dim,'String',str,'FitBoxToText','on');
% grid on
% axis([300*10^(-9) 1000*10^(-9) 0 9])
% 

% Creamos una matriz con la informacion creada 
% en la cual se alojara la informacion de 
% la función dielectrica para particulas nanometricas
 %p= [lambda;eRe_nanoplot;eIm_nanoplot]
 %csvwrite('epsilonnano.csv',p)
 
%  % guardamos los valores
%%
% out =[lambda;eRe_nanoplot;eIm_nanoplot;eRe_nanoplot1;eIm_nanoplot1;eRe_nanoplot2;eIm_nanoplot2];
% %%
% xlswrite('corr2040Y80nm.xlsx',out)


%%  Real 
subplot(1,2,1)
plot(lambda_jc,eRe_jc,'bo-') % bulto experimental
hold on
% plot(lambda,eRe,'m-') % Dependencia del radio
hold on
plot(lambda,eRe_nanoplot,'r-') % Dependencia del radio
hold on
plot(lambda,eRe_nanoplot1,'b-') % Dependencia del radio
hold on
plot(lambda,eRe_nanoplot2,'k-') % Dependencia del radio
% hold on
% plot(lambda,eRe_nanoplot2,'k-') % Dependencia del radio
ax = gca;
ax.XAxis.Exponent = -9;
grid on
axis([300*10^(-9) 1000*10^(-9) -45 0])
legend({'Au bulto Exp','AuNps (R = 10 nm)','AuNps (R = 20 nm)','AuNps (R = 50 nm)'},'Location','southwest','FontSize',12)
xlabel('\lambda','FontSize',15,'FontWeight','bold')
ylabel('\Re(\epsilon)','FontSize',15,'FontWeight','bold')

subplot(1,2,2)% Imaginaria
plot(lambda_jc,eIm_jc,'o-') % bulto experimental
hold on
% plot(lambda,eIm,'m-') % Dependencia del radio
hold on
plot(lambda,eIm_nanoplot,'r-') % Dependencia del radio
hold on
plot(lambda,eIm_nanoplot1,'b-') % Dependencia del radio
hold on
plot(lambda,eIm_nanoplot2,'k-') % Dependencia del radio
hold on

% hold on
% plot(lambda,eIm_nanoplot2,'k-') % Dependencia del radio
ax = gca;
ax.XAxis.Exponent = -9;
grid on
legend({'Au bulto Exp','AuNps (R = 10 nm)','AuNps (R = 20 nm)','AuNps (R = 50 nm)'},'Location','southwest','FontSize',12)
axis([300*10^(-9) 1000*10^(-9) 0 6.5])
xlabel('\lambda','FontSize',15,'FontWeight','bold')
ylabel('\Im(\epsilon)','FontSize',15,'FontWeight','bold')