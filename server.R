
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

source("CignaApi.R")
source("environment.R")

if (!require("rjson")){
  install.packages("rjson")
  library(rjson)
}




library(shiny)

shinyServer(function(input, output, session) {
   
  output$distPlot <- renderPlot({
     
    # generate and plot an rnorm distribution with the requested
    # number of observations
    dist <- rnorm(input$obs)
    hist(dist)
    
  })
  
  
  authenticated <- FALSE
  
  output$paramList <- reactive({
    
    query <- parseQueryString(session$clientData$url_search)

    if (!is.null(query$code)){

      response <- getCignaAccessToken(environment$clientId, environment$clientSecret, query$code, environment$redirectUri, state = NULL, test=TRUE)
      authenticated <- TRUE
      
    } else {
      
      paste('noResponse', session$clientData$url_search, sep=", ", collapse=", ")
      
    }
    
  })
  
})
