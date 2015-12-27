shinyUI(pageWithSidebar(
  headerPanel("Iris Species Random Forest Prediction Model"),
  sidebarPanel(
        p("The purpose of this application is to analyse the impact of 
          train/test data sets slicing and the number of decision trees parameters 
          on the prediction accuracy of Random Forest algorithm."),
        hr(),
        radioButtons(inputId = "ratio", label = "Train : Test dataset partition ratio:", 
                     choices = c("80% : 20%" = "0.8",
                                 "70% : 30%" = "0.7",
                                 "60% : 40%" = "0.6",
                                 "50% : 50%" = "0.5")),
    sliderInput(inputId = "numberOfTrees", label="Number of Decision Trees:",
                min = 1, max = 200, value = 50, step = 1)
  ),
  mainPanel(
    tabsetPanel(
      id = "dataset",
      tabPanel("Prediction Model", 
               verbatimTextOutput('textTrainCount'),
               verbatimTextOutput('textTestCount'),
               p("Calculated accuracy:"), textOutput("textAccuracy"),
               plotOutput("plotAccuracy")
      ),
      tabPanel("Train Dataset", dataTableOutput("trainingTable")),
      tabPanel("Test Dataset", dataTableOutput("testingTable"))  
    )
  )
))