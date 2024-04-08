#!/usr/bin/env R

args <- commandArgs(T)
data <- read.table(args[1],sep="\t",header=T)
data <- data[data$baseMean != 0,]
totalgenes <- rownames(data)

data.f <- na.omit(data)
data.f <- data.f[data.f$padj <= 0.01,]
data.f <- data.f[data.f$baseMean >= 100,]
data.f <- data.f[data.f$log2FoldChange >= 1,]
data.f <- data.f[order(data.f$log2FoldChange,decreasing=T),]

geneset <- readRDS(args[2])
geneset.f <- list()

for (gs in names(geneset)) {
    genes.gs <- geneset[[gs]]
    genes.gsf <- genes.gs[genes.gs %in% totalgenes]
    if (length(genes.gsf) > 25) geneset.f[[gs]] <- genes.gsf
}
genes.cf <- rownames(data.f)
res_l <- list()
for (gs in names(geneset.f)) {
    genes.gs <- geneset.f[[gs]]
    CfGs <- length(intersect(genes.gs,genes.cf))
    if (CfGs == 0) next
    OgGs <- length(genes.gs) - CfGs
    CfOg <- length(genes.cf) - CfGs
    OgOg <- length(totalgenes) - CfGs - OgGs - CfOg
    mat <- matrix(c(CfGs,OgGs,CfOg,OgOg),nrow=2)
    res <- fisher.test(mat)
    res_l[[gs]] <- c(res$p.value,as.numeric(res$estimate))
}
res <- t(as.data.frame(res_l))
colnames(res) <- c("pval","oddsratio")
res <- as.data.frame(res)
res$padj <- p.adjust(res$pval,method="BH")
res <- res[order(res$oddsratio,decreasing=T),]
write.table(res,args[3],sep="\t",quote=F)