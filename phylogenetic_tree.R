### Este script de R est?? dise??ado para cargar un ??rbol 
## filogenetico en formato nexus a partir de un ??rbol ya construido en
### otro programa para construir filogenias.

## El ??rbol se cargar utilizando la paqueter??a "ape" del repositorio CRAN
require(ape)
require(phytools)
getwd()
### Escribir aquitu directorio. Ojo! Debes cambiar tu directorio
### Adem??s debes asegurarte de que el archivo.nex viva en el directorio que vas a utilizar
setwd("../Desktop/BioinfInvRepro2017-II-master/Proyecto_Final/Data")
tree<-read.nexus("tree.nex")
summary(tree)
str(tree)
plot(tree, label.offset=0.002, cex=0.6, direction="rightwards",
     bg=mycol, edge.width = 2, edge.color = "grey")
tiplabels(pch=21, bg=c(rep("pink", 2),
                       rep("green",2), "darkolivegreen1", 
                       rep("blue", 2),  
                       rep("orange", 3), 
                       rep("purple", 3),
                       rep("yellow", 2), 
                       rep("dark green", 4), "red",
                       rep("black", 2),
                       rep("dodgerblue", 3),
                       rep("lightcyan", 4),
                       rep("aquamarine", 3),
                       rep("goldenrod1", 5),
                       rep("cornsilk3",3),
                       rep("burlywood", 3),
                       rep("brown4",3),
                       rep("magenta",5), "red", "magenta",
                       rep("lightslateblue",2),
                       rep("ivory1",2), "red", "lightslateblue", "red", "ivory1",
                       cex=6, adj=1.5))
tiplabels(1:119)),





