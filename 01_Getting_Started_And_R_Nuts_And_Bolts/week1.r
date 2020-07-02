x <- 1:20
print(x)

##### Matrix
m <- matrix(1:6,nrow=2,ncol=3)
print(m)

# another way to create a matrix
## Cbind is column bind
## rbind is row bind
x <- 1:3
y <- 10:12
cbind(x,y)
rbind(x,y)

#### factors
x <- factor(c("yes","yes","no","yes","no"))
x
table(x)
unclass(x) #see how R is storing the values

# explicitly set levels (default is alphabetically)
x <- factor(c("yes","yes","no","yes","no"), levels=c("yes","no"))
x


##### Missing numbers
x <- c(1,2,NA,10,3)
is.na(x)
is.nan(x)

x <- c(1,2,NaN,NA,4)
is.na(x)
is.nan(x)


##### Data frames
x <- data.frame(foo=1:4, bar=c(T,T,F,F))
x
ncol(x)
nrow(x)


#### Variable names
x <- 1:3
names(x)
names(x) <- c("foo","bar","nerf")
x
names(x)

x <- list(a=1,b=2,c=3)
x

m <- matrix(1:4, nrow=2, ncol=2)
dimnames(m) <- list(c("a","b"),c("c","d"))
m

y <- data.frame(a=1, b="a")
dput(y)
dput(y, file="y.R")
new.y <- dget("y.R")
new.y