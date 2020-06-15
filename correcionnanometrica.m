% Correción de constante dielectrica para particulas nanometricas 
%% Datos experimentales
 filename = 'datosf.xlsx';
 e = xlsread(filename,'A1:A44');  % Energia
 x = xlsread(filename,'B1:B44');  % Parte real
 y = xlsread(filename,'C1:C44');  % Parte imaginaria

% Conversion de energia a longitud de onda 
lamda = (12.39*10^(-7))./e;
w1c=4*pi*.1923*10^(33)

woc=.011449*10^30
n=6*pi*10^8
w=n./lamda
% Modelo de drude
a1=(w1c./(w.^2+woc))
a=a1./15
a3=9-a
%a2=(w1c*sqrt(woc))./(w.*(w.^2+woc))
%hold on

plot(lamda,a3)
hold on
plot(lamda,x)