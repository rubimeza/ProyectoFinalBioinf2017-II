## ProyectoFinalBioinf2017-II

## Avances 3

### Querido diario, hasta el momento he terminado prácticamente de hacer mi análsis, sólo faltan arreglar mis gráficas en R

| Actividades | Estado |
| ---------- | ---------- |
| 1. Descargar datos  | Listo   |
| 2. Descargar dependencias  | Listo   |
| 3. Instalar dependencias | Listo  |
| 4. Descargar dependencias  | Listo   |
| 5. Descargar repositorio de HybPiper | Listo  |
| 6. Descargar lista de genes de *Pinus taeda* | Listo|
| 7. Construir referencia a partir de genes de *Pinus taeda*  | Listo   |
| 8. Ensamblar a genoma de referencia  | Listo  |
| 9. Generar referencia de pinos piñoneros a partir del ensamble con 	el genoma de *Pinus taeda* | Listo  |
| 10. Recuperar lista de genes  | Listo  |
| 11. Recuperar y detectar parálogos | Listo   |
| 12. Recuperar supercontigs | Listo  |
| 13. Construir árbol filogenético con SVD quartets  | Listo   |
| 14. Editar árbol filogenético en R  | Listo   |
| 15. Graficar resultados en R  | Listo   |
| 16. [README](https://github.com/JR-Montes/ProyectoFinalBioinf2017-II/blob/master/README.md) | Listo |
| 17. Resumen y discusión | pendiente   |



A continucación se muestra toda la ruta de trabajo, avances, ejemplos y código.

### Ensamble a Genoma de Referencia con Hyb-Piper


### Introducción
El enriquecimiento basado en hibridación con RNA (“Hyb-seq”) es un método que permite generar juegos de datos de ADN para estudios filogenómicos. Originalmente fue empleado para enriquecer 1,900 genes codificantes (15,565 exones) en humanos (Gnirke et al. 2009). Casi inmediatamente fue adoptado para maíz (Fu et al. 2010). Una metodología generalizada que emplea Hyb-seq para estudios en la filogenómica de plantas fue descrito por Weitemier et al. (2014) y la plataforma “Hyb-Piper” para el procesamiento de los datos provenientes de Hyb-seq fue presentado por Johnson et al. (2016). En este repositoriO vamos a trabajar con lecturas pareadas de Illumina provenientes de reacciones Hyb-seq en una muestra diversa de especies del género Pinus, realizar una limpieza con base en puntuaciones PHRED, y ensamblar las secuencias mediante la plataforma HybPiper.


**Lecturas recomendadas**

-	[Hyb-Seq](http://www.bioone.org/doi/pdf/10.3732/apps.1400042)

-	[Hyb-Piper](https://github.com/mossmatters/HybPiper/wiki/Installation)


## Dependencias
Se descargaron los siguientes programas o dependencias necesarios para la *pipiline*

[Trimmomatic](https://github.com/timflutre/trimmomatic) Es un software para realizar el pre-procesamiento de los datos. 

[SPAdes](https://github.com/ablab/spades/releases) Es un ensamblador de genomas de organismos unicelulares y pruricelulares. 

[BWA](https://github.com/lh3/bwa) Es un paquete de software para el mapeo de secuencias de baja divergencia contra un gran genoma de referencia.

[SAMtools](https://github.com/samtools/samtools) Es un formato genérico para almacenar grandes alineaciones de secuencias de nucleótidos. SAM pretende ser un formato que:

[Java](https://java.com/es/download/mac_download.jsp) Es un lenguaje de programación y una plataforma informática necesaria para correr algunos programas. En este casi *Trimmomatic* 

[Exonerate](https://github.com/nathanweeks/exonerate) Es una herramienta genérica para la comparación de secuencias *pairwise* que permite alinear secuencias usando muchos modelos de alineación, ya sea una programación dinámica exhaustiva o una variedad de heurísticas.

**NOTA**: Las dependencias de SPAdes, BWA, SAMtools y Exonerate se encuentran compiladas en un `script` que funciona como contenedor y se encuentra en el repositorio de HybPiper. Sólo es necesario clonar todo el repositorio de con las siguiente línea de comandos:

`git clone https://github.com/mossmatters/HybPiper.git`

![Github](https://github.com/JR-Montes/ProyectoFinalBioinf2017-II/blob/master/Imagen_Hybpiper.jpeg)

Se clonó el repositorio de HybPiper. Todas las herramientas bioinformáticas se instalaron con [homebrew](https://github.com/mossmatters/HybPiper/blob/master/brew.sh) o [linuxbrew](https://github.com/mossmatters/HybPiper/blob/master/linuxbrew.sh).

Para obtener instrucciones completas de instalación, se puede consultar en el siguiente enlace [wiki](https://github.com/mossmatters/HybPiper/wiki/Installation)



## Pipeline pre-procesamiento

### 1. Descargar secuencias Illumina

Descargué las secuencias de Illumina con el siguiente script:

`gsl_wget_download.sh`

Se utilizó la siguiente línea de comandos en la terminal para descargar las secuencias de Illumina desde el directorio de trabajo. 

`bash gsl_wget_download.sh GP0304_files.txt`


### 2. Cambiar nombre a las secuencias
Diseñé el script `renamed.sh` para adicionar el nombre de la especie en acrónimo a las secuencias de Illumina 1 y 2. Es este caso cada número corresponde al _forward_ y _reverse_ . Utiliza el comando `mv`para cambiar el nombre. 
A continuación se muestra un ejemplo del contenido del script. En el ejemplo se puede observar que el nombre de la secuencia ahora cuenta con el acrómino de la especie más el número de colecta. En este caso la muestra es cemb04s1 que corresponde con _Pinus cembroides_ muestra 04 semilla 1.

```
mv CACGCANXX_s6_2_MY715-MY527_SL217966.fastq.gz cemd04S1_CACGCANXX_s6_2_MY715-MY527_SL217966.fastq.gz   
```
```
mv CACGCANXX_s6_1_MY715-MY527_SL217966.fastq.gz cemd04S1_CACGCANXX_s6_2_MY715-MY527_SL217966.fastq.gz
```

Corrí el script `renamed.sh` en la terminal desde el directorio de trabajo dónde viven las secuencias. Teclea la siguiente línea de comando:

`bash renamed.sh`


### 3. Pre-procesamieto de lecturas de Illumina para procesamiento en HybPiper.

Utilicé la línea de comandos de [Trimmomatic](http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/TrimmomaticManual_V0.32.pdf) para cortar las secuencias de mala calidad y quitar los adaptadores. Las secuencias se encuentran en formato fastq comprimidos en zip. Se tiene que utilizar el modo _paired end_ de trimmomatic para que realizar el proceso en las secuencias 1 y 2. 
A continuación se muestra la sintaxis de la línea de comandos que se utilica para el pre-procesamiento:

```
java -jar [path to trimmomatic jar] PE [input 1] [input 2] [paired output1] [unpaired output1] [paired output2] [unpaired output2] LEADING:3 TRAILING:3 SLIDINGWINDOW:4:20 MINLEN:30
```

Ejemplo de la línea de comandos para pre-procesar de secuencias. La especie es _Pinus bungeana_, muestra 03 y semilla 3, acrónimo bung03s3A


```
java -jar /usr/local/bin/Trimmomatic-0.36/trimmomatic-0.36.jar PE bung03s3A_CACGCANXX_S6_1_MY720-MY544_SL217958.fastq.gz bung03s3A_CACGCANXX_S6_2_MY720-MY544_SL217958.fastq.gz bung03s3A_R1_paired.fastq.gz bung03s3A_R1_unpaired.fastq.gz bung03s3A_R2_paired.fastq.gz bung03s3A_R2_unpaired.fastq.gz LEADING:3 TRAILING:3 SLIDINGWINDOW:4:20 MINLEN:30
```


**NOTA** Incluí el enlace de Trimmomatic para poder revisar los parámetros.


### 4. Descomprimir secuencias en formato fastq.gz.
Se utilizó el script `Decompress.sh` para descomprimir todas las secuencias, tanto forward como reverse, que se encuentren en formato fastq.gz. 

`bash Decompress.sh`

## Pipeline procesamiento

### 1. Agregar SPAdes a tu path o ruta de trabajo.

Comprobé la configuración de ruta antes de comenzar, tecleado:

`echo $PATH`

Devolvió los siguiente: 

`/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/lib/cd-hit`

 Para conocer el nombre actual de SPAdes, se debe teclear:

`ls /usr/local/bin/SPA*`

En este caso, SPAdes se encuentraba en un directorio llamado SPAdes-3.6.2.

`export PATH=$PATH:/usr/local/bin/SPAdes-3.6.2`

### 2. Ensamblar secuencias a genoma de referencia.

Para realizar el ensamble necesité:

1. Genoma de referencia 	
 -	`test_target_996_loci.fasta`
2. Archivo.txt del nombre de las secuencias (para ensamblar más de una muestra)
- `namelist.txt`
3. Script `reads_first.py`


### A. `reads_first.py`

Para ensamblar las lecturas se utilizó el script `reads_first.py` de la plataforma de Hyb-piper. Este script es un contenedor de varios scripts con dependencias, paquetes ejecutables de Python como: **SPAdes, Velvet, Exonerate, Cap3, BWA y SAMtools**.

Se utilizó el siguiente `for loop`:

```
while read name; 
do ../reads_first.py -b test_target_996_loci.fasta -r "$name*.fastq" --prefix $name --bwa 
done < namelist.txt
```
Una vez que terminó de correr el ensamble de secuencias, recuperé una carpeta para cada muestra como se muestra en la siguiente imagen:

![Results assambly](https://github.com/JR-Montes/ProyectoFinalBioinf2017-II/blob/master/Results%20assambly.jpeg)


### B. `get seq lengths.py`

Este script se utiliza para resumir todas las longitudes de las lecturas y genera un archivo .txt con todas las muestras. El script imprime una tabla en stdout. La primera línea contiene los nombres de genes. La segunda línea contiene la longitud de las secuencias de referencia. También imprime un WARNING que indica que la longitud de la secuencia es más larga que el 50% respecto a la referencia. Ejemplo del resultado:
 

![alineamientos](https://github.com/JR-Montes/ProyectoFinalBioinf2017-II/blob/master/Seq_length_alingment.jpeg)


### C. `retrieve_sequences.py`

Este script se utilizó para resumir todas las longitudes de lectura y generar un archivo con una secuencia por muestra en formato FNA para nucleótidos. El script utiliza los datos generados por el script `reads_first.py`. El script está diseñado para recuperar y arreglar todas las secuencias para cada gen en alineamientos ya sea de nucleótidos, aminoácidos, intrones y supercontigs. Para ello se debe indicar el argumento del cual necesitamos recuperar la información.


### D. `paralog_investigator.py`

Este script extraje los resultados exonerados para todos los parálogos completos que compiten y los deposita en un nuevo directorio dentro del directorio de resultados.Los parálogos pueden ser recopilados usando otro script llamado `paralog_retriever.py´ para alinear y construir árboles génicos.

se corrió el siguiente loop. 


```
while read i
do
echo $i
python ../paralog_investigator.py $i
done < namelist.txt
```

El resultado se ve así:

![parálogos](https://github.com/JR-Montes/ProyectoFinalBioinf2017-II/blob/master/Paralogs.jpeg)

### E. `paralog_retriever.py`

Con este script recuperé todos los parálogos completos que se registraron o identificaron de cada uno de los genes por muestra.


Se escribió el siguiente loop.

```
while read i
do
echo $i
python ../intronerate.py --prefix $i
done < namelist.txt
```

**¿Cómo detecta HybPiper parálogos?**

Si el ensamblador SPAdes genera múltiples contigs que contienen secuencias de codificación con un 75% de la longitud de la proteína de referencia, HybPiper imprimirá una advertencia para ese gen. También imprimirá los nombres de los contigs  y una lista de todos los genes con advertencias de parálogos.


### F. Estadísticos

Se utilizaron los siguientes scripts para obtener información estadística y de otro tipo.

### `hybpiper_stats.py`

Este script genera información sobre algunos puntos relevantes sobre el proceso de ensamblaje como:

```
•	Número de lecturas
•	Número de reads ensambladas a la referencia
•	Percentaje lecturas ensambladas a la referencia
•	Número de genes con lecturas
•	Número de genes con contigs
•	Número de genes con secuencias
•	Número de genes con secuencias > 25% de la longitud de la referencia
•	Número de genes con secuencias > 50% de la longitud de la referencia

•	Número de genes con secuencias > 75% de la longitud de la referencia

•	Número de genes con secuencias > 150% de la longitud de la referencia
•	Número de genes con alerta de parálogos
```

Se utilizó la siguiente línea de comando para obtener el resumen de los estadísticos:

`../hybpiper_stats.py test_target_996_loci.fasta namelist.txt > test_stats_txt`


Al final debes obtuve un archivo.txt como el siguiente:

![stats](https://github.com/JR-Montes/ProyectoFinalBioinf2017-II/blob/master/stats.jpeg)


### stats.R

Diseñé este script de R ejecuta rel archivo.txt del resultado de los estadístcos y construí una gráfica de barras con el resultado del número de lecturas por muestra. Sólo se cargué el archivo y ejecuté la función. 

![barplot](https://github.com/JR-Montes/ProyectoFinalBioinf2017-II/blob/master/stats_number_read.jpeg)


### heatmap.R

Este script de R utiliza las paqueterías  de `gplots`y `heatmap.plus` para construir un mapa de calor del porcentaje de cobertura recuperada del péptido. El script ejecuta el archivo de salida del resultado de script  `hybpiper_stats.py` en formato.txt. Obtuve lo siguiente:

![heatmap](https://github.com/JR-Montes/ProyectoFinalBioinf2017-II/blob/master/heat_map_stats.jpeg)



### tree.R

Finalmente diseñé este script de R que utiliza la paquetería de `phytools` y `ape`para editar un árbol filogenético en formato *.nexus* o *.phylip*. Cargué el árbol y ejecuté la función. Antes de ejecutar el archivo instalé las paqueterías y cargue las librerías. Obtuve lo siguiente:

![tree](https://github.com/JR-Montes/ProyectoFinalBioinf2017-II/blob/master/tree_phylogenetic.jpeg) 




## Referencias

Bolger, A.M., M. Lohse, and B. Usadel. 2014. Trimmomatic: a flexible trimmer for Illumina sequence data. Bioinformatics [30: 2114–2120](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4103590/pdf/btu170.pdf).

Fu, Y., N.M. Springer, D.J. Gerhardt, K. Ying, C.T. Yeh, W. Wu, R. Swanson-Wagner, et al. 2010. Repeat subtraction-mediated sequence capture from a complex genome. The Plant Journal  [62:898–909](http://onlinelibrary.wiley.com/doi/10.1111/j.1365-313X.2010.04196.x/epdf).

Gnirke, A., A. Melnikov, J. Maguire, P. Rogov, E.M. LeProust, W. Brockman, T. Fennell, et al. 2009. Solution hybrid selection with ultra-long oligonucleotides for massively parallel targeted sequencing. Nature Biotechnology [27:182–9](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2663421/pdf/nihms86158.pdf).

Johnson, M.G., E.M. Gardner, Y. Liu, R. Medina, B. Goffinet, A.J. Shaw, N.J.C. Zerega, and N.J. Wickett. 2016. HybPiper: Extracting coding sequence and introns for phylogenetics from high-throughput sequencing reads using target enrichment. Applications in Plant Sciences [4:1600016](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4948903/pdf/apps.1600016.pdf).

Weitemier, K., S.C.K. Straub, R.C. Cronn, M. Fishbein, R. Schmickl, A. McDonnell, and A. Liston. 2014. Hyb-Seq: Combining target enrichment and genome skimming for plant phylogenomics. Applications in Plant Sciences [2:1400042](http://www.bioone.org/doi/pdf/10.3732/apps.1400042).





