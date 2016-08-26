library(ggplot2)
library(manipulate)

abalone <- read.csv("abalone.csv")
meanLength <- mean(abalone$Length)

model <- lm(Whole.weight ~ Length + Sex,data=abalone)
x<-1:3
cv <- function(x, na.rm=FALSE){
  sd(x, na.rm=na.rm)/mean(x, na.rm=na.rm)
}

qplot(x=Rings,y=Length,data=abalone)
plot(Length ~ Sex,data=abalone)
manipulate(
  plot( Length ~ Rings, data=abalone
        , axes = axes
        , cex = cex
        , pch = if(pch) 19 else 1
  )
  , axes = checkbox(TRUE, "Show axes")
  , cex = slider(0, 5, initial = 1, step=0.1, label="Point size")
  , pch = button("Fill points")
)

manipulate({
  if (is.null(manipulatorGetState("model"))){
    fit <- lm(Length~Whole.weight, data=abalone)
    manipulatorSetState("model",fit)
    print("hey, I just estimated a model!")
  } else {
    fit <- manipulatorGetState("model")
    print("Now I just retrieved the model from storage")
  }
  plot(abalone$Length, predict(model), col=col)
}
, col=picker("yellow","orange","red")
)

manipulate({
  plot(Length~Rings, data=abalone)
  xy <- manipulatorMouseClick()
  if (!is.null(xy)) points(xy$userX, xy$userY, pch = 19,col="red")
})

#Queste due sono uguali ma espresse utilizzando modi diversi
plot(Length ~ Whole.weight, data=abalone)
form <- as.formula(paste("Length", "Whole.weight", sep="~"))
plot(form, data=abalone)
do.call(plot,list(form,data=abalone))

dataplot <- function(dat){
  name <- sys.call()[[2]]
  vars <- as.list(names(dat))
  e <- new.env()
  e$data <- name
  manipulate(
    {
      form=as.formula(paste(y,x,sep="~"))
      plot(form, data=dat, main=as.character(name), las=1)
      e$form <- form  
    },
    x=do.call(picker, c(vars, initial=vars[1])),
    y=do.call(picker, c(vars, initial=vars[2]))   
  )
  invisible(e)
}

f <- dataplot(abalone)
