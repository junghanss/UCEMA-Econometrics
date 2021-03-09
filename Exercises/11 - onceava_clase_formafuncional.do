clear all
cd "C:\Users\JUAN\Google Drive\Universidad\UCEMA\Econometria\TP\TP10"
set more off
capture log close
use "omision_de_habilidad.dta"
**MALA especificacion funcional

*Test Reset = 
*Forma: Y = B0 + B1*X1 + S1*YP^2 + S2*YP^3 + U
*YP = B0+B*X

gen edu2 = edu^2
gen ledu = log(edu)
reg logw edu exp
/*Sospechamos que el logaritmo del salario está mal especificado, corremos el test de Ramsey (RESET)*/
ovtest 
/*En principio, NO rechaza la H0 a favor de que esté mal especificado, pensaríamos que la forma funcional es la correcta...
pero si ponemos el salario en niveles. */
gen w = exp(logw)
reg w edu exp
ovtest 
/*Seguimos sin rechazar la H0*/
reg w edu exp edu2
ovtest
/*Ahora si rechazamos la H0, es decir, que hay alguna nolinealidad demás en este modelo*/
reg logw edu exp edu2
ovtest
/*Sigue mal especificado, porque vuelve a rechazar H0.
Conclusión, cuando incluimos edu2, como termino cuadratico, pasó a estar mal especificado.
De todas maneras, la diferencia entre reg w edu2 y reg logw edu2 es que en el primer caso, edu2 es insignificativa, en el segundo edu2 es significativa.*/
*TEST DAVIDSON Y MCKINNON
gen lexp=log(exp)
reg logw edu exp
predict y, xb
reg logw ledu lexp y /*Le agregamos el término Y
Si el Y NO es significativo para explicar, quiere decir que la especificacion correcta es en logaritmos
si el y rechaza la H0, el modelo bueno es nivel-nivel (edu exper)*/

reg logw ledu lexp
predict ly, xb /*Prediccion lineal de log educacion y log experiencia*/

reg logw edu exp ly 

log close


