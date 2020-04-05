# -*- coding: utf-8 -*-
"""
Created on Thu Apr  2 10:49:01 2020

@author: wabng
"""

# este script permite realizar el grafico de reflectancia 
# para el sistema de 3 capas


# Librerias y recursos necesarios
from math import pi, cos, sin, sqrt
import cmath
import numpy as np
import matplotlib.pyplot as plt

## Se inicia con valores definidos
# ---PARÁMETROS DE LAS DISTINTAS CAPAS

#  Vidrio (SF10), 633 nm
enpr=1.76; # n del vidrio 

# Oro, 633 nm
e1n=0.1726; #Parte real de n (oro)
e1k=3.4218; #Parte imaginaria de n (oro)
e1r=e1n**2-e1k**2; #Parte real de epsilon (oro)
e1r=round(e1r,4)
e1i=2*e1n*e1k; #Parte imaginaria de epsilon (oro)
e1i=round(e1i,4)
e1=complex(e1r,e1i); #Epsilon compleja (oro)
d1=45e-9; #Grosor de la capa de oro (m)
#Aire
e2=1; #n del aire (sólo hay parte real)
#%---CONSTANTES Y PARÁMETROS DADOS
c=2.99792458e8;
lam=632.8e-9; #longitud de onda lamda (lam)
pi=round(pi,9)
omega=2*pi/lam*c;

cifras=5 # Cifras decimales que se tomaran

# Creación de vector de angulos
ang0=34
ang1=40
vals=1000
interval=ang1-ang0
angmat=np.linspace(ang0,ang1,vals) 
# step de .006, los indices van desde 0 hasta 999

# Ahora se debe de generar los valores para cada elemento 


# conversion 
ref=np.zeros(1000,dtype=float) # creamos un vector vacio 
#Nuevamente este vector es de 1000 elementos
# los indices inician desde 0 hasta 999
for x in range(len(angmat)):
    # Realiza la conversion, para cada elemento 
    # que se encuentra desde 0 hasta 999
    # Generando un vector de 1000 elementos
    # El tomar estos valores como limites
    # ayuda mucho en la conversion a radianes 
    
    #Define un angulo en radianes para cada x
    theta=(ang0+ ((x)*interval)/vals)/180*pi
    theta = round(theta,cifras) # Redondeo 
    
    
    #rpr1
    a=(cos(theta)/enpr)-(cmath.sqrt(e1-(enpr**2)*(sin(theta)**2))/e1)
    ar=round(a.real,cifras)
    ai=round(a.imag,cifras)
    a=complex(ar,ai)
    
    b=(cos(theta)/enpr) + (cmath.sqrt(e1-(enpr**2)*(sin(theta)**2))/e1)
    br=round(b.real,cifras)
    bi=round(b.imag,cifras)
    b=complex(br,bi)
    
    # Se realiza la division de 
    # complejos de esta manera
    # de acuerdo a la definicion de 
    # division de complejo, que es 
    # ultiplicar por el complejo 
    # conjugado del denomindador
    # arriba y abajo
    den=a*a.conjugate()
    denr=round(den.real,cifras)
    deni=round(den.imag,cifras)
    den=complex(denr,deni)
    
    num= a*b.conjugate()
    
    numr=round(num.real,cifras)
    numi=round(num.imag,cifras)
    num=complex(numr,numi)
    
    
    
    rpr1=num/den.real
    
    rpr1r=round(rpr1.real,cifras)
    rpr1i=round(rpr1.imag,cifras)
    rpr1=complex(rpr1r,rpr1i)

    #r12 
    f=(cmath.sqrt(e1-(enpr**2)*(sin(theta)**2))/e1)-(cmath.sqrt(e2-(enpr**2)*(sin(theta)**2))/e2)
    fr=round(f.real,cifras)
    fi=round(f.imag,cifras)
    f=complex(fr,fi)
    
    g=(cmath.sqrt(e1-(enpr**2)*(sin(theta)**2))/e1)+(cmath.sqrt(e2-(enpr**2)*(sin(theta)**2))/e2)
    gr=round(g.real,cifras)
    gi=round(g.imag,cifras)
    g=complex(gr,gi)
    
    
    num2= f*g.conjugate()
    num2r=round(num2.real,cifras)
    num2i=round(num2.imag,cifras)
    num2=complex(num2r,num2i)
    
    den2=g*g.conjugate()
    den2r=round(den2.real,cifras)
    den2i=round(den2.imag,cifras)
    den2=complex(den2r,den2i)
    
    r12=num2/den2.real
    
    r12r=round(r12.real,cifras)
    r12i=round(r12.imag,cifras)
    r12=complex(r12r,r12i)
    
    
    #kz1d1
    kz1d1=omega/c*d1*cmath.sqrt(e1-(enpr**2)*(sin(theta)**2))

    kz1d1r=round(kz1d1.real,cifras)
    kz1d1i=round(kz1d1.imag,cifras)
    kz1d1=complex(kz1d1r,kz1d1i)
    
    exp=cmath.exp(2*1j*kz1d1)
    expr=round(exp.real,cifras)
    expi=round(exp.imag,cifras)
    exp=complex(expr,expi)    
    
    #rpr12
    rpr12n = rpr1+(r12*exp)
    rpr12nr=round(rpr12n.real,cifras)
    rpr12ni=round(rpr12n.imag,cifras)
    rpr12n=complex(rpr12nr,rpr12ni)
    
    rpr12d = 1+( rpr1*r12*exp)
    rpr12dr=round(rpr12d.real,cifras)
    rpr12di=round(rpr12d.imag,cifras)
    rpr12d=complex(rpr12dr,rpr12di)
    
    numerador=rpr12n*rpr12d.conjugate()
    numeradorr=round(numerador.real,cifras)
    numeradori=round(numerador.imag,cifras)
    numerador=complex(numeradorr,numeradori)



    denominador=rpr12d*rpr12d.conjugate()
    denominadorr=round(denominador.real,cifras)    
    denominadori=round(denominador.imag,cifras)    
    denominador=complex(denominadorr,denominadori)

    rpr12=numerador/denominador.real
    refl=rpr12*rpr12.conjugate()
    reflreal=round(refl.real,3)
    ref[x]=reflreal # Asigna el valor
    # Despues de realizar todo el 
    # ciclo para el elemento x
    # asigna ese valor al elemento con posicion
    # ref[x] = valor
    # Ya que todos estos valores
    # quedan guardados en este vector
    #lo unico que queda por hacer es un 
    # scatter plot
    
    
#Obtener el minimo de reflectancia 
indice= np.where(ref==min(ref))[0][1]
#luego se busca ese valor en el vector 
# de angulos
angmin=round(angmat[indice],2)
# se ingresa de esa forma por que es una tupla    
# Graficado 
fig = plt.figure()
ax = fig.add_subplot(111,xlim=(34,40), ylim=(0, 1))   
ax.annotate('$\\theta_{min}=$'+str(angmin)+'°',
            xy=(80, 80), xycoords='figure points')

plt.plot(angmat,ref,'r')
plt.title('SIMULACIÓN DE MONTAJE SPR')
plt.xlabel('Reflectancia (u.a.)')
plt.ylabel('Angulo(°)')
plt.show()
