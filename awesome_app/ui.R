shinyUI(
  fluidPage(
    titlePanel("Distribution app"),
    sidebarLayout(
      sidebarPanel(
        selectInput("dist",
        label="Choose a distribution",
        choices=list("Normal","Chaucy","Uniform"))
      ),
      mainPanel(
        wellPanel(
          p("test"),
          plotOutput("fig")
        )
      ) 
    )
  )
)