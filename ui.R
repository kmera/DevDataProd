library(shiny)
library(readxl)
library(dplyr)
library(ggplot2)

shinyUI(fluidPage(
    titlePanel("Mobile Subscribers in Ecuador - 2015"),
    sidebarLayout(
        sidebarPanel(
            em("This App was created as Final Project of Developing Data Products Course,
              and shows the Mobile Subscribers of Ecuador from 2008 to 2015."),
            hr(),
            strong("Instructions 'Exploratory' Tab:"),
            p("1. Choose one of the Group by option"),
            p("2. Choose one of the meas for the plot"),
            selectInput("group_in", "Select Group by:", 
                        c("Year", "Operator")),
            selectInput("meas_in", "Select Meas Type for the Plot:", 
                        c("Mean", "Total")),
            p("There are a table and a plot related to the selections 
              made in step 1 and 2."),
            hr(),
            h3("SLIDER ONLY USE FOR PREDICTION TAB"),
            strong("Instructions 'Prediction' Tab:"),
            p("1. Select 'Prediction' Tab"),
            p("2. Move the Slider"),
            sliderInput("slider_in", "What's the year for Susbscribers' Prediction?",
                        min = 2008, max = 2015, value = 2008),
            p("There are a plot with a red point located at the slider value,
              and the text shows the predicted value.")
            ),
        
        mainPanel(
            tabsetPanel(type = "tabs",
                        tabPanel("Exploratory", br(), 
                                 tableOutput("data"), plotOutput("plot1")),
                        tabPanel("Prediction", br(), 
                                 plotOutput("plot2"), 
                                 h3("Predicted Subscribers (in Millons):"),
                                 textOutput("pred1")))
        )
    )
))
