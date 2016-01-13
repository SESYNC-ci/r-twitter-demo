
# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Twitter Wordcloud"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("frequency",
                  "Minimum Frequency",
                  min = 5,
                  max = 1500,
                  value = 100,
                  step = 1),
      sliderInput("maxwords",
                  "Maximum Words",
                  min = 1,
                  max = 300,
                  value = 50,
                  step = 1)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("wordcloud")
    )
  )
))