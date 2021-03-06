% Respuesta de AuNRs considerando la teoria del medio efecctivo simple


function result = fresnel2(dfilm,fracc,daunr)

format long
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
d(2) = dfilm*1e-9;
% medio 2
% medio 4
n(4) = 1.33;
k(4) = 0;
d(4) = 0;
%   ---   Conversión a ctes. diel Isotropicos
e =(n+k).^2;  






%---ESCANEO DE LOS ÁNGULOS Y SOLUCIÓN DE LAS ECUACIONES DE FRESNEL
ang0=30; %Límite inferior
ang1=80; %Límite superior
vals=1000;
interval=ang1-ang0;
angmat=ang0:(interval/vals):ang1; %Vector de ángulos primer valor: intervalo/valores:valorfinal
% en este caso el incremento sera 0.0060 grados
%dimensiones nrs
dnr=10e-9;
l=daunr*1e-9;
r=dnr/l;

%   función dielectrica efectiva del medio 3
            % relación de aspecto
exc = sqrt(1-r^2);    % Excentricidad
h=(1/(2*exc))*log((1+exc)/(1-exc));
lz= ((1-exc^2)/exc^2)*(h-1);% factor geometrico lz
lx=(1/2)*(1-lz);
ly=lx;
f = fracc; 
a2=((1-f)*(e(4)-e(2)))./(e(2)+lx*(e(4)-e(2)));
ex=e(2)*(a2*(1-lx)+1)/(1-a2*lx);
ey=e(2)*(a2*(1-ly)+1)/(1-a2*ly);
ez=e(2)*(a2*(1-lz)+1)/(1-a2*lz);
% ex = 4+.1*i;
% ey=3+2*i;
% ez=2+0*i;
% conversión de coordenadas
beta =0; 
exx=ex*cos(beta)^2 + ez*sin(beta)^2;
exz=(-ex*sin(beta)*cos(beta))+ (ez*sin(beta)*cos(beta));
ezz=ex*sin(beta)^2 + ez*cos(beta)^2;
        % Fracción de llenado
% conversion a epsilon
% ex=e(2)*(1-(1-f)*(e(5)-e(2))*lx+(1-f)*(e(5)-e(2)))/(1-(1-f)*(e(5)-e(2))*lx);
% ey=e(2)*(1-(1-f)*(e(5)-e(2))*ly+(1-f)*(e(5)-e(2)))/(1-(1-f)*(e(5)-e(2))*ly);
% ez=e(2)*(1-(1-f)*(e(5)-e(2))*lz+(1-f)*(e(5)-e(2)))/(1-(1-f)*(e(5)-e(2))*lz);


%ex=((1-f)*(e(5)-e(2)))./(e(2)+lx*(e(5)-e(2)));
%ey=((1-f)*(e(5)-e(2)))./(e(2)+ly*(e(5)-e(2)));
%ez=((1-f)*(e(5)-e(2)))./(e(2)+lz*(e(5)-e(2)));

for x=1:(length(angmat))  %Para cada elemento de angmat
theta1=(ang0+((x-1)*interval)/vals)/180*pi; %realiza la conversion para radianes
theta=theta1+(pi*5/180);


kx=sqrt(e(1))*c*sin(theta);


root=sqrt(ex*ez)*sqrt(ez-e(1)*(sin(theta))^2);
e3plus=(e(1)*(sin(theta))^2)+((exz*(-sqrt(e(1))*(sin(theta))^2)+root)/ez)^2;
e3minus=(e(1)*(sin(theta))^2)+((exz*(-sqrt(e(1))*(sin(theta))^2)+root)/ez)^2;
root2=sqrt(ex*ez)*sqrt(((c^2)*ezz)-kx^2);
k3zplus=((-kx*exz)+root2)/ezz;
k3zminus=((-kx*exz)-root2)/ezz;

%kz0=sqrt(e(1)*c^2-kx^2);
k1z=sqrt(e(1)*c^2-kx.^2);
k2z=sqrt(e(2)*(c^2)-kx^2);
k4z=sqrt(e(4)*(c^2)-kx^2);

r23an=(k2z*e3plus-k3zplus*e(2));
r23ad=(k2z*e3plus+k3zplus*e(2));
r23a=r23an/r23ad;

t23ac=sqrt(e3plus)/sqrt(e(2));
t23a=t23ac*((2*k2z*e(2))/((k2z*e3plus)+(k3zplus*e(2))));

r34bc=sqrt(e3minus)/sqrt(e3plus);
r34bn=(k3zplus*e(4))-(k4z*e3plus);
r34bd=(k3zplus*e(4))+(k4z*e3plus);
r34b=r34bc*(r34bn/r34bd);


r32cc=sqrt(e3plus)/sqrt(e3minus);
r34bn=(k3zminus*e(2))-(k2z*e3minus);
r34bd=(k3zminus*e(2))+(k2z*e3minus);
r32c = r32cc*(r34bn/r34bd);

t32cc=sqrt(e(2))/sqrt(e3minus);
t32cc2= ((k3zminus*e3plus)+(k3zplus*e3minus))/((k3zplus*e(2))+(k2z*k3zplus));
t32c=t32cc*t32cc2;


a=0.25*(l^2-dnr^2)*sin(beta)*cos(beta);
b=0.25*((dnr^2*cos(beta)^2)+(l^2*sin(beta)^2));
x1=a*sqrt(b/(a^2+(dnr*l/4)^2));
de=2/b*(a*x1+dnr*l/4*sqrt(b-x1^2));


r234c=(t23a*r34b*t32c*exp(i*(k3zplus-k3zminus)*de))/(1-r32c*r34b*exp(i*(k3zplus-k3zminus)*de));
r234=r23a+r234c;
%r23a=(sqr(e3plus)/sqrt(e(3)))*



r12n=k1z*e(2)-k2z*e(1);
r12d=k1z*e(2)+k2z*e(1);
r12=r12n/r12d;

r1234n=r12+r234*exp(2*i*k2z*d(2));
r1234d=1+(r12*r234.*exp(2*i*k2z*d(2)));
r1234=r1234n./r1234d;


% r01n=kz0*e(2)-k1z*e(1);
% r01d=kz0*e(2)+k1z*e(1);
%r01=r01n/r01d;

%r01234=(r01+r1234*exp(2*i*k1z*d(2)))/(1+r01*r1234*exp(2*i*k1z*d(2)));
final(x)=r1234.*conj(r1234);
end

result = final;
end 
