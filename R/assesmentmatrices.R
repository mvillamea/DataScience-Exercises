#add the scalar 1 to row 1, the scalar 2 to row 2, and so on, for the matrix x
x <- x + seq(nrow(x))

x <- sweep(x, 1, 1:nrow(x),"+")

#add the scalar 1 to column 1, the scalar 2 to column 2, and so on, for the matrix x
x <- sweep(x, 2, 1:ncol(x), FUN = "+")


#For each observation in the mnist training data, compute the proportion of pixels that are in the grey area, defined as values between 50 and 205 (but not including 50 and 205).
mat<-mnist$train$images
mat<-as.matrix(mat)
newmat<-mat[mat>50&mat<205]
length(newmat)/(60000*784)

#otra forma
mnist <- read_mnist()
y <- rowMeans(mnist$train$images>50 & mnist$train$images<205)
qplot(as.factor(mnist$train$labels), y, geom = "boxplot")
