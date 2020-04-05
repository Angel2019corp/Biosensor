# -*- coding: utf-8 -*-
"""
Created on Thu Apr  2 23:32:17 2020

@author: wabng
"""

import pandas as pd
import matplotlib.pyplot as plt

archivo_excel = pd.read_excel('datosf.xlsx')
energia = archivo_excel['Ev'].values
eRe = archivo_excel['RE(e)'].values
eIm = archivo_excel['Im(E)'].values

lam =(12.39*10**(-7))/energia # lamda

plt.plot(lam,eRe)
plt.ylim(-45, 0)
plt.xlim(200*10**(-9), 1000*10**(-9))             # Configuramos el límite vertical
plt.show()