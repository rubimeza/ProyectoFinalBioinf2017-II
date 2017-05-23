## Proyecto Final Bio-informática 2017-II

## README

###

**By José Rubén Montes Montiel**

Este repositorio contiene información sobre secuenciación masiva Illumina, apuntes, enlaces, lecturas recomendas y código para realizar un ensamble con genoma de referencia de con datos multi-locus de Pinos piñoneros.



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

Los escript de R están diseñados para construir un mapa de calor por genes y muestras sobre el % de covertura recuperado, edición del árbol filogenético y una gráfica sobre el número de lecturas por muestra.





		- 1. gsl_wget_download.sh 
		- 2. renamed.sh
		- 3. decompress.sh		- heat_map_stats.R		- phylogenetic_tree.R		- stats.R


**NOTA**: Es muy importante leer la información del script debido al tipo de archivo de entrada y el cambio de directorio.

Carpeta hard data.
-
Se encuentra el archivo.txt que contiene todas las secuencias de illumina de varias especies de pinos piñoneros como de otras especies de pino. Es muy importantes buscar en el archivo `renamed.sh` los IDs de cada muestras para saber que muestras descargar. El archivo cuenta con las direccion URL de cada muestra para poder ser descargadas desde la terminal o desde el arhivo de manera individual.

	- GP0304_files.txt

Carpeta data.
-


En la carpeta hard data se encuentran archivos inputs y outputs que serán necesarios para correr lo scripts o serán el resultado de corre un script.


| Archivo| input/output| Descripción|
| ---------- | ---------- |---------- |
|`1045_LociForProbesFasta.fas`|input|Lista de genes de *Pinus taeda* necesaria para contruir el archivo `test_target.fasta`
|**Conc alignmen n310.nex**| output| Alineamiento concatenado construdo en Geneious para construir el árbol filogenético|
|`namelist.txt`|input para shell| Archivo con los nombre de las especies||**reads_stats.txt**|input para R| Archivo con los datos del número de lecturas por muestra||**stats.txt**|input para R| Archivo con las estadísticas generales del ensamble, como % de covertura, número de parálogos etc.||`test_seq_lengths.txt`|output de shell| Archivo recuperado con el número de alineamientos por caga gen||`test_target_996_loci.fasta`|input para shell| Archivo de referencia para realizar el ensamble||**tree.nex**|input para R| Árbol filogenético construido con SVD quartets en formato nexus|



Carpeta out
-
Ésta carpeta tiene las imágenes del resultado de los script de R, mencionados anteriormenet. 


Archivo wiki
-
Puedes revisar el archivo [wiki](https://github.com/JR-Montes/ProyectoFinalBioinf2017-II) para seguir el tutorial del análisis. 




Referencias
-
Bolger, A.M., M. Lohse, and B. Usadel. 2014. Trimmomatic: a flexible trimmer for Illumina sequence data. Bioinformatics [30: 2114–2120](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4103590/pdf/btu170.pdf).
Fu, Y., N.M. Springer, D.J. Gerhardt, K. Ying, C.T. Yeh, W. Wu, R. Swanson-Wagner, et al. 2010. Repeat subtraction-mediated sequence capture from a complex genome. The Plant Journal  [62:898–909](http://onlinelibrary.wiley.com/doi/10.1111/j.1365-313X.2010.04196.x/epdf).
Gnirke, A., A. Melnikov, J. Maguire, P. Rogov, E.M. LeProust, W. Brockman, T. Fennell, et al. 2009. Solution hybrid selection with ultra-long oligonucleotides for massively parallel targeted sequencing. Nature Biotechnology [27:182–9](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2663421/pdf/nihms86158.pdf).
Johnson, M.G., E.M. Gardner, Y. Liu, R. Medina, B. Goffinet, A.J. Shaw, N.J.C. Zerega, and N.J. Wickett. 2016. HybPiper: Extracting coding sequence and introns for phylogenetics from high-throughput sequencing reads using target enrichment. Applications in Plant Sciences [4:1600016](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4948903/pdf/apps.1600016.pdf).
Weitemier, K., S.C.K. Straub, R.C. Cronn, M. Fishbein, R. Schmickl, A. McDonnell, and A. Liston. 2014. Hyb-Seq: Combining target enrichment and genome skimming for plant phylogenomics. Applications in Plant Sciences [2:1400042](http://www.bioone.org/doi/pdf/10.3732/apps.1400042).


