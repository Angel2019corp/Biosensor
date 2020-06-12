%%      Programa que calcula la reflxion en un sistema de 5 capas de las cuales
%       4 capas se constituyen por medios isotropicos
%       1 capa se constituye por un medio anisotropico

%       Se realiza el cálculo con la formula de Airy
%       r_{12345} con polarización p donde 4 representa
%       al medio anisotropico biaxial, por lo tanto la reflexión se calcula
%       acorde a la reflexión de una película delgada biaxial, cuya
%       formualción se encuentra en Fujiwara, 2007.

%%      Delcaración de datos
clear all
%%
clc
format long
%%

% ----- Lambda  ------
lambda = 633e-9;
c      = 2*pi/lambda;
% ------ Indices de refracción y espesores medios isotropicos----
% medio 1
n(1) = 1.77;
k(1) = 0;
d(1) = 0;
% medio 2
n(2) = 0.17683;
k(2) = 3.37146i;
d(2) = 40e-9;
% medio 3
n(3) = 1.46;
k(3) = 0;
d(3) = 30e-9;
% medio 5
n(4) = 1.33;
k(4) = 0;
d(5) = 0;
%%

%   ---   Conversión a ctes. diel Isotropicos
e = (n+k).^2;       
% ----- ángulos ------
start     = 28; stop =40; step = 0.01;     % ángulos inicial y final en grad., paso 
theta_i   = start:step:stop;                % intervalo de valores 
theta_rad = theta_i/180*pi;                 % conversión
theta_p  = (pi/4) +asin(1/n(1)*sin(theta_rad-(pi/4))); % Ley de snell aire/prisma


%   ----- indice de refracción película biaxial  (solo en eje x y z) variando
%            acorde a sin ----
theta_f = 0;
exprima=1.0005+.0005*i;
ezprima=4+2*i;
ex   = exprima*(cos(theta_f/10).^2)+ezprima*(sin(theta_f/10).^2);
nx   =sqrt(ex);%.*ex;

ez   = ezprima*(sin(theta_f/10).^2)+exprima*(cos(theta_f/10).^2);
nz   = sqrt(ez);%.*ez; 
d(4) = 40e-9;
%%
%   ---     calculos intermedios
p   = sin(theta_p).^2*n(1)^2;
b12 = sqrt(e(2)-p);
b23 = sqrt(e(3)-p);
b34 = sqrt((ex.*ez-ex.*p)./ez);
b45 = sqrt(e(4)-p);
bt12 = b12*c*d(2);
bt23 = b23*c*d(3);
bt34 = c*d(4)*b34;
%%
%   cocientes
z12n  = (cos(theta_p)/n(1))-(b12/e(2));
z12p  = (cos(theta_p)/n(1))+(b12/e(2));
r12   = z12n./z12p;

z23n  =  b12/e(2)-b23/e(3);
z23p  =  b12/e(2)+b23/e(3);
r23   =  z23n./z23p;

z34n  =  (nx.*nz.*b23/e(3))-(n(3)*sqrt(nz.^2-p));
z34p  =  (nx.*nz.*b23/e(3))+(n(3)*sqrt(nz.^2-p));
r34   = z34n./z34p;

z45n  =(n(4)*sqrt(nz.^2-p))-(nx.*nz.*b45/e(4));
z45p  =(n(4)*sqrt(nz.^2-p))+(nx.*nz.*b45/e(4));
r45   = z45n./z45p;


%%
%  exponenciales
ex12  = exp(-2*i*bt12);
ex23  = exp(-2*i*bt23);
ex34  = exp(-2*i*bt34);

% final
n345  = r34+(r45.*ex12);
d345  = 1 + (r34.*r45.*ex12);
r345  = n345./d345;
%%

n2345 = r23 + r345.*ex23;
d2345 = 1 + (r23.*r345.*ex23);
r2345 = n2345./d2345;

n12345 = r12 + (r2345.*ex12);
d12345 = 1 + (r12.*r2345.*ex12);
r12345 = n12345./d12345;
ref=r12345.*conj(r12345);
refnorm=ref/max(ref);
%%

hold on
axis([28 40 0 1])
plot(theta_i,refnorm,'r')



