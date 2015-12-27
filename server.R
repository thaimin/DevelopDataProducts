library(shiny)
library(ggplot2)
library(caret)
library(randomForest)
require(e1071)
data(iris)

plotPrediction <- function(ratio, nTree){
  inTrain <- createDataPartition(y=iris$Species, p=ratio, list=FALSE)
  training <- iris[inTrain,]
  testing <- iris[-inTrain,]
  
  modFit <- randomForest(Species ~ ., data = training, ntree = nTree)
  pred <- predict(modFit, testing)
  testing$predRight <- pred==testing$Species
  qplot(Petal.Width, Petal.Length, colour=predRight, data=testing, main="Predictions Accuracy")
}

shinyServer(
  function(input, output){
    
    training <- reactive({
      inTrain <- createDataPartition(y=iris$Species, p=as.double(input$ratio), list=FALSE)
      iris[inTrain,]
    })
    testing <- reactive({
      inTrain <- createDataPartition(y=iris$Species, p=as.double(input$ratio), list=FALSE)
      iris[-inTrain,]
    })
    
    cm <- reactive({
      training <- training()
      testing <- testing()
      modFit <- randomForest(Species ~ ., data = training, ntree = as.integer(input$numberOfTrees))
      pred <- predict(modFit, testing)
      testing$predRight <- pred==testing$Species
      confusionMatrix(pred, testing$Species) 
    })

    output$textTrainCount <- renderText({ 
      paste("Number of train data: ", as.character(dim(training())[1])) 
    })
    output$textTestCount <- renderText({ 
      paste("Number of test data: ", as.character(dim(testing())[1])) 
    })
    output$textAccuracy <- renderText({
      cm <- cm()
      paste(as.character(cm$overall[1] * 100), "%")
    })
    output$plotAccuracy <- renderPlot({
      plotPrediction(as.double(input$ratio), as.integer(input$numberOfTrees))
    })
    
    output$trainingTable <- renderDataTable({ training() })
    output$testingTable <- renderDataTable({ testing() })
    
  }
)
