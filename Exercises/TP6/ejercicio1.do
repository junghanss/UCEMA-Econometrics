clear all
cd "C:\Users\JUAN\Google Drive\Universidad\UCEMA\Econometria\TP\TP6"
set more off
capture log close
****Ejercicio 1 (TP6):
import excel "ejercicio_nro1.xls", sheet(Hoja2) firstrow
reg Y X
gen c1Y = 2*Y
reg c1Y X
gen c2X = 3*X
reg Y c2X
reg c1Y c2X
gen c1Y2 = 2 + Y
reg c1Y2 X 
gen c2X2 = 3 + X
reg Y c2X2
gen logY = log(Y)
reg logY X
gen logc1Y = log(c1Y)
reg logc1Y X
gen logX = log(X)
reg Y logX
gen logc2X = log(c2X)
reg Y logc2X
/*Conclusiones:
(1) Cuando modificamos la variable explicada (Y) con el producto de una constante (k) y manteniendo el resto de variables fijas, podemos apreciar que los indicadores principales de la regresión lineal (R2, R2 ajustado y Test F) se mantuvieron iguales los resultados y los coeficientes (constante y pendiente) se incrementaron, para este caso que la constante (k) es positiva.
(2) Cuando modificamos la variable explicativa (X) con el producto de una constante (k) y manteniendo el resto de variables fijas, notamos que los indicadores principales de la regresión lineal (R2, R2 ajustado y Test F) se mantuvieron iguales los resultados y de los coeficientes solo sufrió una variación la pendiente, ya que la constante mantuvo apenas un cambio infinitesimal.
(3) Cuando modificamos ambas variables (explicada y explicativa) multiplicándolas por una constante (k), vemos que los principales indicadores de la regresión lineal se mantuvieron constantes pero que la constante y pendiente sufrieron cambios.
Resumiendo, se puede inferir que las medidas cualitativas del modelo, su porcentaje de ajuste de regresión y prueba de significancia, no se ven alteradas ante cambios nominales en las variables.

(4) Al perturbar la variable explicada (Y) con la suma de una constante (k) y manteniendo el resto de variables fijas, podemos notar que el único cambio yace en el coeficiente B0, es decir, la constante, porque la pendiente se mantuvo inalterada y los indicadores de relevancia de la regresión también.
(5) Al perturbar la variable explicativa (X) con la suma de una constante (k) y manteniendo el resto de variables inalteradas, podemos observar que nuevamente el único cambio yace en la constante (B0), con la diferencia de una tratarse de una perturbación más profunda, debido a que el cambio paso de ser positivo (un incremento en B0) a ser negativo, generando que este llegue a un nivel decreciente (-9.686268).
En síntesis, constatamos que una perturbación en Y afecta un poco a la constante y nada a la pendiente, pero una perturbación en X es capaz de afectar mucho a la constante, aunque nuevamente mantiene inalterada la pendiente.

(6-7) Cuando transformamos la funcionalidad del modelo a log-lin, representativo de una semielasticidad, podemos observar que aunque el logaritmo de la variable explicativa, incluya dentro de su argumento también el producto con una constante (k), el único cambio observado es en el coeficiente B0 que se altera, dado que B1 (pendiente) se mantuvo fija. Para con las medidas de la regresión podemos decir que también se mantuvieron inalteradas en comparación.
(8-9) Cuando transformamos la funcionalidad del modelo a lin-log, también representativo de una semielasticidad, concluimos que sucede lo mismo que en el caso anterior, es decir, que solo la pendiente (B1) se mantiene sin cambios y que la constante (B0) sufre perturbaciones significativas. La relevancia del modelo se mantiene intacta (F Test, R2, R2 Ajustado).

Podemos llegar a la conclusión de que los cambios nominales en las variables, dados a partir de un producto o cociente, solamente alteran, dependiendo el caso, la constante o pendiente, pero no el porcentaje de ajuste de las variables del modelo y su prueba de significancia conjunta. 



