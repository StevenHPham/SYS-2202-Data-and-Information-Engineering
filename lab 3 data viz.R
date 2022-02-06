library(gcookbook)
data("heightweight")
str(heightweight)
library(ggplot2)
data("mpg")
ggplot(mpg, aes(x=factor(cyl))) + geom_bar() + facet_wrap(~drv)
ggplot(mpg, aes(x=factor(cyl), fill=factor(year))) +
  geom_bar(position="fill")
#install.packages("shiny")
library(shiny)
ui <- fluidPage()
server = function(input, output, session){}
shinyApp(ui= ui, server = server)
