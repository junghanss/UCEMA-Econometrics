clear all
cd "C:\Users\JUAN\Google Drive\Universidad\UCEMA\Econometria\TP\TP4"
set more off
capture log close
*Ejercicio (7) - TP 4
import excel "datosTP4.xls", sheet(Ej7) firstrow
*Punto (A):
reg Tncosechadasdesoja Preciodelasoja ndicedepreciosdegranos /*Regresamos las Tn. cosecha de soja sobre el precio de esta y el indice de precios de granos*/
*Ecuacion obtenida: Tn cosechadas soja = 15.972 - 6.838*(Precio soja) + 0.747*(Indice p. granos)
/*El coef hallado para el precio de soja nos indica que ante una variacion unitaria de este, la variable explicada Yi se reducirá -6.838, manteniendo el resto constante, para un nivel de significancia de '1%'.
De acuerdo a determinados supuestos económicos, puede en cierto punto no ser un coeficiente esperado, dado que si  se considera un mercado de commodities que tiende a competitividad perfecta, donde el productor puede colocar su producción al precio que cotiza el bien, se esperaría incrementos en las cosechas ante incrementos en la soja.
El coef hallado para el indice de precios de granos nos indica que ante una variacion unitaria de este, la variable explicada Yi aumentará 0.747, manteniendo el resto constante, para un nivel de significancia de '1%'.*/

*Punto (B):
scalar SEC = e(mss)
scalar SCR = e(rss)
scalar k1 = e(df_m) /*nombramos los grados de libertad del modelo*/
scalar nk = e(df_r) /*nombramos los gl del residuo*/
scalar F = (SEC/k1)/(SCR/nk)
di Ftail(k1, nk, F)
di invFtail(k1,nk,0.05)
*La significatividad global del modelo está dada por el Ftest de significancia conjunta de los estimadores, en el cual planteamos una Hipótesis nula de que son todos iguales a cero y una alternativa de que al menos uno no lo es, donde para nuestro modelo nos arrojó que rechaza la hipótesis nula a un nivel de significancia de 1% y tambien 5%. Por lo que los estimadores conjuntamente son relevantes.
/*La significatividad estáditisca de los estimadores surge a partir de los test de 't' de Student, en los cuales se evalua la relevancia parcial de cada estimador planteando una Hipótesis nula de Bi=0 y una alternativa unilateral o bilateral. 
En nuestro modelo, el estimador B1 resulta significante individualmente ante un nivel de significancia 1%.
El estimador B2 resulta también significante de manera individual frente nivel de significancia de 1%.
*El valor del coeficiente de determinación obtenido es de 0.8666, lo que nos indica una explicación de las tn cosechadas de soja en un 86.66% por las variables del precio de la soja y del indice de precios de granos.
Por relación matemática, tenemos un 13.34% de Yi que no es explicada por estas variables.*/

*Punto (C):

reg Tncosechadasdesoja Preciodelasoja

*Ecuacion obtenida: Tn cosechadas soja = 16.804 + 0.6512 (Precio soja)
/*El coef hallado para el precio de la soja nos indica que ante una variacion unitaria de este, la variable explicada Yi se incrementará 0.6512, manteniendo el resto constante, para un nivel de significancia de 1%.
A diferencia de la regresión lineal multiple, este posee signo positivo.
*Hay significatividad global de las Tn cosechadas regresadas sobre el precio de la soja, ya que la hipotesis nula B1=0 se rechaza.
*Hay significatividad individual del coeficiente, ya que a un valor de significancia de 1% se rechaza la hipotesis.
*/

reg Tncosechadasdesoja ndicedepreciosdegranos
*Ecuacion obtenida: Tn cosechadas soja = 16.72974 + 0.065 (Indice precios granos)
/*El coef hallado para el indice de precios de granos nos muestra que ante variaciones unitarias de la varaible, Yi aumenta un 0.065, manteniendo el resto constante.
*En contraste con el modelo de regresion multiple, el coeficiente es menor pero mantiene su influencia positiva.
*Hay significatividad individual del coeficiente, ya que a un valor de significancia de 1% se rechaza la hipotesis. 
*/

*Punto (D):
corr Preciodelasoja ndicedepreciosdegranos
*La correlacion entre las variables independientes (precio de la soja e indice de precios de granos) es perfectamente positiva, lo que nos indica que siempre que el valor de una sube, el valor de la otra también, y además con la misma intensidad (+1).
