clear all
cd "C:\Users\JUAN\Google Drive\Universidad\UCEMA\Econometria\TP\TP12"
use "Wage.dta"
set more off
log using "TP12_Ej1.log", replace

gen time = tm(1996-06) + _n-1
format time %tmCCYY-NN
*browse time /*Vemos que la observacion número 150 es igual al número 586 que asigna Stata*/
tsset time, monthly

list time wage price
*tsline wage, tline(2008-11)
*tsline price, tline(2008-11)  /*obs 150: donde supuestamente hubo un acontecimiento, podemos marcarlo con una linea*/
*tsline d.wage
*tsline d.price

gen dwage = d1.wage
gen dprice = d1.price

reg dwage dprice

scalar SCEg = e(mss)
scalar N=e(N)
*queremos ver si hay un cambio estructural en la observacion 150
reg dwage dprice if time>=586
scalar SCE1=e(mss)
reg dwage dprice if time<586
scalar SCE2=e(mss)
scalar FChow = (SCEg-SCE1-SCE2)/(SCE1+SCE2)*(N-1-2)/(2+1) /*GL: Varis explicativas 1, segmentos 2, */
di Ftail((2+1), (N-1-2-2), FChow)
/*H0 = los betas son iguales y no hay cambio estructural. Si rechazamos H0 hay un camboi estructural, es decir,
previo a la observacion 150 el modelo se comportaba de una manera y luego de otra distinta. 
Rechazamos H0 en favor de que hay un cambio estructural y deberiamos correr 2 modelos para explicar mejor */

capture log close
