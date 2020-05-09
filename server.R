
output_cv2 = data.frame(svm = cv_50acc5_svm_2, rf = cv_50acc5_rf_2, knn = cv_50acc5_knn_2)
output_cv3 = data.frame(svm = cv_50acc5_svm_3, rf = cv_50acc5_rf_3, knn = cv_50acc5_knn_3)
output_cv4 = data.frame(svm = cv_50acc5_svm_4, rf = cv_50acc5_rf_4, knn = cv_50acc5_knn_4)
output_cv5 = data.frame(svm = cv_50acc5_svm_5, rf = cv_50acc5_rf_5, knn = cv_50acc5_knn_5)
output_cv6 = data.frame(svm = cv_50acc5_svm_6, rf = cv_50acc5_rf_6, knn = cv_50acc5_knn_6)




output_boxplot <- list(output_cv2, output_cv3,output_cv4,output_cv5,output_cv6)

#Define UI for application that draws a histogram
ui <- fluidPage(
  # Application title
  titlePanel("change cv"),
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      
      selectInput("variable", "Cross Validation",
                  c("2" = "1",
                    "3" = "2",
                    "4" = "3",
                    "5" = "4",
                    "6" = "5"))
    ),
    # Show a plot of the generated distribution
    mainPanel(
      # Output: Formatted text for caption ----
      h3(textOutput("caption")),
      
      # Output: Plot of the requested variable against mpg ----
      plotOutput("mpgPlot")
      
    )
  )
)


# Define server logic to plot various variables against mpg ----
server <- function(input, output) {

  # and only exclude outliers if requested

  output$mpgPlot <- renderPlot({
    boxplot(list(SVM = output_boxplot[[as.numeric(input$variable)]]$svm,
                 RF = output_boxplot[[as.numeric(input$variable)]]$rf,
                 KNN = output_boxplot[[as.numeric(input$variable)]]$knn),
            col = "#75AADB", pch = 19)
  })
  
}

shinyApp(ui, server)

