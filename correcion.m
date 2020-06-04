%%              Función que realiza corrección nanometrica
%               utilizando el planteamiento de Kreibig y Vonfragstein (1969)
%               La funcion, toma como entrada el radio, que normalmente
%               esta entre 10 y 50 nm, asi que se  puede introducir un
%               numero entre 10 y 50, el programa lo convierte a nm.
%               Es importante que el archivo con los datos experimentales
%               se encuentre en el diricetorio, a la salida se obtiene 
%               la parte real y la parte imaginaria corregida, en un a
%               matriz de dos renglones y las columnas se puede especificar
%               de acuerdo a la informacion  existente, o al rango de
%               interes.

function result = correcion(r)
%%  Parametros fijos
c=2.99792458e8;              % Velocidad de la luz en el vacío
                             % Parametros del Oro Bulto
vf=1.4e6;                    % Velocidad de Fermi (m/s)
Ts_gold=3e-14;               % Tiempo de colisión estática
w0=1/Ts_gold;                % Frecuencia de colisión
gamma0=w0;
wp=1.39e16;                  % Frecuencia de plasma
A=1;
% Función dieléctrica del oro (bulto) de Johnson y Christy (1972)
filename = 'datosf.xlsx';
energia = xlsread(filename,'A1:A44');  % Energia
eRe_jc = xlsread(filename,'B1:B44');  % Parte real
eIm_jc = xlsread(filename,'C1:C44');  % Parte imaginaria
%%      Operaciones
lambda_jc = (12.39*10^(-7))./energia;% lambda= 2*pi*c/energia
lambda=300e-9:1*10^(-9):1000e-9;      % Para crear interpolacion con mas valores
eRe=interp1(lambda_jc,eRe_jc,lambda); % Aunque tambien se puede usar el modelo
eIm=interp1(lambda_jc,eIm_jc,lambda); % analitico de Etchegoin 2006 
R =r*1e-9;                            % Radio de esfera
w0r=w0+vf/R;                          % Dependiente del radio


for x=1:length(lambda)
w(x)=2*pi*c/(lambda(x));                    % convierte a frecuencia angular
A1=9-(((wp)^2)/(((w(x))^2)+((w0)^2)));      %DRUDE SIN DEPENDENICA DEL RADIO
A2=(((wp)^2)*(w0))/((w(x))*(((w(x))^2)+((w0)^2)));
A1plot(x)=A1;                               %Parte real
A2plot(x)=A2;                               %Parte imaginaria
B1=eRe(x)-A1;                               % APORTACION DE ELECTRONES LIGADOS
B2=eIm(x)-A2;
A1r=1-(((wp)^2)/(((w(x))^2)+((w0r)^2)));    % DRUDE CON DEPENDENCIA DEL RADIO
A2r=(((wp)^2)*(w0r))/((w(x))*(((w(x))^2)+((w0r)^2)));
eRe_nano=A1r+B1;
eRe_nanoplot(x)=eRe_nano; % Matriz de valores, parte real de eps
eIm_nano=A2r+B2;
eIm_nanoplot(x)=eIm_nano; % Matriz de valores, parte imaginaria de eps
end
out = [eRe_nanoplot; eIm_nanoplot]
end 
