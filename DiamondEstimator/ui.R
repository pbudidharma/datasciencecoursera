library(shiny)
library(plotly)
library(ggplot2)
data(diamonds)

df <- data.frame(diamonds)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Diamond Price Estimator"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      
       textInput("carat",
                   "Carat (range: 0.2 to 5):",value = 2),
       
       radioButtons("cut", "Cut",
                    c("Fair" = "f",
                      "Good" = "g",
                      "Very Good" = "vg",
                      "Premium" = "p",
                      "Ideal" = "i")),
       
       sliderInput("length", "Length(mm):", min = 0.5, max = 10.5, value = 2),
       
       actionButton(inputId = "submit", label = "Submit")
       
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      h5("Estimated price for your diamond :"),
      textOutput("text1"),
      h5(" "),
      plotOutput("print1")
      
       
    )
  )
))
