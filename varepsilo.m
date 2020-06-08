%  CALCULO DE ABSORBANCIA AL VARIAR EPSILON PARA NANORODS
%% Parametros a considerar
% Constante dielectrica del medio circundante
filename = 'epsaunano.xlsx';
lambda= xlsread(filename,'m1:bnt1');  % Energia
eRe_nano = xlsread(filename,'m2:bnt2');  % Parte real
eIm_nano = xlsread(filename,'m3:bnt3');  % Parte imaginaria

epsilonau=complex(eRe_nano,eIm_nano);

% epsilonau es la epsilon de oro corregida para nanoparticulas
epsi1=real(epsilonau);
epsi2=imag(epsilonau); %

% % Factores de depolarizacion 
% % Estos son fijos y estan en función de la excentricidad, por lo tanto se
% % calculan al principio del programa
% % A en nm
%% relacion de aspecto 1
A=1.9;
% B =C  condicion A > B
B=1;
Ra=A/B;
% Excentricidad 
e=sqrt(1-(B/A)^2) ;
pa=((1-e^2)/(e^2))*(-1+(1/(2*e))*log((1+e)/(1-e)));
% Calulamos Pc=Pb
pc=(1-pa)/2;
pb=pc;
stop =length(lambda);
em=1.77;
% % Factores de depolarizacion 
% % Estos son fijos y estan en función de la excentricidad, por lo tanto se
% % calculan al principio del programa
% % A en nm
for c=1:stop
% Ahora se debe de realizar una sumatoria:
% La cual se aplica a cada factor de depolarizacion
% Este se debe de aplicar para cada valor de epsilon correspondiente a cada
% lambda
    fact1(c)= (epsi2(c) /(pa*pa))/((epsi1(c)+(em*(1-pa)/pa))^2 + epsi2(c)^2);
% para la depolarizacion 2 y 3 pb y pc
    fact23(c)= 2*(epsi2(c) /(pb*pb))/((epsi1(c)+(em*(1-pb)/pb))^2 + epsi2(c)^2);

% A su vez se debe multiplicar por 
    depen(c)=(2*pi*(em^(3/2)))/(3*lambda(c));

% finalmente se obtiene gama/NV

    gamma1(c) = depen(c)*(fact1(c)+fact23(c));
end
%% Diferente valor de epsilo
%% relacion de aspecto 1
A=2.3;
% B =C  condicion A > B
B=1;
Ra=A/B;
% Excentricidad 
e=sqrt(1-(B/A)^2) ;
pa=((1-e^2)/(e^2))*(-1+(1/(2*e))*log((1+e)/(1-e)));
% Calulamos Pc=Pb
pc=(1-pa)/2;
pb=pc;
stop =length(lambda);
em2=1.77;

for c=1:stop
% Ahora se debe de realizar una sumatoria:
% La cual se aplica a cada factor de depolarizacion
% Este se debe de aplicar para cada valor de epsilon correspondiente a cada
% lambda
    fact1(c)= (epsi2(c) /(pa*pa))/((epsi1(c)+(em2*(1-pa)/pa))^2 + epsi2(c)^2);
% para la depolarizacion 2 y 3 pb y pc
    fact23(c)= 2*(epsi2(c) /(pb*pb))/((epsi1(c)+(em2*(1-pb)/pb))^2 + epsi2(c)^2);

% A su vez se debe multiplicar por 
    depen(c)=(2*pi*(em2^(3/2)))/(3*lambda(c));

% finalmente se obtiene gama/NV

    gamma2(c) = depen(c)*(fact1(c)+fact23(c));
end

%% relacion de aspecto 1
A=2.6;
% B =C  condicion A > B
B=1;
Ra=A/B;
% Excentricidad 
e=sqrt(1-(B/A)^2) ;
pa=((1-e^2)/(e^2))*(-1+(1/(2*e))*log((1+e)/(1-e)));
% Calulamos Pc=Pb
pc=(1-pa)/2;
pb=pc;
stop =length(lambda);
em3=1.77;

for c=1:stop
% Ahora se debe de realizar una sumatoria:
% La cual se aplica a cada factor de depolarizacion
% Este se debe de aplicar para cada valor de epsilon correspondiente a cada
% lambda
    fact1(c)= (epsi2(c) /(pa*pa))/((epsi1(c)+(em3*(1-pa)/pa))^2 + epsi2(c)^2);
% para la depolarizacion 2 y 3 pb y pc
    fact23(c)= 2*(epsi2(c) /(pb*pb))/((epsi1(c)+(em3*(1-pb)/pb))^2 + epsi2(c)^2);

% A su vez se debe multiplicar por 
    depen(c)=(2*pi*(em3^(3/2)))/(3*lambda(c));

% finalmente se obtiene gama/NV

    gamma3(c) = depen(c)*(fact1(c)+fact23(c));
end

gamma1n=gamma1/max(gamma3);
gamma2n=gamma2/max(gamma3);
gamma3n=gamma3/max(gamma3);

%% Estilo de graficacion
plot(lambda,gamma1n)
ar=area(lambda,gamma1n); 
ar.FaceColor =[0 1 1];
ar.FaceAlpha =0.4; 
ar.EdgeColor = [0 1 1];
ar.EdgeAlpha =1;
ar.LineWidth = 1;
hold on
plot(lambda,gamma2n)
ar=area(lambda,gamma2n); 
ar.FaceColor =[0 0 1];
ar.FaceAlpha =0.4; 
ar.EdgeColor = [0 0 1];
ar.EdgeAlpha =1;
ar.LineWidth = 1;
hold on
plot(lambda,gamma3n)
ar=area(lambda,gamma3n); 
ar.FaceColor =[1 0 1];
ar.FaceAlpha =0.4; 
ar.EdgeColor = [0.6350 0.0780 0.1840];
ar.EdgeAlpha =1;
ar.LineWidth = 1;


ax = gca;
ax.XAxis.Exponent = -9;

axis([420*10^(-9) 850*10^(-9) 0 1])

xlabel('\lambda','FontSize',15,'FontWeight','bold')
ylabel('Absorbancia (u.a.)','FontSize',15,'FontWeight','bold')
%legend({'R_{a}=1.9','R_{a}=2.3','R_{a}=2.6'},'Location','southwest')
str = {'\epsilon_{m}=1','\epsilon_{m}=2','\epsilon_{m}=3'};
%text(450*10^(-9),max(gammanor),str(1),'Color','k','FontSize',20)
%text(500*10^(-9),max(gammano2),str(2),'Color','k','FontSize',20)
text([550*10^(-9) 680*10^(-9)  800*10^(-9)],[.4 .7 .7],str,'Color','k','FontSize',20)

