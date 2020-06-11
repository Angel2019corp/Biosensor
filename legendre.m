% Este script permite el calculo de los polinomios de Legendre

%% Calculo de polinomios de Legendre de primer orden

% calculo de polinomios de Legendre de mas grados con x fija

for c=1:5 
    syms x; 
    l1=legendreP(c,x); % c representa el grado
    l(c)=l1;    % generamos un 
end
% calculo de polinomios de Legendre de mas grados variando el valor de x de
% forma numerica
m=-.99:.02:.99; % generamos el rango de valores para x
k=size(m,2); % ayuda a definir el ciclo for ya que es el numero de elementos de m
for c=1:5 % esta sentencia indica el numero de funciones de lgendre desde 
    % grado 1, hasta n =10
    for p=1:k % indica cuantos valores diferentes de x tomara
        f=subs(l(c),x,m(p));
        a(c,p)=f;
        
    end    
end

% graficado de polinomios de legendre 
for c=1:5
   hold on
   plot(m,a(c,:))
end
%%
plot(m,a(1,:))
hold on
plot(m,a(2,:))
hold on
plot(m,a(3,:))
hold on
plot(m,a(4,:))
hold on
plot(m,a(5,:))
hold on
legend('P_{1}','P_{2}','P_{3}','P_{4}','P_{5}')
%% Funciones de legendre asociadas
for p=1:5
    v=(1-x^2)^(1/2) *diff(l(p));
    u=simplify(v);
    aso(p)=u;
end

^

% calculo de polinomios de Legendre de mas grados variando el valor de x de
% forma numerica
m=-.99:.02:.99; % generamos el rango de valores para x
k=size(m,2); % ayuda a definir el ciclo for ya que es el numero de elementos de m
for c=1:5 % esta sentencia indica el numero de funciones de lgendre desde 
    % grado 1, hasta n =10
    for p=1:k % indica cuantos valores diferentes de x tomara
        f=subs(aso(c),x,m(p));
        b(c,p)=f;
        
    end    
end

% graficado de polinomios de legendre asociados
for c=1:5
   hold on
   plot(m,b(c,:))
end

%% Etiquetas
%  title('Grafico de funciones de Legendre asociadas de primer orden')
%legend('n=1','n=2','n=3','n=4','n=5')
%%
plot(m,b(1,:))
hold on
plot(m,b(2,:))
hold on
plot(m,b(3,:))
hold on
plot(m,b(4,:))
hold on
plot(m,b(5,:))
hold on
legend('P_{n=1}^{m=1}','P_{n=2}^{m=1}','P_{n=3}^{m=1}','P_{n=4}^{m=1}','P_{n=5}^{m=1}')

