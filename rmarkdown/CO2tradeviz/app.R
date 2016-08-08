
## shiny::runApp(appDir = file.path(dbpath, "GitHub", "jekyll", "industry", "rmarkdown", "CO2tradeviz"), port = 3838, launch.browser = FALSE)

source("global.R")
source(file.path("widgets", "linechart_ui.R"))

ui <- dashboardPage(
  dashboardHeader(title = "CO2 Trade Viz", disable = TRUE),
  dashboardSidebar(disable = TRUE,
    sidebarMenu(
      menuItem("Linechart", tabName = "linechart", icon = icon("line-chart"))
      )
    ),
  dashboardBody(
    tabItems(
      tabItem("linechart",
              fluidRow(linechart.col1)
              )
      )
    )
  )
  
server <- function(input, output) {

  source(file.path("widgets", "linechart_server.R"), local = TRUE)

}

shinyApp(ui, server, options = list(height = 800))
