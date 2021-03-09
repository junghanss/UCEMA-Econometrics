clear all
cd "C:\Users\JUAN\Google Drive\Universidad\UCEMA\Econometria\TP\TP9"
set more off
*log using "ejercicio5_tp9.log", replace
use "WAGE1.DTA" 
reg wage educ exper tenure
predict u, r
gen u2 = u^2
estat hettes

/*Punto (A): de manera intuitiva puede esperarse existencia de heterocedasticidad porque el salario suele verse variar mucho frente
a */

*Punto (B): Tests para probar heterocedasticidad
*scatter u educ
reg u2 educ exper tenure
scalar bp = e(N)*e(r2)
di "estadistico de prueba   " bp
di "valor critico   " invchi2tail(e(df_r), 0.05)

scalar F = (e(r2)/e(df_m) / (1-e(r2)) / e(df_r))
di F
di invFtail(e(df_m),e(df_r),0.05)

estat hettes

*Punto (C):
reg lwage educ exper tenure


*Punto (D):
gen lu2 = log(u2)
/*Generamos los terminos al cuadrado*/
gen educ2= educ^2
gen exper2 = exper^2
gen tenure2 = tenure^2

gen educ_exper = educ*exper
gen educ_tenure = educ*tenure
gen exper_tenure = exper*tenure

reg lu2 educ2 exper2 tenure2 educ_exper educ_tenure exper_tenure

predict g, xb
gen h = exp(g)
gen rh = h^(1/2)
*Corregimos:
gen hcons = 1/rh
gen hwage = wage/rh
gen heduc = educ/rh
gen hexper = exper/rh
gen htenure = tenure/rh
reg hwage hcons heduc hexper htenure hcons, noconst

reg wage educ exper tenure [aweight=1/rh]

*log close
