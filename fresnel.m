% Parámetos de entrada
%   e, la función dieléctrica del medio a sensar
%   start, es el ángulo inicial
%   stop, es

function result = fresnel(e)
format long
enpr=1.76; %n del vidrio (sólo hay parte real)
%Oro, 633 nm
e1n=0.1726; %Parte real de n (oro)
e1k=3.4218; %Parte imaginaria de n (oro)
e1r=e1n^2-e1k^2; %Parte real de epsilon (oro)
e1i=2*e1n*e1k; %Parte imaginaria de epsilon (oro)
e1=complex(e1r,e1i); %Epsilon compleja (oro)
d1=45e-9; %Grosor de la capa de oro (m)
%Aire
e2=e; %n del aire (sólo hay parte real)
%---CONSTANTES Y PARÁMETROS DADOS
c=2.99792458e8;
lambda=632.8e-9;
omega=2*pi/lambda*c;
%---ESCANEO DE LOS ÁNGULOS Y SOLUCIÓN DE LAS ECUACIONES DE FRESNEL
ang0=30; %Límite inferior
ang1=80; %Límite superior
vals=1000;
interval=ang1-ang0;
angmat=ang0:(interval/vals):ang1; %Vector de ángulos primer valor: intervalo/valores:valorfinal
% en este caso el incremento sera 0.0060 grados

for x=1:(length(angmat))  %Para cada elemento de angmat
theta=(ang0+((x-1)*interval)/vals)/180*pi; %realiza la conversion para radianes
% lo realiza para cada elemento uno por uno, ya que ese valor de theta
% es el que se introduce en cada calculo posterior
rpr1=(cos(theta)/enpr - sqrt(e1-(enpr^2)*(sin(theta)^2))/e1)/...
(cos(theta)/enpr + sqrt(e1-(enpr^2)*(sin(theta)^2))/e1);
r12=(sqrt(e1-(enpr^2)*(sin(theta)^2))/e1 -...
sqrt(e2-(enpr^2)*(sin(theta)^2))/e2) /...
(sqrt(e1-(enpr^2)*(sin(theta)^2))/e1 +...
sqrt(e2-(enpr^2)*(sin(theta)^2))/e2);
kz1d1=omega/c*d1*sqrt(e1-(enpr^2)*(sin(theta)^2));
rpr12=(rpr1+ r12*exp(2*i*kz1d1))/(1+rpr1*r12*exp(2*i*kz1d1));
ref(x)=rpr12*(conj(rpr12));
end
result = ref;
end