%% Programa que obtiene la gráfica de absorbancia usando la teoria de Mie
%  para ello se utilizan las funciones 
%  Mie_abcd.m y Mie.m, además se utilizan los valores de la función 
%  dieléctrica de las esferas, corregidas nanometricamente 
%  propuesto por Kreibig y Vonfragstein (1969), el cual se encuentra en
%  otro programa llamado correcion, sin embargo para no hacer este
%  programa muy extenso, solo tomamos los valores calculados por dicho
%  programa, los cuales se encuentran en un documento excel.
%%          Valores iniciales
                                         % Medio anfitrión
n_medio = 1.33;                          % Índice de refracción
em= sqrt(n_medio);                       % cte. dieléctrica
                                         % esfera metalica
filename = 'nombrearchivo.xlsx';        
lambda = xlsread(filename,'A1:ZY1');     % Lambda
eRe= xlsread(filename,'A2:ZY2');         % Parte real funcion dielectrica
eIm = xlsread(filename,'A3:ZY3');        % Parte imaginaria funcion dielectrica
                                           
start=10;   stop=700;                    % Definimos limites

% convertimos a numero complejo la función dieléctrica de las NPs
epsilon  = eRe(start:stop)+i*eIm(start:stop);
epsilon2 = eRe2(start:stop)+i*eIm2(start:stop);
                                         % Tomamos valores de interes 
lam=lambda(start:stop);
lon =length(lam);
eRecf=interp1(lambdac,eRec,lambda);
eImcf=interp1(lambdac,eImc,lambda);
epsilonc = eRecf(start:stop)+i*eImcf(start:stop);
    

m =sqrt(epsilon)/n_medio;                % Generamos indice relativo
a=20e-9;x = (2*pi./lam)*a*n_medio;       % Generamos parametro de tamaño 
%  Cálculo de coeficientes usando programa Mie, para cada valor de lambda
for c=1:lon
    s=Mie(m(c),x(c));
    g(c)=s(3); % tomamos el elemento 3 de la salida 
end
%% Visualizacion
plot(lam,g) 
ar=area(lam,y);% oro bulto
ar.FaceColor =[0 0.4470 0.7410];
ar.FaceAlpha =0.4; 
ar.EdgeColor = [0 0 1];
ar.EdgeAlpha =1;
ar.LineWidth = 2.5;
ax = gca;
ax.XAxis.Exponent = -9;             % exponente en el eje x
legend({'Leyenda'},'Location','southwest')
axis([420*10^(-9) 700*10^(-9) 0 4])  %Región de interes
xlabel('\lambda (nm)','FontSize',15,'FontWeight','bold')
ylabel('Absorbancia (u.a.)','FontSize',15,'FontWeight','bold')