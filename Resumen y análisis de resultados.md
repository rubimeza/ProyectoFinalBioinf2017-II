####  Proyecto Final Bio-informática 2017-II 

## Resumen y análisis de resultados

### Ensamble de datos de secuenciación masiva a partir del genoma de referencia de *Pinus taeda* L.

##### By José Ruben Montes Montiel
***

> **Introducción**
 
En este proyecto vamos a ensamblar lecturas pareadas de Illumina provenientes de reacciones [Hyb-Seq](http://www.bioone.org/doi/pdf/10.3732/apps.1400042) en una muestra diversa de especies del género *Pinus*, subgénero *Strobus*, subsecciones *Cembroides*, *Nelsoniae* y *Balfourianae* pertenecientes a la sección *Parrya*, y subsecciones *Krempfianae* y *Gerardianae* de la sección *Quinquenfoliae*. Dichas secuencias serán ensambladas con el genoma de referencia de *P. taeda*. Las secuencias ensambladas serán utilizadas para realizar análisis filogenéticos de pinos piñoneros y grupos hermanos. 
Primero se llevará acabo el pre-procesamiento de los datos con el programa Trimmomatic v 0.33 para realizar una limpieza de las secuencias con base en puntuaciones PHRED. Posteriormente, para ensamblar las secuencias necesitaremos descargar tanto la plataforma [Hyb-Piper](https://github.com/mossmatters/HybPiper/wiki/Installation) del repositorio de datos de github como los softwares y dependencias específicos para ensamblar, almacenar y alinear los datos. Los resultados fueron graficados en R studio v 1.044.

> **Objetivo**

Ensamblar las lecturas pareadas de Illumina provenientes de reacciones Hyb-Seq de especies del género *Pinus* sección *Parrya* y sección *Quinquenfoliae* a partir del genoma de referencias de *P. taeda*, utilizando la plataforma Hyb-Piper para realizar análisis filogenéticos.

> **Resultados**

**Ensamble**

El ensamble de novo se llevó a cabo con el ensamblador de genomas SPAdes v 3.6.2 (Bankevich et al., 2012). Para el ensamble de cada gen individualmente se usaron las lecturas mapeadas al genoma de referencia con el alineador BWA (Li y Durbin, 2009). Para el método BWA, todas las lecturas alineadas se clasificaron en cada directorio de genes utilizando un contenedor de Python, SAMtools (Li et al., 2009) que permite recuperar eficientemente todas las lecturas alineadas por locus. Tanto las dependencias SAMtools y BWA se encuentran en un script de Python llamado `reads_first.py`. 

Un total de 61 taxa fueron ensamblados utilizando como referencia el genoma de *Pinus taeda.* De los 61 taxa, 53 pertenecen a la subsección *Cembroides* y los 8 taxa restantes pertenecen a las subsecciones *Nelsoniae* y *Balfourianae* (*Parrya*) y subsecciones *Krempfianae* y *Gerardianae* (*Quinquenfoliae*). 
Una vez que terminó de correr el ensamble de las secuencias, los resultados se recuperan en una carpeta para cada muestra.

![Results assambly](https://github.com/JR-Montes/ProyectoFinalBioinf2017-II/blob/master/Results%20assambly.jpeg)

Al interior de cada carpeta se encuentra la lista de genes utilizados para realizar el ensamble de la referencia y varios archivos .txt con los resultados como el número de parálogos, número de intrones, genes con secuencias y el registro de las secuencias que no ensamblaron. En las carpetas que corresponden a cada gen se encuentran varios archivos .fasta y 2 carpetas. Una de las dos carpetas lleva el nombre de la especie en acrónimo y dentro de aquella carpeta se encuentran 7 archivos con los resultados de intronerar y exonerar.

![SPAdes](https://github.com/JR-Montes/ProyectoFinalBioinf2017-II/blob/master/results_spades.jpeg)

 
Filogenia



