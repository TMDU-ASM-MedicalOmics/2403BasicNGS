#! /usr/bin/env R

if (!require("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install("GSEABase")
