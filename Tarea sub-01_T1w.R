library(RNifti)

# 1) Tamaño del volumen

img <- readNifti("sub-01_T1w.nii.gz")

cat("1) Tamaño del volumen (dimensiones):\n")
print(dim(img))


# 2) Mostrar vistas sagital, coronal y axial

d <- dim(img)

i0 <- round(d[1]/2)
j0 <- round(d[2]/2)
k0 <- round(d[3]/2)

dev.new()
par(mfrow=c(1,3))

image(t(apply(img[i0,,], 2, rev)),
      col=gray(0:255/255),
      main="Sagital",
      axes=FALSE)

image(t(apply(img[,j0,], 2, rev)),
      col=gray(0:255/255),
      main="Coronal",
      axes=FALSE)

image(t(apply(img[,,k0], 2, rev)),
      col=gray(0:255/255),
      main="Axial",
      axes=FALSE)


# 3) Histograma del volumen

voxels <- as.vector(img)
voxels <- voxels[voxels > 0]

dev.new()
hist(voxels,
     breaks=100,
     col="gray",
     main="Histograma del volumen",
     xlab="Intensidad")


# 4) Intervalo aproximado del cuerpo calloso

i_mid <- round(d[1]/2)

slice <- img[i_mid,,]
slice <- t(apply(slice, 2, rev))


slice_norm <- (slice - min(slice)) / (max(slice) - min(slice)) # Normalizar intensidades (0-1)

lower <- 0.20
upper <- 0.30

mask <- slice_norm >= lower & slice_norm <= upper

# Convertir rango normalizado a valores reales

min_val <- min(slice)
max_val <- max(slice)

gray_lower <- lower * (max_val - min_val) + min_val
gray_upper <- upper * (max_val - min_val) + min_val

cat("\n4) Intervalo aproximado de tonos de gris del cuerpo calloso:\n")
cat("Desde", round(gray_lower), "hasta", round(gray_upper), "\n")



# Marcaje del cuerpo calloso

dev.new()

image(slice_norm,
      col=gray(0:255/255),
      main="Cuerpo calloso",
      axes=FALSE)

image(mask,
      col=c(rgb(0,0,0,0), rgb(1,0,0,0.7)),
      add=TRUE)