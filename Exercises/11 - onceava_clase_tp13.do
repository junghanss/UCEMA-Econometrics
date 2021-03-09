clear all
cd "C:\Users\JUAN\Google Drive\Universidad\UCEMA\Econometria\TP\TP13"
set more off
use "Ejercicio1.dta"
tsset time /*Seteamos la variable que nos "marca" el tiempo: time. Anual, cambia por años*/
*scatter cnd time /*Vemos que es una variable con tendencia creciente*/
*scatter yd time
*scatter pob time
*scatter css time
*scatter y time
*scatter c time

/*Serie estacionaria: TENDENCIA. cuando la media no es constante, va cambiando a lo largo del tiempo*/

reg cnd yd pob /*Modelo estatico*/
reg cnd yd pob tiempo /*Modelo dinamico
Vemos igual que el sesgo por no incluir tiempo era chiquito..*/

reg cnd pob /*Modelo estatico 
La poblacion tiene un peso significativo sobre el cnd ingreso nacional, pero no es verdad, ya que esta captando la tendencia del paso del tiempo*/
reg cnd pob tiempo /*Modelo dinamico
La poblacion NO es significativa, lo que si pasa a ser significativo es la variable TIEMPO... es decir, el tiempo es lo que nos hace */

gen tiempo2 =  tiempo^2
reg cnd pob tiempo tiempo2
*browse tiempo tiempo2 /*para ver que onda como la tendencia se incrementa*/

gen ltiempo = log(tiempo)
reg cnd pob ltiempo

gen exp_tiempo = exp(tiempo)
reg cnd pob exp_tiempo

**Como desestacionalizar una serie
*Primero desestacionalizamos todas las variables
reg cnd tiempo
predict cndST, r 	/*predecimos el valor lineal SIN TIEMPO de cada variable*/
reg yd tiempo
predict ydST, r
reg pob tiempo
predict pobST, r 	
reg cndST ydST pobST
*Lo podemos comparar con el modelo sin desestacionalizar pero regresada con tiempo
*Seria un modelo estatico sin considera el tiempo

list css L2.css /*nos rezagó dos periodos, el metodo mas usual */
list css F2.css /*adelantamos dos periodos. Sirve para cuando trabajas con modelos con expectativas, etc.*/
list css D2.css /* [css(t)-css(t-1)]-[css(t-1)-css(t-2)] */
list css S2.css /* css(t)-css(t-2) */

clear all
set more off
use "Ejercicio3.dta"
drop year /*la borramos solo porque la vamos a crear de otra manera*/
tab time
gen year = substr(time,1,4) /*VER CLASE DE VUELTA MINUTO 12:27*/
destring year, replace
gen time2=_n
tsset time2 /*seteamos la variable tiempo*/
scatter lm year
*scatter lyr year
*scatter ibo year
*scatter ib year

gen trimestre = substr(time,5,2) /*La variable time tiene los 4 primeros valores el nro del año, luego el 5to y 6to valor es la Q y nro cuatrimestre. Le pedimos que sustraiga los 4 valores de la izquierda a la derecha*/
tab trimestre, gen(T)
reg lm lyr ibo ib T2 T3 T4 /*vemos las estacionalidades*/
reg ibo T2 T3 T4
predict iboE, xb /*ibo estacional*/
gen iboD=ibo-iboE /*similar a guardar el ibo de los errores, para sacarle la estacionalidad*/
reg lyr T2 T3 T4
predict lyrD, r

gen lm_1 = L1.lm
gen lm_2 = L2.lm
gen lm_3 = L3.lm
gen lm_4 = L4.lm
gen lm_5 = L5.lm

br time lm lm_1-lm_5

*Modelo Autoregresivo
reg lm lm_1-lm_5 /*La regresamos contra ella misma rezagada
vemos que el primero es significativo pero los otros no. Si queres probar el rezago de -5 periodos SI O SI tenes que pasar por los siguientes (-1,-2,-3,-4)*/

clear all
use "FERTIL3.DTA"
*Modelo de rezagos distribuidos:
tsset t
reg gfr pe_1 pe_2 pe_3 pe_4 pill ww2
di "multiplicador de impacto de corto plazo   " _b[pe]
di "multiplicador de impacto de largo plazo   " _b[pe]+_b[pe1]+_b[pe2]+_b[pe3]+_b[pe4]
*o = s0+s1+s2+s3+s4
*yt= b0 + o*pe + s1*(pe1-pe) + s2*(pe2-pe1) + s3*(pe3-pe2) + s4*(pe4-pe3) ... modelo en diferencias 

reg gfr S1.pe S2.pe S3.pe S4.pe pill ww2
di "multiplicador de impacto de corto plazo  " _b[pe]+_b[S1.pe]+_b[S2.pe]+_b[S3.pe]+_b[S4.pe]
di "multiplicador de impacto de largo plazo  " _b[pe]

**Test de Chow
clear all
set more off
cd "C:\Users\JUAN\Google Drive\Universidad\UCEMA\Econometria\TP\TP12"
use "Wage.dta", clear
gen t = _n
tsset t
gen Dprice = S1.price 
gen Dwages = S1.wages
reg Dwages Dprice /* modelo general */
scalar SCEg = e(mss)
scalar N=e(N)
*queremos ver si hay un cambio estructural en la observacion 150
reg Dwages Dprice if t>=150
scalar SCE1=e(mss)
reg Dwages Dprice if t<150
scalar SCE12=e(mss)
scalar FChow = (SCEg-SCE1-SCE2)/(SCE1+SCE2)*(N-1-2)/(2+1) /*GL: Varis explicativas 1, segmentos 2, */
di Ftail((2+1), (N-1-2-2), FChow)
/*H0 = los betas son iguales y no hay cambio estructural. Si rechazamos H0 hay un camboi estructural, es decir,
previo a la observacion 150 el modelo se comportaba de una manera y luego de otra distinta. 
Rechazamos H0 en favor de que hay un cambio estructural y deberiamos correr 2 modelos para explicar mejor */

clear all
set more off
cd "C:\Users\JUAN\Google Drive\Universidad\UCEMA\Econometria\TP\TP14"
use "TRAFICO.dta"
tsset tiempo
*scatter ley_cint tiempo /*A partir del año 60 vemos que sale la ley */
*scatter ley_vel tiempo /*Cambio a partir del 79/80aprox - Este cambio nos puede generar algun problema en las series*/
reg l_totacc tiempo feb mar abr may jun jul ago sep oct nov dic
/*Tal vez tenemos variables omitidas como pueden ser los fines de semana, el desempleo, etc.*/
reg l_totacc tiempo feb mar abr may jun jul ago sep oct nov dic finde desem ley_vel ley_cint
/*Los fines de semana NO son significativos, pareciera que la ley de velocidad disminuyo acc y la de cintuores si... a simple vista descriptivamente
Analisis descriptivo: */
*scatter prcfat tiempo /*porcentaje de accidentes fatales y tiempo. A simple vista pareciera que hay una reduccion*/
sum prcfat, detail
*AUTOCORRELACION
reg prcfat tiempo feb mar abr may jun jul ago sep oct nov dic finde desem ley_vel ley_cint
/*Como el supuesto GM requiere que no haya correlacion serial, entonces tenemos estimadores sesgados para la varianza 
mientras los datos sean iid podemos seguir usando el R^2, pero si ya la correlacion es muy fuerte tampoco podremos usar la medida R^2. Aunq la inferencia general no nos sirve de nada
Chequeamos entonces si hay auto-correlacion*/
predict u,r
*scatter u tiempo
tsline u
tsline u if e(sample)==1,yline(0)
*scatter u L1.u /*tiramos un grafico para ver que forma puede tener*/
*Test Autocorrelacion
reg u L1.u, nocons /*no tiene que tener constante. Vemos el p-valor para el test t para ver si rechazamos o no H0
Si rechazamos H0 (p<0.05) HAY autocorrelacion. El beta ese sería el rho*/ 
scalar rho = _b[L1.u]
*Contraste de Durbin-Wattson
gen DU2 = (u-L1.u)^2
gen U2 = u^2
sum DU2, detail
scalar N = r(sum) /*numerador, r(sum) le pedimos la suma de todas las observaciones*/
sum U2, detail
scalar U = r(sum)
scalar DW = N/U
di DW /*El nro tendria que estar cerca de 2 para decir que no hay autocorrelacion, como está alejado de 2 podemos sospechar de autocorr*/

reg prcfat tiempo feb mar abr may jun jul ago sep oct nov dic finde desem ley_vel ley_cint
estat dwatson

/*comparacion entre contraste DW y rho*/
display 2*(1-rho)

reg u L1.u tiempo feb mar abr may jun jul ago sep oct nov dic finde desem ley_vel ley_cint, noconstant
/* Contraste de Autocorrelacion AR(5) */
reg u L1.u L2.u L3.u L4.u L5.u /*no miramos significativdad individual, sino LA GLOBAL. VEMOS QUE PARA 0.13 NO RECHAZA H0, porque es un AR(1), no un AR(5)*/

/*Soluciones a la autocorrelacion

1) Hacer un modelo diferente que estar dado por lo siguiente:
[t(t) - rho*y(t-1) = (1-rho)*B0 + B1*[X(t)-rho*X(t-1)] + [u(t)-rho*u(t-1)]
Para esto necesitamos si o si conocer rho, sino tendremos que usar un metodo que la aproxime 
--> MCGF para AR(1)		

Cochrane-Orcutt (C-O)
Prais-Winsten (P-W) 		*/

prais prcfat tiempo feb mar abr may jun jul ago sep oct nov dic finde desem ley_vel ley_cint, corc
prais prcfat tiempo feb mar abr may jun jul ago sep oct nov dic finde desem ley_vel ley_cint

/*NO podemos comparar NINGUN R^2 de (C-O) versus (P-W).
Si las estimaciones son similares (las de MCGF) a las de MCO, entonces usaremos MCGF por dar estimadores mas eficientes
y por ser los estimadores t y F asintoticamente validos
Pero si los coeficientes NO fueran similares, deberemos descartar MCGF porque las Xt de un periodo y las de Xt periodo rezagado se relacionan entre ellas y genera inconsistencia en el modelo
*/




