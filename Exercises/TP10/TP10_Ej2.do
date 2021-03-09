clear all
set more off
cd "C:\Users\JUAN\Google Drive\Universidad\UCEMA\Econometria\TP\TP10"
log using "TP10_Ej2.log", replace

use "DELITOS.dta"
gen lngasto_05 = ln(gasto_05)
reg lndelito_05 desemp lngasto_05
reg lndelito_05 desemp lngasto_05 lndelito_03
corr lndelito_05 lngasto_05
corr lndelito_03 lngasto_05

reg lndelito_05 desemp lngasto_05, r
reg lndelito_05 desemp lngasto_05 lndelito_03,r 


capture log close
