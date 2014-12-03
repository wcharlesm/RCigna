
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#


#paste(names(query), query, sep = "=", collapse=", ")

source("CignaApi.R")
source("environment.R")

if (!require("httpuv")) {
  install.packages("httpuv")
  library(httpuv)
}

library(shiny)


shinyUI(pageWithSidebar(
  
  # Application title
  headerPanel("New Application"),
  
  
  # Sidebar with a slider input for number of observations
  sidebarPanel(
    sliderInput("obs", 
                "Number of observations:", 
                min = 1, 
                max = 1000, 
                value = 500),
    cignaSignInButton(clientId = environment$clientId, 
                      scope=c("phone","email","address","profile","openid"), 
                      redirectUri= environment$redirectUrl),
    p(verbatimTextOutput("paramList"))
    
  ),
  
  
  # Show a plot of the generated distribution
  mainPanel(
    plotOutput("distPlot")
  )
))
