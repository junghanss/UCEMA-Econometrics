clear all
cd "C:\Users\JUAN\Google Drive\Universidad\UCEMA\Econometria\TP\TP8"
use "Impacto.dta"
set more off
log using "ej9_tp8.log", replace
/*(A)/(B) Se propone el siguiente modelo para evaluar el impacto de la participacion en el curso sobre el salario, sin omitir variables:
(Salario) = B0 + B1*(educ) + B2(exper) + B3(edad) + B4(partic)*/
reg  salario educ exper edad partic
corr educ exper edad partic /*Verificamos correlacion lineal entre las variables*/
mfx /*Extraemos los detalles de los efectos marginales de las variables independientes
Por cada incremento en una unidad (no especificada) de la variable participaci�n, el salario aumenta 487,67 unidades monetarias (ejemplo: dolares).

Como podemos observar que la variable participacion posee un coeficiente bastante elevado en proporcion a los otros, 
para poder analizar su impacto real, procederemos a estandarizar las variables: */
egen float zsalario = std(salario), mean(0) std(1)
egen float zeduc = std(educ), mean(0) std(1)
egen float zexper = std(exper), mean(0) std(1)
egen float zedad = std(edad), mean(0) std(1)
egen float zpartic = std(partic), mean(0) std(1)

reg zsalario zeduc zexper zedad zpartic
mfx 
/*Ahora podemos visualizar que, en relaci�n a los demas estimadores, la participacion es la segunda variable mas importante (y no la primera, a diferencia del modelo anterior) en terminos de explicacion de la variable Y.
Si la participacion aumenta en una desviacion estandar, ceteris paribus, entonces el salario se modifica en 0.38 desviaciones estandar. La variable m�s importante es educaci�n
El impacto relativo de la participacion es relevante.

(C) Modificando la forma funcional del modelo a una semielasticidad del salario respecto las variables: */
gen lsalario = log(zsalario)
reg lsalario zeduc zexper zedad zpartic
/*Interpretacion de los coeficientes:
- Por cada incremento en una DE (Desviacion Estandar) de educacion, manteniendo el resto constante, el salario se incrementa en 0,82% DE
- Por cada incremento en una DE de expertise, con el resto de variables fijas, el salario disminuye 0.026% DE
- Por cada incremento en una DE de la variable edad, ceteris paribus, el salario aumenta 0.011% desviaciones estandar
- Por cada incremento en una DE de la participacion, manteniendo el resto constante, el salario se incrementa 0.43% DE, siendo esta variable la segunda en explicar m�s al salario.
El impacto sigue siendo igual de importante en t�rminos porcentuales (en desviaciones estandar) del salario.

(D) Para el caso en el que se incluyeran variables cualitativas al modelo, para poder explicar la variable salario, podemos concluir lo siguiente:
Debido a que el impacto relativo de la participaci�n es alta, luego de la educaci�n, podr�amos inferir intuitivamente que no es un programa completamente abierto, 
ya que esto impactar�a positivamente en la masa salarial de la empresa generando el inter�s de todos los trabajadores para participar (poco coherente).

Considerando tambi�n que la CORRELACI�N entre la variable participaci�n y educaci�n es casi nula (0.0376). SUPONIENDO que hay cierta relacion entre educacion y habilidades no observadas,
podemos concluir tambi�n que no necesariamente son aquellos trabajadores con menos capacidades observadas los m�s elegidos.

En este lineamiento, es probable considerar que la participaci�n en el programa es resultado de un sorteo, aleatoriamente de las capacidades no observadas, educacion, edad, etc.*/

capture log close
