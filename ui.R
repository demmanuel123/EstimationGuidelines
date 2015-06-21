
library(shiny)
if (!require(ggplot2)) {
  stop("This application requires ggplot2. To install it, please run 'install.packages(\"ggplot2\")'.\n")
}
if (!require(plotrix)) {
  stop("This application requires plotrix. To install it, please run 'install.packages(\"plotrix\")'.\n")
}
Complexity <- 1:5
Teamexperience <- 1:5
Account <- c("Development ProofOfConcept", "Development Live Project", "Enhancement")
dataPackage <- c("Data loading and Database","Data visualization","Analysis Reporting","Web interface")
dat <- data.frame(Complexity)
sampleDat <- rbind(data.frame(dat,Teamexperience = Teamexperience[1]),
                   data.frame(dat, Teamexperience = Teamexperience[2]),
                   data.frame(dat, Teamexperience = Teamexperience[3]),
                   data.frame(dat, Teamexperience = Teamexperience[4]),
                   data.frame(dat, Teamexperience = Teamexperience[5]))

sampleDat <- rbind(data.frame(sampleDat,Acount = Account[1]),
                   data.frame(sampleDat, Acount = Account[2]),
                   data.frame(sampleDat, Acount = Account[3]))
sampleDat <- rbind(data.frame(sampleDat,dataPack = dataPackage[1]), data.frame(sampleDat,dataPack = dataPackage[2]), data.frame(sampleDat,dataPack = dataPackage[3]), data.frame(sampleDat,dataPack = dataPackage[4]))
finalDat <- data.frame(sampleDat, Value = runif(length(sampleDat[,1]), 50,200) ,Weight = runif(length(sampleDat[,1]), 5,20))


# Define UI for dataset viewer application
shinyUI(
  pageWithSidebar(
    # Application title
    
    headerPanel("Estimations Predictions for data product development"),
    sidebarPanel(
      textInput("id1","Name of Project:","Project Name X"),
      h3("Scope for project "),
    
      selectInput("Account","Account", as.list(levels(finalDat$Acount)), 
                  selected = NULL, multiple = FALSE),
      selectInput("DataPackage","dataPackage", as.list(levels(finalDat$dataPack)),
                  selected = NULL, multiple = FALSE),
      sliderInput("Complexity", "Complexity of Project  :",
                      min= 1, max= 5, value= 2),
      sliderInput("Teamexperience", "Select average expertise of Team in Programming Language/IDE/Domain:",
                      min= 1, max= 5, value= 3),
      submitButton("Get Estimates", icon = icon("refresh"))
      
    ),
    mainPanel(      
      tabsetPanel(
        tabPanel("Estimation Summary", 
                 h3(textOutput("text")),
                 h4('Input Values'),
                 plotOutput('newHist'),
                 h5('The estimates for project ( in man hours) '),
                 verbatimTextOutput("oid5"),
                 h5("Estimates for the project is approximately +- 20%"),
                 verbatimTextOutput("oid7")
                 
                 ), 
        tabPanel("Documentation", 
                 includeMarkdown("EstimationGuidelines.Rmd")
      )
      )
    )
   )
)