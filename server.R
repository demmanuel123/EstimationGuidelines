if (!require(ggplot2)) {
  stop("This application requires ggplot2. To install it, please run 'install.packages(\"ggplot2\")'.\n")
}
if (!require(plotrix)) {
  stop("This application requires plotrix. To install it, please run 'install.packages(\"plotrix\")'.\n")
}
library(shiny)

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


shinyServer(
  function(input, output) {
 
    h5("server for the project is approximately ")
    
    output$newHist <- renderPlot({
      output$oid1 <- renderPrint({input$Account})
      output$oid2 <- renderPrint({input$DataPackage})
      output$oid3 <- renderPrint({input$Complexity})
      output$oid4 <- renderPrint({input$Teamexperience})
      output$oid5 <- renderPrint({input$id1})

      print(input$Account)
      print(input$DataPackage)
      print(input$Complexity)
      print(input$Teamexperience)
      
      result<- finalDat[which((finalDat$Complexity == input$Complexity) &
                                (finalDat$Teamexperience == input$Teamexperience) & 
                                (finalDat$Acount == input$Account) & 
                                (finalDat$dataPack == input$DataPackage)),]
      print(result)
      
      estimate <- result$Value*result$Weight
      
      hist(finalDat$Value*finalDat$Weight, xlab='Spread of efforts in hours', col='lightblue',main='Histogram')
      print("x")
      
      mu <- mean(finalDat$Value*finalDat$Weight)
      lines(c(mu, mu), c(0, 200),col="red",lwd=5)
      lines(c(estimate, estimate), c(0, 200),col="green",lwd=5)
      
      output$oid7 <- renderPrint({estimate})
      
   })
    
    
#       #finalDat[which((finalDat$Complexity == xComplexity) & (finalDat$Teamexperience == xTeamexperience) & (finalDat$Acount == xaccount) & (finalDat$dataPack == xDataPackage)),]
    
   }
)
