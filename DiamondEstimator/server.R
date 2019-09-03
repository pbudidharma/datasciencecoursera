library(shiny)
library(plotly)
library(ggplot2)
data(diamonds)

shinyServer(function(input, output) {

  data <- eventReactive(input$submit,{
    df <- data.frame(diamonds)
    
    df[,11]=1*(df$cut=="Ideal")
    names(df)[names(df)=="V11"] <- "Ideal"
    df[,12]=1*(df$cut=="Premium")
    names(df)[names(df)=="V12"] <- "Premium"
    df[,13]=1*(df$cut=="Good")
    names(df)[names(df)=="V13"] <- "Good"
    df[,14]=1*(df$cut=="Very Good")
    names(df)[names(df)=="V14"] <- "V_Good"
    df[,15]=1*(df$cut=="Fair")
    names(df)[names(df)=="V15"] <- "Fair"
    names(df)[names(df)=="x"]<- "Length"
    lm(price~carat+Length+Ideal+Premium+Good+V_Good+Fair,data=df)
  
    })
  
  data2 <- eventReactive(input$submit, {
    df <- data.frame(diamonds)
    
    df[,11]=1*(df$cut=="Ideal")
    names(df)[names(df)=="V11"] <- "Ideal"
    df[,12]=1*(df$cut=="Premium")
    names(df)[names(df)=="V12"] <- "Premium"
    df[,13]=1*(df$cut=="Good")
    names(df)[names(df)=="V13"] <- "Good"
    df[,14]=1*(df$cut=="Very Good")
    names(df)[names(df)=="V14"] <- "V_Good"
    df[,15]=1*(df$cut=="Fair")
    names(df)[names(df)=="V15"] <- "Fair"
    names(df)[names(df)=="x"]<- "Length"
      
    car_input <- as.numeric(as.character(input$carat))
    cut_input <- input$cut
    len_input <- input$length
    
    i_input <- ifelse(cut_input == "i",1,0)
    p_input <- ifelse(cut_input == "p",1,0)
    g_input <- ifelse(cut_input == "g",1,0)
    v_input <- ifelse(cut_input == "vg",1,0)
    f_input <- ifelse(cut_input == "f",1,0)
    
    fit <- lm(price~carat+Length+Ideal+Premium+Good+V_Good+Fair,data=df)
    data4=data.frame(carat=car_input,Fair = f_input, Ideal = i_input, Premium = p_input, Good = g_input, V_Good = v_input,Length=len_input)
    temp_pred <- predict(fit,data4,interval="prediction",level=0.95)
    pred <- temp_pred[1]
  })

    output$text1 <- renderText({  
      data2()
    })
  
   output$print1 <- renderPlot({  
     barplot(coefficients(data())[2:7], main="Regression Coefficients")
  })
  
})
