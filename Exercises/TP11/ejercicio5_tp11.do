clear all
cd "C:\Users\JUAN\Google Drive\Universidad\UCEMA\Econometria\TP\TP11"
set more off
log using "ejercicio5_tp11.log", replace
*TRABAJO PRACTICO 11 - Ejercicio Nº5:
use "Vinos.dta"

*(A) Excluimos la variable M (eficiencia del management) para correr la siguiente regresión.
reg q k l
predict u, r
*Test de White:
estat hettes /*Detectamos heterocedasticidad, porque rechaza H0, ya que 0.0138<0.05*/
*Comprobación grafica:
*scatter u k 
*scatter u l
/*Podemos notar cierta variabilidad en los residuales para los valores que toman las variables independientes, por lo que intuitivamente inferiríamos que por la forma hay heteroc.*/
*Test de Breusch-Pagan:
gen u2 = u^2
reg u2 k l 
scalar bp = e(N)*e(r2)
di "Estadistico de prueba    "bp
di "Valor critico     " invchi2tail(e(df_r), 0.05)

/*(B)
La principal consecuencia sobre los estimadores resulta en el SESGO que se genera por omitir una variable, a pesar de que esta es NO observable. */

*(C) Agregamos una variable proxy:
reg q k l exper
/* Si probamos otro test de White, detectamos aún presencia de heterocedasticidad, exper no nos sirve para resolverla.
En base a la salida de la regresión anterior, podemos inferir lo siguiente:
Por cada punto porcentual que se incrementa el insumo capital (K), manteniendo el resto constante, el Output (q) se incrementa en promedio 43 puntos porcentuales. Siendo el índice de insumo capital un variable significativa con un estádistico "t" de 3.73
Por cada punto porcentual que se incrementa el insumo trabajo (L), para el resto de variables constantes, el Output (q) se incrementa en promedio 23.91 puntos porcentuales,  siendo el índice de insumo laboral una variable significativa al 0.019 de valor p.
Por cada unidad que aumenta los años de experiencia (exper), ceteris paribus, el nivel de output (q) se ve afectado en promedio 14 puntos porcentuales positivamente.
En síntesis, como no cambian los estimadores, siguen siendo insesgados. Se comprueba de que al agregar años de experiencia (Exper), una variable que estaba en el termino de error, no afecta el sesgo de los coeficientes, ya que son completamente exógenas.
Para el caso de una PROXY esto es MUY importante, que no haya relacion entre k y l contra exper, por ejemplo. */


*(D) Método de mínimos cuadrados en dos etapas:
ivregress 2sls q k l (exper=age), first
/*Los errores estándar son 0.2145; 0.15; 0.117 y 2.64 respectivamente
La interpretación del coeficiente B3 es que por cada unidad adicional que se incrementa la variable independiente de años de experiencia, para el resto constante, el output aumenta 51 puntos porcentuales en promedio... siendo una variable significativa a un pvalor 0.017<0.05
Los requisitos para una instrumental son 2, que:
Vemos que en la primer regresion exper contra las otras, la unica significativa es age, o sea, que se comprueba la relacion entre exper/age, es buen instrumento.
*/
*[Estimacion del instrumento]
*q = b0 + b1*K + b2*L + b3*exper(age) + e      Lo que salio de la regresion anterior
*b3 = bs3/S3   ==> la division del b.age/b.exper (0.1661/0.5121)

*(E)
estat endogenous 
/*De la salida del test de Haussman podemos concluir la siguiente apreciación:
Para el estadistico chi2, debemos rechazar H0 ya que 0.0278<0.05
Para el estadistico F, debemos también rechazar H0 porque 0.313<0.05
Por ende, en síntesis, rechazamos la H0 de que la variable experiencia sea exogena, esto implica que estamos ante un caso de endogeneidad. 
SE JUSTIFICA A FAVOR DEL USO DE UNA VARIABLE INSTRUMENTAL 
despues de realizar el test de endogeneidad, por medoi del test de haussman, hallamos que se rechaza la H0 de que la vaaible exper sea exogena, para un level de significancia 0.05 dado que el pvalor es 0.0313
esto implica que la variable experiencia es una variable endogena y por ende, se recomienda el uso de una v intrumental para solucionar dicho problema*/


*(F): Computamos la predicción para los valores de experiencia 10/20/30, seteando el intervalo con un step de 10 unidades. El comando vsquish es para eliminar espacios blancos en la salida del test y que se compacte más la tabla.
margins, at(exper=(10(10)30)) vsquish          /*
Para la variable experiencia determinada en 10, tenemos un resultado en la variable explicativa de 7.647, con un intervalo de confianza al 95% de 5.858181; 9.436752
Para el caso que se fija la variable experiencia en 20, tenemos un resultado en la Y de 12.768, con un intervalo de confianza del 95% de 10.09244; 15.44453
Cuando fijamos, una vez más, la variable independiente experiencia con un valor de 30, obtenemos un resultado de la variable dependiente de 17.889, con un intervalo de confianza de 95% de 11.07223; 24.70678
*/

log close

