library(RNifti)


bold <- readNifti("sub-01_task-restaurative_bold.nii.gz")

# 1) Tamaño del volumen
cat("Dimensiones del volumen:\n")
print(dim(bold))

# 2) Volumenes del archivo

cat("Número de volúmenes (tiempo):\n")
print(dim(bold)[4])


# 3) Definir punto P0 (centro del volumen)

d <- dim(bold)

i0 <- round(d[1]/2)
j0 <- round(d[2]/2)
k0 <- round(d[3]/2)

cat("P0 seleccionado en:\n")
print(c(i0, j0, k0))



signal_P0 <- bold[i0, j0, k0, ] # Extraer señal del P0

dev.new()

plot(signal_P0,
     type="l",
     col="black",
     lwd=2,
     main="Señal temporal de P0",
     xlab="Tiempo (volúmenes)",
     ylab="Intensidad BOLD")

# Definir vecindad 5*5*5
i_range <- max(1, i0-2):min(d[1], i0+2)
j_range <- max(1, j0-2):min(d[2], j0+2)
k_range <- max(1, k0-2):min(d[3], k0+2)

correlations <- c()

for (i in i_range) {
  for (j in j_range) {
    for (k in k_range) {
      
      if (!(i==i0 & j==j0 & k==k0)) {
        
        signal_neighbor <- bold[i, j, k, ]
        
        r <- cor(signal_P0, signal_neighbor)
        
        correlations <- c(correlations, r)
      }
    }
  }
}

cat("Número de correlaciones calculadas:\n")
print(length(correlations))


# 5) Histograma de correlaciones


dev.new()

hist(correlations,
     breaks=30,
     col="gray",
     main="Histograma de correlaciones (vecindad 5x5x5)",
     xlab="Correlación con P0")