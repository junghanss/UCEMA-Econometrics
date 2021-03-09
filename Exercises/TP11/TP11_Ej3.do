clear all
set more off
cd "C:\Users\JUAN\Google Drive\Universidad\UCEMA\Econometria\TP\TP11"
use "CARD.dta"
capture log close
log using "TP11_Ej3.log", replace

reg l_salario educ exper raza capital sur

  
ivregress 2sls l_salario exper raza capital sur (educ=cercania4),first
corr cercania4 educ, covariance 
