### Introducción


**Lecturas recomendadas**

-	[Hyb-Seq](http://www.bioone.org/doi/pdf/10.3732/apps.1400042)

-	[Hyb-Piper](https://github.com/mossmatters/HybPiper/wiki/Installation)


## Dependencias
Los siguientes programas o dependencias son necesarios para la *pipiline*

[Trimmomatic](https://github.com/timflutre/trimmomatic) Es un software para realizar el pre-procesamiento de los datos. 

[SPAdes](https://github.com/ablab/spades/releases) Es un ensamblador de genomas de organismos unicelulares y pruricelulares. 

[BWA](https://github.com/lh3/bwa) Es un paquete de software para el mapeo de secuencias de baja divergencia contra un gran genoma de referencia.

[SAMtools](https://github.com/samtools/samtools) Es un formato genérico para almacenar grandes alineaciones de secuencias de nucleótidos. SAM pretende ser un formato que:

[Java](https://java.com/es/download/mac_download.jsp) Es un lenguaje de programación y una plataforma informática necesaria para correr algunos programas. En este casi *Trimmomatic* 

[Exonerate](https://github.com/nathanweeks/exonerate) Es una herramienta genérica para la comparación de secuencias *pairwise* que permite alinear secuencias usando muchos modelos de alineación, ya sea una programación dinámica exhaustiva o una variedad de heurísticas.

**NOTA**: Las dependencias de SPAdes, BWA, SAMtools y Exonerate se encuentran compiladas en un `script` que funciona como contenedor y se encuentra en el repositorio de HybPiper. Sólo es necesario clonar todo el repositorio de con las siguiente línea de comandos:

`git clone https://github.com/mossmatters/HybPiper.git`

![Github](https://github.com/JR-Montes/ProyectoFinalBioinf2017-II/blob/master/Imagen_Hybpiper.jpeg)

Una vez que se ha clonado el repositorio de HybPiper en MacOSX y Linux. Todas las herramientas bioinformáticas se pueden instalar con [homebrew](https://github.com/mossmatters/HybPiper/blob/master/brew.sh) o [linuxbrew](https://github.com/mossmatters/HybPiper/blob/master/linuxbrew.sh).

Para obtener instrucciones completas de instalación, se puede consultar en el siguiente enlace [wiki](https://github.com/mossmatters/HybPiper/wiki/Installation)



## Pipeline pre-procesamiento

### 1. Descargar secuencias Illumina

Obtener el siguiente script para descargar las secuencias de Illumina:

`gsl_wget_download.sh`

Utilizar la siguiente línea de comandos en la terminal para descargar las secuencias de Illumina desde el directorio de trabajo. 

`bash gsl_wget_download.sh GP0304_files.txt`


### 2. Cambiar nombre a las secuencias
Descargar el script llamado [`Renamed.sh`](https://github.com/JR-Montes/ProyectoFinalBioinf2017-II)para adicionar el nombre de la especie en acrónimo a las secuencias de Illumina 1 y 2. Es este caso cada número corresponde al _forward_ y _reverse_ . Utiliza el comando `mv`para cambiar el nombre. 
A continuación se muestra un ejemplo del contenido del script. En el ejemplo se puede observar que el nombre de la secuencia ahora cuenta con el acrómino de la especie más el número de colecta. En este caso la muestra es cemb04s1 que corresponde con _Pinus cembroides_ muestra 04 semilla 1.

```
```
```

Corre el script `Renamed.sh` en la terminal desde el directorio de trabajo dónde viven las secuencias. Teclea la siguiente línea de comando:

`bash Renamed.sh`


### 3. Pre-procesamieto de lecturas de Illumina para procesamiento en HybPiper.

Utiliza la línea de comandos de [Trimmomatic](http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/TrimmomaticManual_V0.32.pdf) para cortar las secuencias de mala calidad y quitar los adaptadores. Las secuencias se encuentran en formato fastq comprimidos en zip. Se tiene que utilizar el modo _paired end_ de trimmomatic para que realizar el proceso en las secuencias 1 y 2. 
A continuación se muestra la sintaxis de la línea de comandos que se utilica para el pre-procesamiento:

```
java -jar [path to trimmomatic jar] PE [input 1] [input 2] [paired output1] [unpaired output1] [paired output2] [unpaired output2] LEADING:3 TRAILING:3 SLIDINGWINDOW:4:20 MINLEN:30
```

Ejemplo de la línea de comandos para pre-procesar de secuencias. La especie es _Pinus bungeana_, muestra 03 y semilla 3, acrónimo bung03s3A


```
```


**NOTA** Para conocer la razón de los parámetros de Trimmomatic has click en el enlace de arriba.

### 4. Descomprimir secuencias en formato fastq.gz.
Utiliza el script `Decompress.sh` para descomprimir todas las secuencias, tanto forward como reverse, que se encuentren en formato fastq.gz. Teclea:

`bash Decompress.sh`

## Pipeline procesamiento

### 1. Agregar SPAdes a tu path o ruta de trabajo.


`/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/lib/cd-hit`



### 2. Ensamblar secuencias a genoma de referencia.

Para realizar el ensamble necesitas:

1. Genoma de referencia 	
 -	`test_target_996_loci.fasta`
2. Archivo.txt del nombre de las secuencias (para ensamblar más de una muestra)
- `namelist.txt`
3. Script `reads_first.py`


### A. `reads_first.py`

Para ensamblar las lecturas se utilizó el script `reads_first.py` de la plataforma de Hyb-piper. Este script es un contenedor de varios scripts con dependencias, paquetes ejecutables de Python como: **SPAdes, Velvet, Exonerate, Cap3, BWA y SAMtools**.


Si sólo se desea realizar el ensamble de una sola muestra, se debe convocar al script `reads_first.py` y proporcionar el nombre del archivo con las secuencias de referencia y el nombre de los dos archivos con las salidas pareadas de Trimmomatic. 


**Sintaxis**

[reads first.py] -b [reference] -r [input paired.fastq] --prefix [output] --bwa

**Ejemplo para una sóla muestra**.



Si quieres realizar un ensamble en más de una muestra, hay que proporcionar el archivo `namelist.txt` con un listado de los nombres de las muestras. 

**Ejemplo para más de una muestra**.

Se utiliza el siguiente `for loop`:
```
Una vez que termina de correr el ensamble de secuencias, debes contar con una carpeta para cada muestra como se muestra en la siguiente imagen:

![Results assambly](https://github.com/JR-Montes/ProyectoFinalBioinf2017-II/blob/master/Results%20assambly.jpeg)


Este script se utiliza para resumir todas las longitudes de las lecturas y genera un archivo .txt con todas las muestras. El script imprime una tabla en stdout. La primera línea contiene los nombres de genes. La segunda línea contiene la longitud de las secuencias de referencia. También imprime un WARNING que indica que la longitud de la secuencia es más larga que el 50% respecto a la referencia.
 
**Sintaxis**

python [get seq lengths.py] [reference] [namelist.txt] dna > [output] 

**Ejemplo**.


![alineamientos](https://github.com/JR-Montes/ProyectoFinalBioinf2017-II/blob/master/Seq_length_alingment.jpeg)


### C. `retrieve_sequences.py`

Este script se utiliza para resumir todas las longitudes de lectura y generar un archivo con una secuencia por muestra en formato FNA para nucleótidos. El script utiliza los datos generados por el script `reads_first.py`. El script está diseñado para recuperar y arreglar todas las secuencias para cada gen en alineamientos ya sea de nucleótidos, aminoácidos, intrones y supercontigs. Para ello se debe indicar el argumento del cual necesitamos recuperar la información.


**dna**=**nucleótidos**, **aa**=**péptidos**, **intron**=**intrones**, **supercontig**=**intrones+exones**

### D. `paralog_investigator.py`

Este script extrae los resultados exonerados para todos los parálogos completos que compiten y los deposita en un nuevo directorio dentro del directorio de resultados.Los parálogos pueden ser recopilados usando otro script llamado `paralog_retriever.py´ para alinear y construir árboles génicos.

Para correr el script se necesita un loop. 


**Argumento del loop**

mientras lee el elemento "i"

hacer echo del elemento "i"

ejecuta el script de python para extraer los parálogos el elemento "i"

todo lo anterior con los elementos del archivo.txt

En este caso "i" representa cada gen 

**Ejemplo**.

```
![parálogos](https://github.com/JR-Montes/ProyectoFinalBioinf2017-II/blob/master/Paralogs.jpeg)
### E. `paralog_retriever.py`

Este script recupera todos los parálogos completos que se registraron o identificaron de cada uno de los genes por muestra.

Para correr el script se necesita un loop. 


**Argumento del loop**

mientras lee el elemento "i"

hacer echo del elemento "i"

ejecuta el script de python para recuperar los parálogos del elemento "i"

todo lo anterior con los elementos del archivo.txt

En este caso "i" representa cada gen 

**Ejemplo**.

```

**¿Cómo detecta HybPiper parálogos?**

Si el ensamblador SPAdes genera múltiples contigs que contienen secuencias de codificación con un 75% de la longitud de la proteína de referencia, HybPiper imprimirá una advertencia para ese gen. También imprimirá los nombres de los contigs  y una lista de todos los genes con advertencias de parálogos.


### F. Estadísticos
### `hybpiper_stats.py`

Este script genera información sobre algunos puntos relevantes sobre el proceso de ensamblaje como:

```
•	Número de lecturas

Debes utilizar el siguiente línea de comando para obtener el resumen de los estadísticos:

`../hybpiper_stats.py test_target_996_loci.fasta namelist.txt > test_stats_txt`



`chmod +x hybpiper_stats.py/` 

Al final debes obtener un archivo.txt como el siguiente:

![stats](https://github.com/JR-Montes/ProyectoFinalBioinf2017-II/blob/master/stats.jpeg)

## Gráficas


### stats.R

Este script de R ejecuta el archivo.txt del resultado de los estadístcos y construye una gráfica de barras. Sólo se debe cargar el archivo y correr la función. 


**input** [archivo.txt]

### tree.R

Este script de R utiliza la paquetería de `phytools` y `ape`para editar un árbol filogenético en formato *.nexus* o *.phylip*. Se debe cargar el árbol para y correr la función. Antes de ejecutar el archivo instalar la paquetería y cargar la librería.

**input** [archivo.nex]

`install.packages(Phytools)`

`library(phytools)`

`install.packages(ape)`

`library(ape)`


### heatmap.R

Este script de R utiliza las paqueterías  de `gplots`y `heatmap.plus` para construir un mapa de calor de expresión génica por muestras. El script ejecuta el archivo de salida del resultado de script  `hybpiper_stats.py` en formato.txt.

**input** [archivo.txt]

`install.packages(gplots)`

`library(gplots)`

`install.packages(heatmap.plus)`

`library(heatmap.plus)`


## Referencias









