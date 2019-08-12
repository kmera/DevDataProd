library(shiny)
library(readxl)
library(dplyr)
library(ggplot2)

shinyServer(function(input, output) {

    output$data <- renderTable({
        if(input$group_in == "Year") {
            by_year
        }
        else {
            if (input$group_in == "Operator") {
                by_operator
            }
        }
    })
    
    output$plot1 <- renderPlot({
        if(input$group_in == "Year") {
            if(input$meas_in == "Total") {
                plot_by_year_total
            }
            else {
                plot_by_year_mean
            }
        }
        else {
            if (input$group_in == "Operator") {
                if(input$meas_in == "Total") {
                    plot_by_operator_total
                }
                else {
                    plot_by_operator_mean
                }
            }
        }
    })
    
    fit1pred <- reactive({
        subsInput <- input$slider_in
        predict(fit1, newdata = data.frame(Year = subsInput))
    })
    
    output$plot2 <- renderPlot({
        subsInput <- input$slider_in
        plot(by_year$Year, by_year$TotalSubscribers1,
             xlab = "Year", ylab = "Total Subscribers (in Millons)",
             bty = "n", pch = 16, xlim = c(2008, 2015))
        abline(fit1, col = "red", lwd = 2)
        points(subsInput, fit1pred(), col = "red", pch = 16, cex = 2)
    })
    
    output$pred1 <- renderText({
        fit1pred()
    })
})
