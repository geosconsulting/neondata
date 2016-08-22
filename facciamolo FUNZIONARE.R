L <- list()
L$x <- 0
f<-function(e) e$x <- 1
f(L)
L$x

#Come si fa una cazzo di lista
sommolo <- function(primo,secondo){
  somma <- primo+secondo
  return(somma)
}

sommolo(10,15)
lista_nummeri <- list(10,15)

print(lista_nummeri[[2]])
