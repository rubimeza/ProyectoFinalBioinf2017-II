##ProyectoFinalBioinf2017-II

### Ensamble a Genoma de Referencia con Hyb-Piper

Este es el repositorio de apuntes, enlaces, lecturas recomendas y código para realizar un ensamble a genoma de referencia con datos multi-locus (Illumina) de Pinos piñoneros.

### IntroducciónEl enriquecimiento basado en hibridación con RNA (“Hyb-seq”) es un método que permite generar juegos de datos de ADN para estudios filogenómicos. Originalmente fue empleado para enriquecer 1,900 genes codificantes (15,565 exones) en humanos (Gnirke et al. 2009). Casi inmediatamente fue adoptado para maíz (Fu et al. 2010). Una metodología generalizada que emplea Hyb-seq para estudios en la filogenómica de plantas fue descrito por Weitemier et al. (2014) y la plataforma “Hyb-Piper” para el procesamiento de los datos provenientes de Hyb-seq fue presentado por Johnson et al. (2016). En este repositoriO vamos a trabajar con lecturas pareadas de Illumina provenientes de reacciones Hyb-seq en una muestra diversa de especies del género Pinus, realizar una limpieza con base en puntuaciones PHRED, y ensamblar las secuencias mediante la plataforma HybPiper.


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

Una vez que se ha clonado el repositori de HybPiper en MacOSX y Linux. Todas las herramientas bioinformáticas se pueden instalar con [homebrew](https://github.com/mossmatters/HybPiper/blob/master/brew.sh) o [linuxbrew](https://github.com/mossmatters/HybPiper/blob/master/linuxbrew.sh).

Para obtener instrucciones completas de instalación, se puede consultar en el siguiente enlace [wiki](https://github.com/mossmatters/HybPiper/wiki/Installation)



## Pipeline

### 1. Descargar secuencias Illumina

Obtener el script siguiente para descargar las secuencias de Illumina:

`gsl_wget_download.sh`

Utilizar la siguiente línea de comandos en la terminal para descargar las secuencias de Illumina desde el directorio de trabajo. 

`bash gsl_wget_download.sh GP0304_files.txt`


### 2. Cambiar nombre a las secuencias
Descarga el script llamado [`Renamed.sh`](https://github.com/JR-Montes/ProyectoFinalBioinf2017-II)para adicionar el nombre de la especie en acrónimo a las secuencias de Illumina 1 y 2. Es este caso cada número corresponde al _forward_ y _reverse_ . Utiliza el comando `mv`para cambiar el nombre. 
A continuación se muestra un ejemplo del contenido del script. En el ejemplo se puede observar que el nombre de la secuencia ahora cuenta con el acrómino de la especie más el número de colecta. En este caso la muestra es cemb04s1 que corresponde con _Pinus cembroides_ muestra 04 semilla 1.

```mv CACGCANXX_s6_2_MY715-MY527_SL217966.fastq.gz cemd04S1_CACGCANXX_s6_2_MY715-MY527_SL217966.fastq.gz   
``````mv CACGCANXX_s6_1_MY715-MY527_SL217966.fastq.gz cemd04S1_CACGCANXX_s6_2_MY715-MY527_SL217966.fastq.gz
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


```java -jar /usr/local/bin/Trimmomatic-0.36/trimmomatic-0.36.jar PE bung03s3A_CACGCANXX_S6_1_MY720-MY544_SL217958.fastq.gz bung03s3A_CACGCANXX_S6_2_MY720-MY544_SL217958.fastq.gz bung03s3A_R1_paired.fastq.gz bung03s3A_R1_unpaired.fastq.gz bung03s3A_R2_paired.fastq.gz bung03s3A_R2_unpaired.fastq.gz LEADING:3 TRAILING:3 SLIDINGWINDOW:4:20 MINLEN:30
```


**NOTA** Para conocer la razón de los parámetros de Trimmomatic has click en el enlace de arriba.

Cambiar nombre

Ensamble

Obtener longitudes

Recuperar intrones

Recuperar contigs

Identificar parálogos

Obtener estadísiticas

Graficar en R







