
R =10e-9;       % Radio de esfera
%%
c=2.99792458e8; %Velocidad de la luz en el vacío
%    Parametros del Oro Bulk
vf=1.4e6;       %Velocidad de Fermi (m/s)
Ts_gold=3e-14;  %Tiempo de colisión estática
gamma0=1/Ts_gold;   %Frecuencia de colisión

wp=1.39e16;     %Frecuencia de plasma


% Función dieléctrica del oro , de Johnson y Christy (1972)
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
