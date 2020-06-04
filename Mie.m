%%  Programa que permite el Calculo de eficiencias
%   C_{ext}, C_{abs}, C_{sca}

%   Para este c�lculo se debe de tomar la salida del programa Mie_abcd.m
%   ya que dicho programa, es una funci�n, no se debe ejecutar, sino m�s
%   bien se llama a la funci�n dentro de este script, es importante
%   encontrarse en el mismo directorio.

%   El algoritmo de este programa se encuentra en la tesis, basado en las
%   expresiones propuestas por Bohren, con la unica modificaci�n, hecha al
%   introducir el par�metro de tama�o, descrito en el programa de la
%   funci�n Mie_abcd. Por otra parte el codigo se basa en el programa
%   propuesto por  M�tzler (M�tzler,2002), quien adem�s calcula otros
%   par�metros que en esta tesis no se requirieron, por lo tanto no se
%   calculan en este script

%%  Calculos
function result = Mie(m, x)
n_max=round(2+x+4*x^(1/3)); 
n=(1:n_max);cn=2*n+1; % n�mero que se ira multiplicando acorde a n

x2=x*x;               % calcula el cuadradro del par�metro de tama�o
in=Mie_abcd(m,x);     % toma la salida de la funci�n Mie_abcd, que se 
                      % vuelve input para los siguientes calculos
anp=(real(in(1,:)));  % toma todas las partes reales de los a_{n}
anpp=(imag(in(1,:))); % toma todos las partes imaginarias de los a_{n}
bnp=(real(in(2,:)));  % toma todas las partes reales de los b_{n}
bnpp=(imag(in(2,:))); % toma todos las partes imaginarias de los b_{n}

dn=cn.*(anp+bnp);     % suma la parte real de a_{n}+b_{n}
q=sum(dn);            % hace la suma para todos los n
ext=2*q/x2;           % Lo divide entre el par�metro de tama�os al cuadrado
en=cn.*(anp.*anp+anpp.*anpp+bnp.*bnp+bnpp.*bnpp);   % calcula los modulos al cuadrado
q=sum(en);            % suma los modulos para todos los n
sca=2*q/x2;           % Lo divide entre el par�metro de tama�os al cuadrado
abs=ext-sca;          % calculo de absorcion
result=[ext sca abs ];
end;





