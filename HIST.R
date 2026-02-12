x <- c(72, 63, 53, 52, 43, 54, 58, 53, 51, 59, 55, 62, 63, 54, 44, 54,
       60, 60, 60, 57, 57, 45, 54, 60, 57, 70, 73, 54, 46, 56, 55,
       48, 56, 60, 54, 56, 41, 67, 39, 55, 49, 71, 61, 64, 44, 48,
       62, 69, 52, 66, 46, 53, 47, 47, 50, 51, 49, 62, 48, 42, 58,
       62, 55, 56, 59, 60, 58, 56, 59, 56, 56, 52)

cat("Media total:\n")
print(mean(x))

cat("Cantidad de datos:\n")
print(length(x))

set.seed(123)
muestra <- sample(x, 10)

cat("Muestra de tamaño 10:\n")
print(muestra)

cat("Media de la muestra:\n")
print(mean(muestra))

# Histograma de los datos
hist(x,
     main="Histograma de los datos",
     xlab="Valores",
     col="lightblue",
     border="black")

# Medias de 20 muestras
set.seed(123)
medias <- replicate(20, mean(sample(x, 10)))

hist(medias,
     main="Histograma de medias (20 muestras tamaño 10)",
     xlab="Media",
     col="lightgreen",
     border="black")
