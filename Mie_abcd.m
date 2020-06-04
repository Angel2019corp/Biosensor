%% Programa que permite el cálculo de los coeficientes  de Mie
%  para esferas no magnéticas, mediante los valores de entrada:
%  el parámetro de tamaño  x = k*a,k = 2 pi /lambda el número de onda
%  en el espacio vacío y a es el radio de la esfera
%  el segundo valor de entrada es m, el índice de refracción relativo 
%  dado por m = n_{esfera}/n_{medio}, a la salida se obtienen los 
%  coeficientes a_{n}, b_{n}, c_{n}, d_{n}, donde n, es el obtenido
%  mediante el criterio propuesto por Bohren para la convergencia de las
%  series.
%
%  El algoritmo se describe en la tesis, basado en el desarrollo
%  de Bohren (Bohren,1998), mientras que el codigo se basa en el trabajo de
%  Mätzler (Mätzler,2002), cuya información bibliográfica se encuentra en
%  la tesis. 


%%  Cálculos
%   Creamos una función
function result = Mie_abcd(m, x)
n_max=round(2+x+4*x^(1/3)); n=(1:n_max);
nu = (n+0.5);               % nu es el grado de las funciones 
z=m.*x; m2=m.*m;            % se necesitara más adelante
% factor que multiplica a las funciones de Bessel de primer y segundo tipo
% para asi obtener las funciones de Bessel
fx= sqrt(0.5*pi./x);         % sqrt (pi/2x)
fz= sqrt(0.5*pi./z);         % sqrt (pi/2z)
% besselj(a,b) calcula la función de bessel de primer tipo 
% a, es el grado, mientras que b el argumento
% Funcion de bessel a un numero real
bx = besselj(nu, x).*fx;     % j_{n+.5} (x) , crea un vector
% Funcion de beseel de un numero complejo
bz = besselj(nu, z).*fz;     % j_{n+.5} (mx)    
yx = bessely(nu, x).*fx;     % y_{n+.5} (x)
hx = bx+i*yx;                % funcion Hankel de primer tipo
b1x= [sin(x)/x, bx(1:n_max-1)]; % j_{0} y j_{n} n=1-6
b1z=[sin(z)/z, bz(1:n_max-1)];
y1x=[-cos(x)/x, yx(1:n_max-1)];
h1x= b1x+i*y1x;
ax = x.*b1x-n.*bx;          % representa la derivada  de   
                            % [z j_{n}(z)]'= z j_{n-1} (z) - nj_{n}(z)
                            % j _{n} (z) raiz(pi/2z) J_{n+.5}(z)
az = z.*b1z-n.*bz;
                            % [z h_{n}(1)(z)]'=zh_{n-1}(1)(z)-nh_{n}(1)(z)
ahx= x.*h1x-n.*hx;
an = (m2.*bz.*ax-bx.*az)./(m2.*bz.*ahx-hx.*az);
bn = (bz.*ax-bx.*az)./(bz.*ahx-hx.*az);
cn = (bx.*ahx-hx.*ax)./(bz.*ahx-hx.*az);
dn = m.*(bx.*ahx-hx.*ax)./(m2.*bz.*ahx-hx.*az);
result=[an; bn; cn; dn];
end 