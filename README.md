## Hybpiper 

Este repositorio contiene información sobre secuenciación masiva Illumina, apuntes, enlaces, lecturas recomendas y código para realizar un ensamble con genoma de referencia.



Carpeta software.
-
En ella se encuentra un archivo en .md que contiene los enlaces de las dependencias necesarias para poder correr el análisis. Sin ellas no podrás llevar a cabo el ensamble de las secuencias.

	- Dependencies.md

	
En el archivo.md se encuentra una liga para descargar el repositorio de HybPiper. La platforma HybPiper es clave en este estudio.

`git clone https://github.com/mossmatters/HybPiper.git`

Carpeta bin.
-
Contiene los scripts que serán utilizdos para diferentes funciones. Los tres primero scripts se encuentrán numerado porque ese es el orden de ejecución. 

1. Descargar las secuencias URL
2. Renombrar secuencias
3. Descomprimir archivos fastq.gz
4. stats.R
5. heat_map_stats.R
6. phylogenetic_tree.R

Los escript de R están diseñados para construir un mapa de calor por genes y muestras sobre el % de cobertura recuperado, edición del árbol filogenético y una gráfica sobre el número de lecturas por muestra. Ver paquetería en el apartado de Gráficas.



**NOTA**: Es muy importante leer la información del script debido al tipo de archivo de entrada y el cambio de directorio.


Los script A, B, C, D y E son parte de la plataforma de [HybPiper](https://github.com/mossmatters/HybPiper)

### A. `reads_first.py`

Para ensamblar las lecturas se utilizó el script `reads_first.py` de la plataforma de Hyb-piper. Este script es un contenedor de varios scripts con dependencias, paquetes ejecutables de Python como: **SPAdes, Velvet, Exonerate, Cap3, BWA y SAMtools**.


Si sólo se desea realizar el ensamble de una sola muestra, se debe convocar al script `reads_first.py` y proporcionar el nombre del archivo con las secuencias de referencia y el nombre de los dos archivos con las salidas pareadas de Trimmomatic. 


**Sintaxis**

[reads first.py] -b [reference] -r [input paired.fastq] --prefix [output] --bwa

### B. `get seq lengths.py`

Este script se utiliza para resumir todas las longitudes de las lecturas y genera un archivo .txt con todas las muestras. El script imprime una tabla en stdout. La primera línea contiene los nombres de genes. La segunda línea contiene la longitud de las secuencias de referencia. También imprime un WARNING que indica que la longitud de la secuencia es más larga que el 50% respecto a la referencia.
 
**Sintaxis**

python [get seq lengths.py] [reference] [namelist.txt] dna > [output] 

### C. `retrieve_sequences.py`

Este script se utiliza para resumir todas las longitudes de lectura y generar un archivo con una secuencia por muestra en formato FNA para nucleótidos. El script utiliza los datos generados por el script `reads_first.py`. El script está diseñado para recuperar y arreglar todas las secuencias para cada gen en alineamientos ya sea de nucleótidos, aminoácidos, intrones y supercontigs. Para ello se debe indicar el argumento del cual necesitamos recuperar la información.


**dna**=**nucleótidos**, **aa**=**péptidos**, **intron**=**intrones**, **supercontig**=**intrones+exones**

### D. `paralog_investigator.py`

Este script extrae los resultados exonerados para todos los parálogos completos que compiten y los deposita en un nuevo directorio dentro del directorio de resultados.Los parálogos pueden ser recopilados usando otro script llamado `paralog_retriever.py´ para alinear y construir árboles génicos.

### E. `paralog_retriever.py`

Este script recupera todos los parálogos completos que se registraron o identificaron de cada uno de los genes por muestra.


Carpeta hard data.
-
Se encuentra el archivo.txt que contiene todas las secuencias de illumina de varias especies de pinos piñoneros como de otras especies de pino. Es muy importantes buscar en el archivo `renamed.sh` los IDs de cada muestras para saber que muestras descargar. El archivo cuenta con las direccion URL de cada muestra para poder ser descargadas desde la terminal o desde el arhivo de manera individual.

	- GP0304_files.txt

Carpeta data.
-
Se encuentran los archivos inputs y outputs que serán necesarios para correr lo scripts o serán el resultado de corre un script.


| Archivo| input/output| Descripción|
| ---------- | ---------- |---------- |
|`1045_LociForProbesFasta.fas`|input|Lista de genes de *Pinus taeda* necesaria para contruir el archivo `test_target.fasta`
|**Conc alignmen n310.nex**| output| Alineamiento concatenado construdo en Geneious para construir el árbol filogenético|
|`namelist.txt`|input para shell| Archivo con los nombre de las especies|
|**reads_stats.txt**|input para R| Archivo con los datos del número de lecturas por muestra|
|**stats.txt**|input para R| Archivo con las estadísticas generales del ensamble, como % de covertura, número de parálogos etc.|
|`test_seq_lengths.txt`|output de shell| Archivo recuperado con el número de alineamientos por caga gen|
|`test_target_996_loci.fasta`|input para shell| Archivo de referencia para realizar el ensamble|
|**tree.nex**|input para R| Árbol filogenético construido con SVD quartets en formato nexus|



Carpeta out
-
Ésta carpeta tiene las imágenes del resultado de los script de R, mencionados anteriormenet. 


Carpeta Algoritmos
-
En esta carpeta se encuentran dos archivos- Archvo Wiki y Algoritmos. Puedes revisar el archivo [wiki](https://github.com/JR-Montes/ProyectoFinalBioinf2017-II/blob/master/wiki.md) para seguir el tutorial del análisis y saber cual es la sintaxis de algunos scripts, así como los argumentos de cada uno de ellos- También puedes revisar el archivo.md de los algoritmos para llevar a cabo el pre-procesamiento.



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


Carpeta Resumen de resultados 
-
En esta carpeta se encuentran un archivo.md llamado [Analysis_Results](https://github.com/JR-Montes/ProyectoFinalBioinf2017-II/blob/master/Analysis_Results.md). Que describe los resultados obtenidos en el proyecto. El documento se encuentre en mi repositorio.






Referencias
-
Bolger, A.M., M. Lohse, and B. Usadel. 2014. Trimmomatic: a flexible trimmer for Illumina sequence data. Bioinformatics [30: 2114–2120](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4103590/pdf/btu170.pdf).

Fu, Y., N.M. Springer, D.J. Gerhardt, K. Ying, C.T. Yeh, W. Wu, R. Swanson-Wagner, et al. 2010. Repeat subtraction-mediated sequence capture from a complex genome. The Plant Journal  [62:898–909](http://onlinelibrary.wiley.com/doi/10.1111/j.1365-313X.2010.04196.x/epdf).

Gnirke, A., A. Melnikov, J. Maguire, P. Rogov, E.M. LeProust, W. Brockman, T. Fennell, et al. 2009. Solution hybrid selection with ultra-long oligonucleotides for massively parallel targeted sequencing. Nature Biotechnology [27:182–9](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2663421/pdf/nihms86158.pdf).

Johnson, M.G., E.M. Gardner, Y. Liu, R. Medina, B. Goffinet, A.J. Shaw, N.J.C. Zerega, and N.J. Wickett. 2016. HybPiper: Extracting coding sequence and introns for phylogenetics from high-throughput sequencing reads using target enrichment. Applications in Plant Sciences [4:1600016](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4948903/pdf/apps.1600016.pdf).

Weitemier, K., S.C.K. Straub, R.C. Cronn, M. Fishbein, R. Schmickl, A. McDonnell, and A. Liston. 2014. Hyb-Seq: Combining target enrichment and genome skimming for plant phylogenomics. Applications in Plant Sciences [2:1400042](http://www.bioone.org/doi/pdf/10.3732/apps.1400042).


