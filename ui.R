shinyUI(pageWithSidebar(
  headerPanel("Iris Species Random Forest Prediction Model"),
  sidebarPanel(
    p("Try to manipulate the input parameters to see the differences at the output."),
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
      tabPanel("Test Dataset", dataTableOutput("testingTable")),
      tabPanel("About",
               h3("This is a course project of Coursera Data Science - Developing Data Product"),
               p("The purpose of this application is to analyse the impact of 
                  train/test data sets slicing and the number of decision trees parameters 
                  on the prediction accuracy of Random Forest algorithm."),
               p("The data used in this application is taken from the famous 
                 Edgar Anderson's Iris Data."),
               p("Iris is a data frame with 150 cases (rows) and 5 variables (columns) 
                 named Sepal.Length, Sepal.Width, Petal.Length, Petal.Width, and Species.")
      )
    )
  )
))