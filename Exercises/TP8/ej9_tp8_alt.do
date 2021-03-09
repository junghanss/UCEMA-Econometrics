clear all
cd "C:\Users\JUAN\Google Drive\Universidad\UCEMA\Econometria\TP\TP8"
use "Impacto.dta"
set more off
capture log close
log using "ej9_tp8_alt.log", replace

/*(A)/(B) Se propone el siguiente modelo para evaluar el impacto de la participacion en el curso sobre el salario, sin omitir variables:
(Salario) = B0 + B1*(educ) + B2(exper) + B3(edad) + B4(partic)*/
reg  salario partic /* Primero verificamos la relaci�n directa entre explicaci�n del salario ante la participacion */
plot salario partic /* Como complemento visual, para una primer inferencia intuitiva, se solicita un grafico de dispersion. 
En caso de ser necesario, podemos tambien programar browse para ver los valores de las observaciones en cada variable */

reg salario educ exper edad partic /* Estimamos el modelo propuesto por MCO y abrimos tambien la tabla con los efectos marginales de cada variable independiente */
mfx
/* A partir del modelo y los indicadores resultantes, podemos observar lo siguiente:
Coeficientes:
- Por cada aumento unitario de educaci�n, manteniendo el resto constante, el salario se incrementa en 132.50 unidades monetarias.
- Por cada incremento unitario en la variable 'exper', ceteris paribus, la variable explicada salario se ve afectada positivamente en 38 unidades monetarias.
- Por cada a�o que se suma a la variable edad, para el resto de variables fijas, el salario disminuye en 5.8 unidades monetarias.
- El coeficiente de la variable ficticia "Participacion", en referencia al programa de capacitaci�n, nos muestra que en el caso de las observaciones que s� participaron (=1) su salario aumenta en 487.6 unidades monetarias, para el resto de variables constantes.
Eso podemos interpretarlo en el grafico de la regresion como un desplazamiento superior por sobre la constante, para aquellas personas que tengan valor 1 en la variable cualitativa.
En conclusi�n, el impacto promedio sobre el salario es de aproximadamente casi unas 500 unidades monetarias, alrededor de 75% de lo que representa el intercepto en s� mismo. 

En relaci�n a un posible sesgo o un an�lisis m�s detallado de la variable participacion, si corremos un F-Test, tanto para la variable independiente sola, como para todas las variables explicativas, visualizaremos insignificancia conjunta: */
test educ exper edad partic
test partic, mtest

corr educ exper edad partic /*Verificamos tambi�n correlacion lineal entre las variables
A la salida de la regresion se puede verificar, adem�s, que todas las variables son significativas en forma individual, bajo el test 't'.

(C) Modificando la forma funcional del modelo a una semielasticidad del salario respecto las variables: */
gen lsalario = log(salario)
reg lsalario educ exper edad partic
mfx
/*Interpretacion de los coeficientes:
- Por cada incremento unitario en educaci�n, para el resto de variables independientes constantes, el salario se incrementa en un 5.97%
- Por cada incremento unitario en la variable exper, ceteris paribus, la variable explicada salario se incrementa en 2%
- Por cada a�o que aumenta de manera unitaria la variable edad, manteniendo el resto constante, el salario disminuye 1.4%
- La variable cualitativa de participacion nos muestra que por cada observaci�n que cumple con el requisito (=1), calculando la diferencia porcentual exacta:
100[exp(dummy)-1] su salario se incrementa en 26.3% m�s.

En t�rminos relativos, respecto las otras variables, el impacto de la participacion en el curso sigue siendo significativo a la hora de explicar el salario. */

capture log close
