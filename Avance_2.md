## Curso de Bio-informática 2017-2

## Avances preliminares: Pre-procesamiento y procesamiento.


#### Avance 2


**1.** **Resumen**.
	
Hasta el momento he leído 5 trabajos relacionados con el análisis de mis datos, obtención de datos, sofweres y pipelines, Además, descargué mi secuencias de trabajo. Construí mi referencia a partir de una lista de genes del genoma de _Pinus taeda_ L. Realicé un script en TextWrangler para cambiar el nombre de las secuencias al nombre de las especies. Edité mis secuencias con Trimmomatic. Corrí un script para ensamblar las secuencias a mi referencia de trabajo. Creé mi _namelist_ en `nano` con todas las especies que voy a trabajar para poder correr con `for loops` los scripts. Corrí un script para obtener las longitudes de las lecturas ensambladas a la referencia. Realicé dos tutoriales en Markdown para utilizaros como rutas de trabajos en el laboratorio. 
A continuación enlisto los enlances de los artículos que forman parte medular de mi proyecto bio-informático. Además describo las actividades que realicé.


**Artículos**:

Ensamblador de genomas [SPAdes](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3791033/pdf/cmb.2013.0084.pdf)

Método de obtención de secuencias [HybSeq](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4162667/pdf/apps.1400042.pdf)

Pipiline para análisis de secuencias [HybPiper](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4948903/pdf/apps.1600016.pdf)

Método de análsis para datos multi-locus [tr2](https://oup.silverchair-cdn.com/oup/backfile/Content_public/Journal/sysbio/65/5/10.1093_sysbio_syw028/3/syw028.pdf?Expires=1493562475&Signature=dYE9RRld4meFJ2GrcKR9JmHe66cXPOf-4yHmTVAJCPdFSMfOlLQZzjP8zax2SMO5qgO5Xx8VQNcmG1gACrWR20LBVO~Hq6a0yMWRpk-OaN29sCs8awiy7DyPaHQNV2Z0gOHMnTgHqWV7AUbxYL6Eg60rEfrmLUgjCr1Re6GoObIWGP1hYhd44TvCXoArcCAppLIN5Epe1pPNBpEMGoCzKpoxdsmhqFwhCj44TdU29IYUSnsbpZSYEKIWFx~1XPExXc0UeEnK-B-YUwwZEcFSNWSHDu8JZHKyv6CJPjap4Xh80ulz8jkN-AWBp2YJdM0WuSw0F29t6YJASOSr-lAOCw__&Key-Pair-Id=APKAIUCZBIA4LVPAVW3Q)

Lista de genes para generar mi referencia a partir del genoma de _P. taeda_ [Neves et al., (2013)](http://onlinelibrary.wiley.com/doi/10.1111/tpj.12193/epdf)

**2.** **Lista de genes para crear referencia a partir del genoma de _P. taeda_**.

Descargué el contenido suplementario [data S3](http://onlinelibrary.wiley.com/doi/10.1111/tpj.12193/abstract) de [Neves et al. (2013)](http://onlinelibrary.wiley.com/doi/10.1111/tpj.12193/epdf) para revisar la lista de genes del genoma de _Pinus taeda_ L. y hacer una selección de genes para generar mi referencia. La referencia se construyó en el editor de secuencias Geneious y después se cargó la referencia al servidor del Instituto de Biología "pinaceae.ib.unam.mx" a través del gestor FTP [FileZilla](https://filezilla-project.org/download.php), con el nombre de `test_target.fasta`


**3.** **Lista de especies**

En la terminal de bash, utilicé `nano`para crear un archivo, que contienen la lista de especies de trabajo, con el nombre de `namelist.txt`, utilizando la siguiente línea de comando:

`nano namelist.txt`

A continuación muestro sólo una parte del contenido del archivo `namelist.txt`:

`less namelist.txt`

```arisAL04bungAL03cemdDRD18devoDSG721gregDSG1386nelsDSG1095picchihDSG1070pincDSG440pineAL06strfRG539thunAL03
```


**4.** **Descargar las secuencias propias de Illumina**

Primero creé dos directorios. El primer directorio para cargar los scripts del repositorio de GitHub [HybPiper](https://github.com/mossmatters/HybPiper) llamado HybPiper y el segundo directorio, dentro del directorio HybPiper para descargar las secuencias de Illumina, llamado Cembroides. Teclé la siguiente línea de comandos:

`mkdir HybPiper`

Cambié de directorio, teclé:

`cd HybPiper`

Hice el otro nuevo directorio, teclé:

`mkdir Cembroides`


Después hice ejecutables los script que se encuentran dentro del directorio `HybPiper` con el comando `chmod` con la siguiente sintaxis:

`chmod +x [script]`

Luego, descargué el script para descargar las secuencias de Illumina:

`gsl_wget_download.sh`

Finalmente, utilicé la siguiente línea de comandos en la terminal para descargar las secuencias de Illumina desde mi directorio de trabajo. 

`bash gsl_wget_download.sh GP0304_files.txt`

**5.** **Script para cambiar nombre de las secuencias**

En el editor de texto TextWrangler hice un script llamado `Renamed.sh`para adicionar el nombre de las especies en acrónimo a las  secuencias de Illumina 1 y 2. Cada número corresponde al _forward_ y _reverse_ . Utilicé el comando `mv`para cambiar el nombre. A continuación muestro un ejemplo del contenido del escript. En el ejemplo se puede observar que el nombre de la secuencia ahora cuenta con el acrómino de la especie más el número de colecta. En este caso la muestra es cemb04s1 que corresponde con _Pinus cembroides_ muestra 04 semilla 1.

```mv CACGCANXX_s6_2_MY715-MY527_SL217966.fastq.gz cemd04S1_CACGCANXX_s6_2_MY715-MY527_SL217966.fastq.gz   
``````mv CACGCANXX_s6_1_MY715-MY527_SL217966.fastq.gz cemd04S1_CACGCANXX_s6_2_MY715-MY527_SL217966.fastq.gz
```

Posteriormente corrí el script `Renamed.sh` en la terminal desde el directorio de trabajo `Cembroides` que es dónde viven las secuencias. Teclé la siguiente línea de comando:

`bash Renamed.sh`

**6.** **Pre-procesamieto de lecturas de Illumina para procesamiento en HybPiper (trimmed+paired)**

Utilicé la línea de comandos de [Trimmomatic](http://www.usadellab.org/cms/uploads/supplementary/Trimmomatic/TrimmomaticManual_V0.32.pdf) para cortar las secuencias de mala calidad y quitar los adaptadores. Las secuencias se encuentran en formato fastq comprimidos en zip. Se utilizó el modo _paired end_ para que realizará el proceso en las secuencias 1 y 2. A continuación describo la sintaxis de la línea de comandos que utilice para el pre-procesamiento:

java -jar [path to trimmomatic jar] PE [input 1] [input 2] [paired output1] [unpaired output1] [paired output2] [unpaired output2] LEADING:3 TRAILING:3 SLIDINGWINDOW:4:20 MINLEN:30

**java -jar**: Lenguaje de programación.

**[path to trimmomatic jar]**: Ruta donde se encuentra o vive el programa Trimmomatic.

**PE**: Modo Pareado para realizar el trimm en los adaptadores de forward (1) y reverse (2).

**[input 1] [input 2]**: Secuencias de Illumina 1 y 2 

**[paired output1] [unpaired output1]**: Secuencia forward de salida de Illumina pareada y no pareada.

**[paired output2] [unpaired output2]**: Secuencia reverse de salida de Illumina pareada y no pareada.

**LEADING:3** Este parámetro elimina las bases de mala calidad al principio de la lectura (below quality 3)

**TRAILING:3** Este parámetro elimina las bases de mala calidad al final de la lectura (below quality 3)

**SLIDINGWINDOW:4:20** Este parámetro escanea la lectura con una ventana deslizante ancha de 4 bases, cortando cuando la calidad media por base cae por debajo de 20.

**MINLEN:30** Este parámetro elimina o abandona las lecturas que tienen menos de 30 bases de largo.


A continuación muestro un ejemplo de la línea de comandos que utilicé para pre-procesar mis secuencias. La especie es _Pinus bungeana_, muestra 03 y semilla 3, acrónimo bung03s3A


```java -jar /usr/local/bin/Trimmomatic-0.36/trimmomatic-0.36.jar PE bung03s3A_CACGCANXX_S6_1_MY720-MY544_SL217958.fastq.gz bung03s3A_CACGCANXX_S6_2_MY720-MY544_SL217958.fastq.gz bung03s3A_R1_paired.fastq.gz bung03s3A_R1_unpaired.fastq.gz bung03s3A_R2_paired.fastq.gz bung03s3A_R2_unpaired.fastq.gz LEADING:3 TRAILING:3 SLIDINGWINDOW:4:20 MINLEN:30
```

**6.** **Descomprimir secuencias “paired” con extensión `fastq` que se encuentren en formato `gz`.**

Utilicé el comando `gzip -d` para descomprimir las secuencias. Además utilicé el comodín `*` para descomprimir todos las secuencias en dos bloques. Primero las secuencias R1 y después las R2. Teclé las siguientes líneas de comando: 

`gzip -d *_R1_paired.fastq.gz`
`gzip -d *_R2_paired.fastq.gz`



-
## Procesamiento

Primero descargué [SPAdes 3.6.2](http://bioinf.spbau.ru/content/spades-download) desde su página oficial y lo coloqué en bin para que allí viviera. 

Lo exporté a mi directorio de trabajo con la siguente línea de comando:

`export PATH=$PATH:/usr/local/bin/SPAdes-3.6.2`

Para corroborar, teclé:

`echo $PATH`

Y devulve lo siguient:

`/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/lib/cd-hit:/usr/local/bin/SPAdes-3.6.2`



**7.** **Pipiline HybPiper**

Ahora para poder ensamblar mis datos con SPAdes necesito tener los scripts de HybPiper (listo). Los archivos trimmeados de *.fastq (listo). Archivo de referencia llamado `test_targets.fasta`(listo). Archivo de la lista de especies, creado en `nano` llamado `namelist.txt`(listo).  

Comprobé que todos los scripts estuvieran en el directorio `HybPiper`, teclé:

`ls`

Deben aparecer estos archivos:

```
cleanup.pydepth_calculator.pydistribute_reads_to_targets_bwa.pydistribute_reads_to_targets.pydistribute_targets.pyexonerate_hits.pyexonerate_hits.pycfasta_merge.pygene_recovery_heatmap.Rget_seq_lengths.pyhybseq_summary.pyintronerate.pyLICENSE.txt      paralog_investigator.pyparalog_retriever.pyquery_file_builder.py  README.mdreads_first.pyretrieve_sequences.py                run_tests.shspades_runner.py
```

**8.** **Ensamlar lecturas con SPAdes**

Para ensamblar las lecturas se utilizó el script `reads_first.py`

Si sólo se desea realizar el ensamble de una sola muestra, se debe convocar al script `reads_first.py` y proporcionar el nombre del archivo con las secuencias de referencia y el nombre de los dos archivos con las salidas pareadas de Trimmomatic. La sintaxis de la siguiente línea de comando es:

[reads first.py] -b [Reference] -r [Input paired.fastq] --prefix [Output] --bwa

**reads first.py**: Este script es un contenedor de varios scripts con dependencias, paquetes ejecutables de Python como:

	SPAdes

	velvet

	exonerate

	cap3

	bwa

	samtools

**-b**: Flag que indica la entrada del archivo de referencia 

**Reference**: Archivo con el genoma de referencia

**-r**: Flag que indica leer secuencia

**Input_paired.fastq**: Nombre de entrada de la secuencia que se va a ensamblar

**--prefix**: Flag que indica el directorio de salida

**output**: Nombre del arhivo de salida con el resultado del ensamble

**--bwa**: Flag que indica buscar lecturas con la dependencia bwa, un alineador de secuencias dentro del script.
`../reads_first.py -b test_targets.fasta -r gregDSG1386_R*_paired.fastq --prefix gregDSG1386 --bwa`Para entender la sintaxis de la línea de comando de arriba, así como el significado de los flag `-b` y `-r` `--prefix` `--bwa`se recomienda revisar el script `reads_first.py` en el repositorio de datos de [HybPiper](https://github.com/mossmatters/HybPiper/blob/master/reads_first.py)   
 
 Para correr el script para más de un individuo, se utiliza el siguiente `for loop`:```while read name; do ../reads_first.py -b test_targets.fasta -r "$name*.fastq" --prefix $name --bwa done < namelist.txt
```

Una vez que termina de correr el ensamble de secuencias, debo contar con una carpeta para cada muestra. Para resumir todas las longitudes de lectura y generar un archivo con una secuencia por muestra, utilicé  la siguiente línea de comando:`python ../get_seq_lengths.py test_targets.fasta namelist.txt dna > test_seq_lengths.txt`Revisa el archivo para confirmar que todas las muestras corrieron correctamente:
`cat test_seq_lengths.txt`

Si encuentras una muestra donde todas las longitudes son 0, hay que revisar que su nombre aparece correctamente en el archivo `namelist.txt`. Otra posibilidad es revisar que no hay errores de dedo en los nombres de los archivos de fastq. Al realizar la corrección debes recorrer HybPiper.Para arreglar todas las secuencias para cada gen en alineamientos:
`python ../retrieve_sequences.py test_targets.fasta . dna`
Esta línea de comando contiene el parámetro `dna` que se utiliza cuando tienes exclusivamente secuencias de nucleótidos.


Hasta el momento es lo que llevo.


