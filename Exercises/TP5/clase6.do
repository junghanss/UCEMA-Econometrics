clear all
cd  "C:\Users\JUAN\Google Drive\Universidad\UCEMA\Econometria\TP\TP5"
set more off
capture log close
log using "clase6.log", replace
use "Mortalidad_Infantil.dta"
*Modelo 1
reg MI PBI TAF
*Modelo 2
reg MI PBI
/*Si bien son dos modelos con test de significancia aprobados;
en el modelo 2 incurrimos en un error de variable omitida, que nos disminuye el R2, sesga los estimadores y */
reg MI PBI TAF
scalar B2 = _b[TAF]
reg TAF PBI
scalar s1 = _b[PBI]
scalar sesgo = B2*s1
di sesgo  /*Sesgo en la variable PBI: es la resta entre 0.0025622 - 0.005466*/
*Obtencion de beta insesgado y porcentaje explicado por la variable PBI
reg PBI TAF /*Primero regresamos la variable contra TODAS las otras explicativas*/
predict u, r
reg MI u /*Obtenemos beta insesgado (el PBI sin el efecto de las otras variables) y 0,0381 (R2) es el % explicado de la variable explicada sobre MI*/
/*Test de Ramsey RESET es para omision de variables, relevancia de la formas funcional (si es la correcta, es una no-linealidad, etc), o para heterocedasticidad */
reg MI PBI
estat ovtest /*Test de Ramsey: Rechazamos hipotesis nula... si tiene variables omitidas*/
reg MI PBI TAF
estat ovtest /*Test de Ramsey: NO podemos rechazar Ho, porque no tiene variables omitidas*/
*****TP 7
*Nuevas formas de introducir datos:
clear all
set obs 8 /*Seteamos un numero de observaciones*/
gen ahorro = 3200 in 1  /*Generamos una variable y le asignamos un valor segun cada observacion */
replace ahorro = 3500 in 2
replace ahorro = 4200 in 3
replace ahorro = 3900 in 4
replace ahorro = 4500 in 5
replace ahorro = 4400 in 6
replace ahorro = 5000 in 7
replace ahorro = 4700 in 8

generate ingreso = 10800 in 1
replace ingreso = 13300 in 2
replace ingreso = 12500 in 3
replace ingreso = 13200 in 4 
replace ingreso = 14000 in 5
replace ingreso = 15200 in 6 
replace ingreso = 15600 in 7
replace ingreso = 15500 in 8
save "ejercicio1_ejemplo.dta", replace
*brow /*La corremos y mostramos*/

*Prediccion de ahorro promedio
reg ahorro ingreso
predict A, xb /*las transformaciones lineales de las observaciones*/
predict D, stdp /**/
gen BI /*Banda Inferior*/ = A-D
gen BS /*Banda Superior*/ = A+D
*twoway (line A ingreso)(line BS ingreso)(line BI ingreso)(scatter ahorro ingreso) /*
Otra forma de escribir lo anterior podría ser line A ingreso || line BS ingreso || etc */

*Prediccion de un ingreso 16000
gen I = ingreso - 16000
reg ahorro I
/*La constante nos representa el ahorro que generara la persona que tenga un ingreso de 16.000*/
scalar Prediccion = _b[_cons]
scalar LI /*Limite Inferior*/ = Prediccion - _se[_cons]
scalar LS /*Limite Superior*/ = Prediccion + _se[_cons]
di "Prediccion de ahorro promedio para personas con ingreso 16k		" Prediccion
di "Limite Inferior 		" LI
di "Limite Superior			" LS
reg ahorro ingreso

mfx compute, at(ingreso=16000) /*otra forma alternativa de predecir*/
set obs 15 /*ampliamos la cantidad de observaciones para introducir mas*/
replace ingreso=16000 in 9
replace ingreso= 8000 in 10
replace ingreso=11400 in 11
replace ingreso=12800 in 12
replace ingreso=13600 in 13
replace ingreso=14200 in 14
replace ingreso=20000 in 15
*brow
reg ahorro ingreso 
predict Ah, xb /*prediccion lineal de ahorro-ingreso*/
predict Sah, stdp
gen LIA /*Limite Inferior Ahorro*/ = Ah - Sah
gen LSA /*Limite Superior Ahorro*/ = Ah + Sah
list ingreso LIA Ah LSA in 9/15 /*Lo listamos solo para las nuevas observaciones*/
**Observar la prediccion para una observacion en particular:
reg ahorro ingreso
scalar dsm = e(rmse) /*rmse = raiz cuadrada de la suma de los errores square del modelo*/
gen LIAo = LIA-dsm
gen LSAo = LSA+dsm
list ingreso LIAo LIA Ah LSA LSAo in 9/15
/*En el cuadro incorporamos la prediccion sobre el promedio comparado con una prediccion individual
Ejemplo, generalmente una persona con ingreso 16000 tendra un intervalo de ahorro 4680<4883<5086
Ahora bien, una persona CUALQUIERA (no del modelo) ahorrara entre 4352 < mean(4680<4883<5086) < 5414
*/
log close




