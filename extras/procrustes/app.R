## https://rstudio.github.io/shinydashboard/get_started.html

## shiny::runApp(file.path(dbpath, "GitHub", "jekyll", "industry", "extras", "procrustes"), launch.browser = FALSE, port = 3838)

## source("input.R")

library(shiny)
library(shinydashboard)

library(dplyr)
library(tidyr)

library(vegan)

# df2xts <- function(data_df, dateappend) {
#   data_xts <- data_df
#   rownames(data_xts) <- paste0(data_xts$Date, dateappend)
#   data_xts <- subset(data_xts, select=names(data_xts)[!names(data_xts)%in%c("Date")])
#   data_xts <- xts::as.xts(data_xts, dateFormat="Date")
#   return(data_xts)
# }

ui <- dashboardPage(
  dashboardHeader(title = "Procrustes"),
  dashboardSidebar(
    sidebarMenu(
      menuItem("Load CSV", tabName = "loadcsv", icon = icon("table"))
      # ,
      # menuItem("Dygraph", tabName = "dygraph", icon = icon("line-chart"))
      ,
      menuItem("Procrustes", tabName = "procrustes", icon = icon("table"))
      )
    ),
  dashboardBody(
    tabItems(

#       tabItem(tabName = "dygraph",
#               fluidRow(

#                 box(width = 12,
#                     aceEditor("ace_dygraph", mode = "r", value="
# data_xts() %>%
#   dygraph(main = input$title) %>%
#     dyAxis(\"y\", label = input$ylab1) %>%
#     dyAxis(\"y2\", label = input$ylab1) %>%
#       dyOptions(colors = \"#4f81bd\", strokeWidth = 2) %>%
#         dyLegend(width=550, show=\"always\") %>%
#           dyCSS(\"dygraph.css\") %>%
#             dySeries(\"World\", strokePattern = \"dashed\", axis = \"y\")
# ", height = "200px")
#                     ,
#                     actionButton("eval_ace_dygraph", "Evaluate")
#                     )
#                 ,


#                 box(width = 12,
#                     dygraphOutput("dygraph", height = "400px")
#                     ,
#                     downloadButton("download_dygraph", "Download Dygraph")
#                     )

#                 )
#               )

      # ,

      tabItem(tabName = "loadcsv",
              fluidRow(
                box(width = 12,
                    fileInput("csvfile", "CSV File", multiple = FALSE, accept = NULL)
                    # ,
                    # textInput("dateappend", "Date Append", value = "-01-01")
                    # ,
                    # textInput("title", "Title", value = "Figure 3.2. Economic losses from climatological, meteorological and hydrological disasters")
                    # ,
                    # textInput("ylab1", "Left y-Axis label", value = "2014 Billion USD")
                    )

                ,
                # box(width = 2,
                #     tableOutput("xtstable"))
                # ,
                box(width = 10,
                    tableOutput("csvtable"))
                )
              )

      ,
      tabItem(tabName = "procrustes",
        fluidRow(
          box(width = 12,
            selectInput("procrustes_kind", "Plot type", choices = c(1:2), selected = 1)
            ,
            uiOutput("varUI")
            ,
            plotOutput("procrustesplot")
            )))

      )
    )
  )

server <- function(input, output) {

  data_csv <- reactive({

    if (is.null(input$csvfile$datapath) || input$csvfile$datapath == 0) {
      ## setwd("~/Dropbox/GitHub/jekyll/industry/extras/project_programmed_charts/shiny")
      path_csvfile <- file.path("data", "NatureBiotechnology_MAP_v1.txt")
    } else path_csvfile <- input$csvfile$datapath

    data_csv <-
      path_csvfile %>%
        # read.csv()
        read.table(sep = "\t", header = TRUE)
        names(data_csv) <- tolower(names(data_csv))

    return(data_csv)
  })

output$varUI <- renderUI({

selectInput("procrustes_var", label = "Variables", choices = names(data_csv()), selected = c("weight.occurrences.", "weight.co.occurrences.", "score.avg..cit..impact."), multiple = TRUE)

})

  output$csvtable <- renderTable(data_csv())

output$procrustesplot <- renderPlot({

  data_map <- data_csv()

vare.dist <- vegdist(wisconsin(subset(data_map, 
  # select = c("weight.occurrences.", "weight.co.occurrences.", "score.avg..cit..impact.")
  select = input$procrustes_var
  ))) # "x", "y", "cluster", "score.avg..pub..year."
mds.null <- monoMDS(vare.dist, y = cmdscale(vare.dist))
mds.alt <- monoMDS(vare.dist)
vare.proc <- procrustes(mds.alt, mds.null)
# vare.proc
# summary(vare.proc)
plot(vare.proc, kind = input$procrustes_kind)
# plot(vare.proc, kind=2)
# residuals(vare.proc)
})



  # data_xts <- reactive({

  #   # data_xts <- df2xts(data_csv(), dateappend = input$dateappend)
  #   data_xts <- data_csv()

  #   return(data_xts)

  # })

  # output$xtstable <- renderTable(
  #   data.frame(Date = as.character(time(data_xts())))
  #   )

  # .dygraph <- reactive({
  #   input$eval_ace_dygraph
  #   return(isolate(eval(parse(text=input$ace_dygraph))))
  # })

  # output$dygraph <- renderDygraph({
  #   .dygraph()
  # })

  # output$download_dygraph <- downloadHandler(
  #   filename = function() {
  #     paste0(input$title, '.html')
  #   },
  #   content = function(file) {
  #     htmlwidgets:::saveWidget(widget = .dygraph(), file = file, selfcontained = TRUE, libdir = NULL)
  #   }
  #   )

}

shinyApp(ui, server)
