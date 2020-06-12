% Respuesta de AuNRs considerando la teoria del medio efecctivo simple
clc
format long

%%  Parametros 
% ----- Lambda  ------
lambda = 633e-9;
c      = 2*pi/lambda;
% ------ Indices de refracción y espesores medios isotropicos----
% medio 0
n(1) = 1.77;
k(1) = 0;
d(1) = 0;
% medio 1
n(2) = 0.17683;
k(2) = 3.37146i;
d(2) = 30e-9;
% medio 2
n(3) = 1.46;
k(3) = 0;
d(3) = 30e-9;



% medio 4
n(5) = 1.33;
k(5) = 0;
d(5) = 0;
%   ---   Conversión a ctes. diel Isotropicos
e =(n+k).^2;    
start     = 30; stop =60; step = 0.01;     % ángulos inicial y final en grad., paso 
theta_i   = start:step:stop;                % intervalo de valores 
theta_rad = theta_i/180*pi;                 % conversión
theta_p  = (pi/4) +asin(1/n(1)*sin(theta_rad-(pi/4))); % Ley de snell aire/prisma

%   función dielectrica efectiva del medio 3
r = 2.5;             % relación de aspecto
exc = sqrt(1-r^2);    % Excentricidad
h=(1/(2*exc))*log((1+exc)/(1-exc));
lz= ((1-exc^2)/exc^2)*(h-1);% factor geometrico lz
lx=(1/2)*(1-lz);
ly=lz;
f = 0.4;         % Fracción de llenado
% conversion a epsilon
ex=((1-f)*(e(5)-e(2)))./(e(2)+lx*(e(5)-e(2)));
ey=((1-f)*(e(5)-e(2)))./(e(2)+ly*(e(5)-e(2)));
ez=((1-f)*(e(5)-e(2)))./(e(2)+lz*(e(5)-e(2)));
%   Variables iniciales
kx=sqrt(e(1))*c*sin(theta_p);
beta =0; 
% conversión de coordenadas
exx=ex*cos(beta)^2 + ez*sin(beta)^2;
exz=(-ex*sin(beta)*cos(beta))+ (ez*sin(beta)*cos(beta));
ezz=ex*sin(beta)^2 + ez*cos(beta)^2;

%   Calculos
root=sqrt(ex*ez)*sqrt(ez-e(1)*(sin(theta_p)).^2);
e3plus=(e(1)*(sin(theta_p)).^2)+((exz*(-sqrt(e(1))*(sin(theta_p)).^2)+root)/ez).^2;
e3minus=(e(1)*(sin(theta_p)).^2)+((exz*(-sqrt(e(1))*(sin(theta_p)).^2)+root)/ez).^2;
root2=sqrt(ex*ez)*sqrt(((c^2)*ezz)-kx.^2);
k3zplus=((-kx*exz)+root2)/ezz;
k3zminus=((-kx*exz)-root2)/ezz;

kz0=sqrt(e(1)*c^2-kx.^2);
k1z=sqrt(e(2)*c^2-kx.^2);
k2z=sqrt(e(3)*(c^2)-kx.^2);
k4z=sqrt(e(5)*(c^2)-kx.^2);

r23an=(k2z.*e3plus-k3zplus.*e(3));
r23ad=(k2z.*e3plus+k3zplus.*e(3));
r23a=r23an./r23ad;

t23ac=sqrt(e3plus)/sqrt(e(3));
t23a=t23ac.*((2*k2z*e(3))./((k2z.*e3plus)+(k3zplus*e(3))));

r34bc=sqrt(e3minus)./sqrt(e3plus);
r34bn=(k3zplus*e(5))-(k4z.*e3plus);
r34bd=(k3zplus*e(5))+(k4z.*e3plus);
r34b=r34bc.*(r34bn./r34bd);


r32cc=sqrt(e3plus)./sqrt(e3minus);
r34bn=(k3zminus*e(3))-(k2z.*e3minus);
r34bd=(k3zminus*e(3))+(k2z.*e3minus);
r32c = r32cc.*(r34bn./r34bd);

t32cc=sqrt(e(3))./sqrt(e3minus);
t32cc2= ((k3zminus.*e3plus)+(k3zplus.*e3minus))./((k3zplus*e(3))+(k2z.*k3zplus));
t32c=t32cc.*t32cc2;

dnr=20e-9;
l=40e-9;
a=0.25*(l^2-dnr^2)*sin(beta)*cos(beta);
b=0.25*((dnr^2*cos(beta)^2)+(l^2*sin(beta)^2));
x=a*sqrt(b/(a^2+(dnr*l/4)^2));
de=2/b*(a*x+dnr*l/4*sqrt(b-x^2));


r234c=(t23a.*r34b.*t32c.*exp(i*(k3zplus-k3zminus)*de))./(1-r32c.*r34b.*exp(i*(k3zplus-k3zminus)*de));
r234=r23a+r234c;
%r23a=(sqr(e3plus)/sqrt(e(3)))*



r12n=k1z*e(3)-k2z*e(2);
r12d=k1z*e(3)+k2z*e(2);
r12=r12n./r12d;

r1234n=r12+r234.*exp(2*i*k2z*d(3));
r1234d=1+(r12.*r234.*exp(2*i*k2z*d(3)));
r1234=r1234n./r1234d;


r01n=kz0*e(2)-k1z*e(1);
r01d=kz0*e(2)+k1z*e(1);
r01=r01n./r01d;

r01234=(r01+r1234.*exp(2*i*k1z*d(2)))./(1+r01.*r1234.*exp(2*i*k1z*d(2)));
final=r01234.*conj(r01234);
plot(theta_i,final)