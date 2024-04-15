#!/usr/bin/env R

args <- commandArgs(T)
library(fgsea)

data <- read.table(args[1],sep="\t",header=T)
data <- data[data$baseMean != 0,]

geneset <- readRDS(args[2])
geneset.f <- list()

for (gs in names(geneset)) {
    genes.gs <- geneset[[gs]]
    genes.gsf <- genes.gs[genes.gs %in% rownames(data)]
    if (length(genes.gsf) > 25) geneset.f[[gs]] <- genes.gsf
}

stats <- data$stat
names(stats) <- rownames(data)

res <- fgsea(pathways = geneset.f, 
                  stats    = stats,
                  minSize  = 15,
                  maxSize  = 500)

res <- as.data.frame(res)
res <- res[order(res$NES,decreasing=T),1:7]
write.table(res,args[3],sep="\t",quote=F,row.names=F)
