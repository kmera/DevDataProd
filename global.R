library(openxlsx)
library(dplyr)
library(ggplot2)

mobile_ec <- read.xlsx("http://catalogo.datosabiertos.gob.ec/dataset/80cdcc38-ae02-4c4a-9c32-e19973790bbb/resource/575dcf3d-167b-4ddb-a4dc-6ebf11694246/download/datasetlineas-activas.xlsx",
                       startRow = 2)
colnames(mobile_ec)
new_colnames <- c("Year", "Month", "Operator", "Service", "Technology",
                  "Subscribers")
names(mobile_ec) <- new_colnames
mobile_ec$Year <- as.integer(mobile_ec$Year)

by_year <- mobile_ec %>% group_by(Year) %>% 
        summarize(TotalSubscribers1 = sum(Subscribers/1000000),
                  MeanSubscribers1 = mean(Subscribers/1000000))

plot_by_year_total <- by_year %>% ggplot(aes(Year, TotalSubscribers1)) +
        geom_line() +
        xlab("Year") + ylab("Total Subscribers (in Millons)") +
        ggtitle("Total Mobile Subscribers per Year")

plot_by_year_mean <- by_year %>% ggplot(aes(Year, MeanSubscribers1)) +
        geom_line() +
        xlab("Year") + ylab("Mean Subscribers (in Millons)") +
        ggtitle("Mean Mobile Subscribers per Year")

by_operator <- mobile_ec %>% group_by(Operator) %>% 
        summarize(TotalSubscribers2 = sum(Subscribers/1000000),
                  MeanSubscribers2 = mean(Subscribers)/1000000)

plot_by_operator_mean <-  by_operator %>% ggplot(aes(Operator, MeanSubscribers2, 
                                                     fill = Operator)) +
        geom_col() +
        xlab("Operator") + ylab("Mean Subscribers (in Millons)") +
        ggtitle("Mean Mobile Subscribers per Operator")

plot_by_operator_total <-  by_operator %>% ggplot(aes(Operator, TotalSubscribers2, 
                                                      fill = Operator)) +
        geom_col() +
        xlab("Operator") + ylab("Total Subscribers (in Millons)") +
        ggtitle("Total Mobile Subscribers per Operator")

fit1 <- lm(TotalSubscribers1 ~ Year, data = by_year)
