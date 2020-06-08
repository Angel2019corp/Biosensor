% Este script permite el calculo y visualizacion de
% la grafica de absorbancia de particulas elipsoidales

% Expresión a utilizar
% Las expresiones a utilizar son del trabajo de Gans y Papavassiliou

clear all
%% Parametros a considerar
% Constante dielectrica del medio circundante
em=1.77;
% Constante dielectrica de las particulas
% Estos valores corresponden a la correccion nanometrica

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
A=3;
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
% Calulamos Pa
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

    gamma(c) = depen(c)*(fact1(c)+fact23(c));
end
%% Para otra ra
A1=2.3;
% B =C  condicion A > B
B1=1;
% Excentricidad 
e1=sqrt(1-(B1/A1)^2) ;
pa1=((1-e1^2)/(e1^2))*(-1+(1/(2*e1))*log((1+e1)/(1-e1)));
% Calulamos Pc=Pb
pc1=(1-pa1)/2;
pb1=pc1;
stop =length(lambda);
% Calulamos Pa
for c=1:stop
% Ahora se debe de realizar una sumatoria:
% La cual se aplica a cada factor de depolarizacion
% Este se debe de aplicar para cada valor de epsilon correspondiente a cada
% lambda
    fact11(c)= (epsi2(c) /(pa1*pa1))/((epsi1(c)+(em*(1-pa1)/pa1))^2 + epsi2(c)^2);
% para la depolarizacion 2 y 3 pb y pc
    fact231(c)= 2*(epsi2(c) /(pb1*pb1))/((epsi1(c)+(em*(1-pb1)/pb1))^2 + epsi2(c)^2);

% A su vez se debe multiplicar por 
    depen1(c)=(2*pi*(em^(3/2)))/(3*lambda(c));

% finalmente se obtiene gama/NV

    gamma1(c) = depen1(c)*(fact11(c)+fact231(c));
end

%% Para otra ra
A2=2.6;
% B =C  condicion A > B
B1=1;
% Excentricidad 
e2=sqrt(1-(B1/A2)^2) ;
pa2=((1-e2^2)/(e2^2))*(-1+(1/(2*e2))*log((1+e2)/(1-e2)));
% Calulamos Pc=Pb
pc2=(1-pa2)/2;
pb2=pc2;
stop =length(lambda);
% Calulamos Pa
for c=1:stop
% Ahora se debe de realizar una sumatoria:
% La cual se aplica a cada factor de depolarizacion
% Este se debe de aplicar para cada valor de epsilon correspondiente a cada
% lambda
    fact2(c)= (epsi2(c) /(pa2*pa2))/((epsi1(c)+(em*(1-pa2)/pa2))^2 + epsi2(c)^2);
% para la depolarizacion 2 y 3 pb y pc
    fact232(c)= 2*(epsi2(c) /(pb2*pb2))/((epsi1(c)+(em*(1-pb2)/pb2))^2 + epsi2(c)^2);

% A su vez se debe multiplicar por 
    depen2(c)=(2*pi*(em^(3/2)))/(3*lambda(c));

% finalmente se obtiene gama/NV

    gamma2(c) = depen2(c)*(fact2(c)+fact232(c));
end

%% Normalizacion al valor mas grande
gammanor=gamma/max(gamma);
%%



%%
gammanor=gamma/max(gamma2);
gammanor1=gamma1/max(gamma2);
gammanor2=gamma2/max(gamma2);
% Normalizacion al valor mas grande de ambos
% gammanor2=gamma2/max(gamma2);




%% Vizualizacion

plot(lambda,gammanor)

% hold on
% plot(lambda,gammanor1)
% hold on
% plot(lambda,gammanor2)
%  legend({'R_{a}=1.9','R_{a}=2.3','R_{a}=2.6'},'Location','southwest')
% ar=area(lambda,gammanor); 
% ar.FaceColor =[0 0.4470 0.7410];
% ar.FaceAlpha =0.4; 
% ar.EdgeColor = [0 0 1];
% ar.EdgeAlpha =1;
% ar.LineWidth = 1;
%
%plot(lambda,gamma)
axis([400*10^(-9) 700*10^(-9) 0 2e8])
ax = gca;
ax.XAxis.Exponent = -9;

%%
% grid on
% xlabel('\lambda','FontSize',15,'FontWeight','bold')
% ylabel('Absorbancia (u.a.)','FontSize',15,'FontWeight','bold')
% legend({'\epsilon_{m}=3'},'Location','southwest')
% text(450*10^(-9),0.5,'\epsilon_{m}=3','Color','k','FontSize',20)
%%
%e=0:.1:1
% % Calulamos Pa
% pa=((1-e^2)/(e^2))*(-1+(1/(2*e))*log((1+e)/(1-e)));
% % Calulamos Pc=Pb
% pc=(1-pa)/2;
% pb=pc;
% % Ahora se debe de realizar una sumatoria:
% % La cual se aplica a cada factor de depolarizacion
% % Este se debe de aplicar para cada valor de epsilon correspondiente a cada
% % lambda
% fact1= (epsi2 /(pa*pa))/((epsi1+(em*(1-pa)/pa))^2 + epsi2^2);
% % para la depolarizacion 2 y 3 pb y pc
% fact23= 2*(epsi2 /(pb*pb))/((epsi1+(em*(1-pb)/pb))^2 + epsi2^2);
% 
% % A su vez se debe multiplicar por 
% depen=(2*pi*(em^(3/2)))/(3*lambda);
% 
% % finalmente se obtiene gama/NV
% 
% gamma = depen*(fact1+fact23);





% Para distintos valores de la excentricidad
% for c=1:11
%     pa(c)=((1-e(c)^2)/(e(c)^2))*(-1+(1/(2*e(c)))*log((1+e(c))/(1-e(c))));
% end


%% Estilo de graficacion
% plot(lambda,gammanor)
% ar=area(lambda,gammanor); 
% ar.FaceColor =[0 1 1];
% ar.FaceAlpha =0.4; 
% ar.EdgeColor = [0 1 1];
% ar.EdgeAlpha =1;
% ar.LineWidth = 1;
% hold on
plot(lambda,gammanor)
ar=area(lambda,gammanor); 
ar.FaceColor =[0 0 1];
ar.FaceAlpha =0.3; 
ar.EdgeColor = [0 0 1];
ar.EdgeAlpha =1;
ar.LineWidth = 2;
% hold on
% plot(lambda,gammanor2)
% ar=area(lambda,gammanor2); 
% ar.FaceColor =[1 0 1];
% ar.FaceAlpha =0.4; 
% ar.EdgeColor = [0.6350 0.0780 0.1840];
% ar.EdgeAlpha =1;
% ar.LineWidth = 1;


ax = gca;
ax.XAxis.Exponent = -9;

axis([450*10^(-9) 780*10^(-9) 0 1])

xlabel('\lambda','FontSize',15,'FontWeight','bold')
ylabel('Absorbancia (u.a.)','FontSize',15,'FontWeight','bold')
legend({'R_{a}=3'},'Location','southwest')
% str = {'R_{a}=3'};
% %text(450*10^(-9),max(gammanor),str(1),'Color','k','FontSize',20)
% %text(500*10^(-9),max(gammano2),str(2),'Color','k','FontSize',20)
% text([550*10^(-9) 580*10^(-9)  650*10^(-9)],[.6 .8 .9],str,'Color','k','FontSize',20)

