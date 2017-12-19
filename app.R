library("shiny")

ui <- bootstrapPage(
  actionButton("pull", "Pull Master Branch"),
  verbatimTextOutput("result"),
  tableOutput("user")
)

server <- function(input, output) {

  result <- eventReactive(input$pull, {
    system2("git", "pull origin master", stdout = TRUE, stderr = TRUE)
  })

  output$user <- renderTable({
    info <- Sys.info()
    data.frame(variable = names(info), values = unname(info))
  })

  output$result <- renderPrint({
    result()
  })

}

shinyApp(ui, server)