

ui <- fluidPage(
  # Application title
  titlePanel("Plot data"),
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      selectInput("variable", 
                  "Variable:",
                  choices = mylist,
                  multiple = TRUE
                  )
    ),
    # Show a plot of the generated distribution
    mainPanel(
      # Output: Formatted text for caption ----
      h3(textOutput("caption")),
      
      # Output: Plot of the requested variable against mpg ----
      plotOutput("plot")
    )
  )
)
# Define server logic to plot various variables against mpg ----
server <- function(input, output) {
  
  # # Compute the formula text ----
  # formulaText <- reactive({
  #   paste("~", paste(input$variable, sep="+"))
  # })
  
  # Return the formula text for printing as a caption ----
  output$caption <- renderText({
    paste("Boxplot for", colnames(tdata)[as.numeric(input$variable)])
  })
  # and only exclude outliers if requested
  output$plot <- renderPlot({
    boxplot(x = tdata[,as.numeric(input$variable)],  col = "#75AADB", pch = 19)
  })
  # output$scatterplot <- renderPlot({
  #   pairs(formulaText(), data=tdata)
  # })
  
}


shinyApp(ui, server)

