#!/bin/bash/

### Este es un script para descomprimir secuencias en formato .fastq.gz con el comando gzip

### Primero va a descomprimir las secuencias forward (R1)
### se utilizar el comodín * para indicar que decomprima todo aquello que se encuentre en fastq.gz
gzip -d *_R1_paired.fastq.gz


### Después va a descomprimir las secuencias reverse (R2)
gzip -d *_R2_paired.fastq.gz