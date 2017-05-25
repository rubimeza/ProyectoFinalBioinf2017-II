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

A. **Ensamble**

El ensamble de novo se llevó a cabo con el ensamblador de genomas SPAdes v 3.6.2 (Bankevich et al., 2012). Para el ensamble de cada gen individualmente se usaron las lecturas mapeadas al genoma de referencia con el alineador BWA (Li y Durbin, 2009). Para el método BWA, todas las lecturas alineadas se clasificaron en cada directorio de genes utilizando un contenedor de Python, SAMtools (Li et al., 2009) que permite recuperar eficientemente todas las lecturas alineadas por locus. Tanto las dependencias SAMtools y BWA se encuentran en un script de Python llamado `reads_first.py`. 

Un total de 61 taxa fueron ensamblados utilizando como referencia el genoma de *Pinus taeda.* De los 61 taxa, 53 pertenecen a la subsección *Cembroides* y los 8 taxa restantes pertenecen a las subsecciones *Nelsoniae* y *Balfourianae* (*Parrya*) y subsecciones *Krempfianae* y *Gerardianae* (*Quinquenfoliae*). 
Una vez que terminó de correr el ensamble de las secuencias, los resultados se recuperan en una carpeta para cada muestra.

![Results assambly](https://github.com/JR-Montes/ProyectoFinalBioinf2017-II/blob/master/Results%20assambly.jpeg)

Al interior de cada carpeta se encuentra la lista de genes utilizados para realizar el ensamble de la referencia y varios archivos .txt con los resultados como el número de parálogos, número de intrones, genes con secuencias y el registro de las secuencias que no ensamblaron. En las carpetas que corresponden a cada gen se encuentran varios archivos .fasta y 2 carpetas. Una de las dos carpetas lleva el nombre de la especie en acrónimo y dentro de aquella carpeta se encuentran 7 archivos con los resultados de intronerar y exonerar.

![SPAdes](https://github.com/JR-Montes/ProyectoFinalBioinf2017-II/blob/master/results_spades.jpeg)


Finalmente, para arreglar todas las secuencias por cada gen en alineamientos se utilizó el script de Python `retrieve_sequences.py` más el parámetro `dna` para recuperar la información en nucleótidos.
B. **Parálogos, intrones y supercontigs**Para preparar los archivos con alelos diferentes y parálogos se utilizó un loop con el script de Python `paralog_investigator.py`. Posteriormente, se recuperaron los parálogos, que se detectaron con el script anterior, de todas las secuencias con el script `../paralog_retriever.py`. Ambos scripts trabajan leyendo el archivo `namelist.txt`

En total se identificaron 8640 genes parálogos para todas las muestras. El resultado de los parálogos se encuentra en el archivo stats.txt. Los paráogos fueron eliminados en un editor de secuencias previo a construir el alineamiento múltipleLos intrones que se detectaron en todas las secuencias por muestra se recuperaron con el script `python ../intronerate.py`. Se recuperaron corriendo un loop más el argumento --prefix y el archivo `namelist.txt`. Una vez que terminó de correr el script, se recuperaron todas las secuencias en archivos fasta. 

Los intrones se recuperaron para poder construir los supercontigs. Los supercontigs se recuperaron con el script `python ../retrieve_sequences.py`. El script utiliza como input la referencia y el argumento `supercontig`. Los supercontigs se pueden utilizar para construir alineamientos y obtener mayor número de información al incluir intrones.
C. **Resultados estadísticos** > 1.- Número de lecturas por muestras
Para obtener algunos estadísticos importantes se ejecutó el script `../hybpiper_stats.py` y el output `test_stats_txt` donde se guardan lo resultados de el número de lecturas, porcentaje de cobertura, entre otros. Se realizó una gráfica de barrar en R studio. La gráfica representa el número de lecturas por muestra. Se cargó el archivo.txt y se ejecutó la función del script `stats.R`. 

![barplot](https://github.com/JR-Montes/ProyectoFinalBioinf2017-II/blob/master/stats_number_read.jpeg)

En promedio el número de lecturas por muestras es de 9,146,160. El valor mínimo fue de 4,111,029 lecturas y corresponde con la muestra gera01S1 (*Pinus gerardianae*), barra azúl turquesa número tres de derecha a izquirda, seguida de fall03S1 con 4,261,767 (*Pinus fallax*), monoRH6668 (*Pinus monophylla*) con 5,605,098 lecturas. El valor máximo fue de 14,115,122 lecturas para la muestra johaDSG07999, barra número 8 color azúl (*Pinus johannis*), seguida de la muestra pincDSG1163 (*Pinus pinceana*) con 11,789,410 de lecturas.
> 2.- Porcentaje de cobertura recuperado

Se graficó un mapa de calor con el script `heat_map_stats.R` a partir del archivo `test_seq_lengths` que contiene la lista de genes por muestra. Se derteminó el porcentaje de cobertura a partir de una escala de color. Apróximadamente en la mayoría de los genes el porcentaje de cobertura es mayor al 80%. En muestras como laguAGM9263, laguAGM9279 (*Pinus lagunae*) y monoDSG1214 (*Pinus monophylla*) el porcentaje de cobertura fue menor prácticamente en todos los genes. En algunos genes el porcentaje fue 0% debido a que falló el ensamble con ese gen. En otros casos se llevó a cabo el ensamble pero la longitud de la secuencia es más corta que la referencia y se obtiene menor cobertura. En todas las muestras al menos en un par de genes o más se obtiene una menor cobertura o simplemente se obtiene 0%. 

![heatmap](https://github.com/JR-Montes/ProyectoFinalBioinf2017-II/blob/master/heat_map_stats.jpeg)


 > 3.- Análisis filogenético

Los archivos resultantes tanto de los exones como de los supercontigs fueron importados a Geneious R9 (Katoh et al., 2002) y alineados individualmente con MAFFT (Katoh et al., 2002). Usamos los siguientes criterios para optimizar el alineamiento múltiple 1) Secuencias con 1 o más muestras faltantes, 2) Porcentaje de sitios idénticos menores al 50%, 3) Alineamientos con un porcentaje menor al 93% y 4) genes parálogos. De un total de 996 locí recuperamos 306 loci después de los filtros.


Se construyó un árbol filogenético con SVD quartets implementado en PAUP con el modelo colascente de especies con un archivo de 306 loci y 61 taxa. Se utilizaron 1000 réplicas de quartets con búsquedas heurísticas y criterios de optimización. Se utilizó el algoritmo TBR y caracteres con pesos iguales. Se eligieron como grupos externos a los representantes de las subsecciones  *Gerardianae*  (*Pinus bungeana* y *Pinus gerardiana*),  *Krempfianae* (*Pinus krempfii*), *Strobus* (*Pinus lambertiana*) *Balfourianae* (*Pinus aristata* y *Pinus longaeva*) y *Nelsoniae* (*Pinus nelsonii*). Las subsecciones citadas se han reportado como el grupo hermano de la subsección *Cembroides*.

Se obtuvieron un total 2022767305 rearreglos con las búsquedas heurísticas. De los 274,405 caracteres sólo 189366 fueron informativos. El mejor árbol fue econtrado con 229397 pasos y fueron retenidos 4 árboles. El tiempo de CPU fue de 2:17:00.5 

![tree](https://github.com/JR-Montes/ProyectoFinalBioinf2017-II/blob/master/tree_phylogenetic.jpeg) 


En el árbol filogenético podemos observar que recuperamos como monofiléticas las 5 subsecciones como se ha reportado en otros estudios (Gernandt et al, 2005) De acuerdo con Gernandt et al. (2005) el grupo hermano se la subsección *Krempfiane* es el grupo hermano de la *Gerardianae*. Se confirma que el grupo hermano de toda la subsecc. *Cembroides* es la subsecc. *Nelsoniae* (Gernandt et al. 2003). Los clados *rzedowskii*, *pinceana*, *nelsonii* y *maximartinezii* forman por separado grupos monofiléticos. Los 4 clados se caracterizan por poseer los conos más grandes del resto de los pinos piñoneros. Esta agrupación se había reportado anteriormente por Malusa (1992) con caracteres morfológicos. 

![cones](https://github.com/JR-Montes/ProyectoFinalBioinf2017-II/blob/master/Pinyons_big_cone.jpeg)


Los clados *culminicola*, *johannis* y *discolor* se recuperan como monofiléticos cada uno respectivamente. En estudios anteriores no se tenían claras las relaciones entre aquellas tres especies. De acuerdo con Gernandt et al. (2003) las tres especies formaban un sólo clado y se tenía la hipótesis de que *Pinus culminicola* era sinónimo de *Pinus johannis*. En este estudio *Pinus culminicola* es el grupo hermano de *Pinus johannis*. El clado *edulis* y *cembroides* se recuperan como monofiléticos. Dentro del clado *cembroides* se encuentra dos variedades *Pinus cembroides* var. *lagunae* y *Pinus cembroides* var. *orizabensis*. El clado *californiarum* se recupera como monofilético. No obstante una muestra de *Pinus monophylla* se encuentra dentro de este grupo. Varios autores consideran a *Pinus californiarum* sinónimo de *Pinus monophylla* por poseer una sóla acícula por fascículo. No obstante, existe evidencia morfológica que podría indicar que ambas son especies independientes. Las dos especies pueden tener zonas contacto. En ese sentido se corroborará la procedencia de la muestra de *P. monophylla* y confirmar si es *Pinus californiarum* o *Pinus monophylla*. Al menos en este estudio  *Pinus monophylla* es polifilético. Los clados *P. juarezensis*,  y *P. quadrifolia* son parafiléticos. Se ha considerado a *P. juarezensis* sinónimo de  y *P. quadrifolia*. A simple vista la primera especie presenta 5 acículas por fascículo mientras que la segunda presenta 4 acículas por fascículo. Se necesitaría hacer otro tipo de análisis con métodos paramétricos para corroborar su posición. 


C. **Conclusión**

Se presizó la funcionalidad de la plataforma HybPiper con datos obtenidos por método HybSeq. Se recuperó más cobertura con la referencia construida que con la referencia de *Pinus taeda*. Se confirmó la monofilia de la sección *Parrya* y *Quinquenfoliae*, así como de las 5 subsecciones incluidas en este estudio. La mayoría de los clados se recuperan como monofiléticos. Se resolvieron las relaciones de  *Pinus culminicola* y *Pinus johannis*. En este estudio *Pinus culminicola* es el grupo hermano de *Pinus johannis*. Se confirmó la posición de la subsección *Nelsoniae* como el grupo hermano de la subsección *Cembroides*. Ahora queda probar las hipótesis filogenéticas obtenidas con otro tipo de métodos y tratar de hacer delimitación de especies para aquellas especies que son consideradas híbridos o sinónimos.




**Referencias**
 
Bankevich A, Nurk S, Antipov D, Gurevich AA, Dvorkin M, Kulikov AS, Lesin VM, Nikolenko SI, Pham S, Prjibelski AD, Pyshkin AV, Sirotkin AV, Vyahhi N, Tesler G, Alekseyev MA, Pevzner PA. 2012. SPAdes: A new genome assembly algorithm and its applications to single-cell sequencing. Journal of Computational Biology [19:455-477.](https://github.com/ablab/spades/releases)Bolger, A.M., M. Lohse, and B. Usadel. 2014. Trimmomatic: a flexible trimmer for Illumina sequence data. Bioinformatics [30: 2114–2120](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4103590/pdf/btu170.pdf).
Fu, Y., N.M. Springer, D.J. Gerhardt, K. Ying, C.T. Yeh, W. Wu, R. Swanson-Wagner, et al. 2010. Repeat subtraction-mediated sequence capture from a complex genome. The Plant Journal  [62:898–909](http://onlinelibrary.wiley.com/doi/10.1111/j.1365-313X.2010.04196.x/epdf).
Gernandt DS, Geada GL, Ortiz GS, Liston A. 2005. Phylogeny and classification of Pinus. Taxon 54:29-42.

Gernandt DS, Liston A, Piñero D. 2003. Phylogenetics of Pinus subsections Cembroides and Nelsoniae inferred from cpDNA sequences. Syst Bot 28(4):657-673.Gnirke, A., A. Melnikov, J. Maguire, P. Rogov, E.M. LeProust, W. Brockman, T. Fennell, et al. 2009. Solution hybrid selection with ultra-long oligonucleotides for massively parallel targeted sequencing. Nature Biotechnology [27:182–9](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC2663421/pdf/nihms86158.pdf).
Johnson, M.G., E.M. Gardner, Y. Liu, R. Medina, B. Goffinet, A.J. Shaw, N.J.C. Zerega, and N.J. Wickett. 2016. HybPiper: Extracting coding sequence and introns for phylogenetics from high-throughput sequencing reads using target enrichment. Applications in Plant Sciences [4:1600016](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC4948903/pdf/apps.1600016.pdf).

Kearse M, Moir R, Wilson A, Stones-Havas S, Cheung M, Sturrock S, Buxton S, Cooper A, Markowitz S, Duran C, Thierer T, Ashton B, Mentjies P, Drummond A. 2012. Geneious Basic: an integrated and extendable desktop software platform for the organization and analysis of sequence data. Bioinformatics 28(12):1647-1649


Li H, Durbin R. 2009. Fast and accurate short read alignment with Burrows-Wheeler Transform. Bioinformatics [25:1754-60.](https://github.com/lh3/bwa)

Li H, Handsaker B, Wysoker A, Fennell T, Ruan J, Homer N, Marth G, Abecasis G, Durbin R. 2009. The Sequence alignment/map (SAM) format and SAMtools. Bioinformatics [25: 2078-9.](https://github.com/samtools/samtools)
Weitemier, K., S.C.K. Straub, R.C. Cronn, M. Fishbein, R. Schmickl, A. McDonnell, and A. Liston. 2014. Hyb-Seq: Combining target enrichment and genome skimming for plant phylogenomics. Applications in Plant Sciences [2:1400042](http://www.bioone.org/doi/pdf/10.3732/apps.1400042).



