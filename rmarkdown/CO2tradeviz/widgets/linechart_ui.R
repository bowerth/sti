
linechart.col1 <- column(width = 12,
                         box(
                           ## width = 6,
                           width = 4,
                           ## inputPanel(
                           selectInput("cou", "Country:",
                                       choices = ui_dimnames[[2]],
                                       selected = c("AUS", "AUT"),
                                       multiple = TRUE
                                       )
                             )
                         ,
                         box(width = 4,
                           selectInput("ind", "Industry:",
                                       choices = ui_dimnames[[3]],
                                       selected = c("C01T05", "C10T14"),
                                       multiple = TRUE
                                       )
                             )
                         ,
                         box(width = 4,
                           selectInput("ptn", "Partner:",
                                       choices = ui_dimnames[[4]],
                                       selected = c("OECD", "WOR"),
                                       multiple = TRUE
                                       )
                             )
                             ## )
                           ,
                         box(width = 12,
                           selectInput("var", "Indicator:",
                                       choices = indicatorlist,
                                       ## selected = indicatorlist[[1]],
                                       selected = indicatorlist[1],
                                       multiple = FALSE
                                       )
                             )
                           
                           ,
                           box(width = 12,
                             plotOutput("linechart", # better: linechart_ggplot
                                        height = 600)

                               ## ,
                               ## list(
                               ##   p("List:", a(href = "http://www.oecd.org/sti/ind/ICIO2015_Industries_Items.pdf", "ICIO 2015 Industry Items"))
                               ##   )
                               )
                         ,
                         box(width = 3,
                             verbatimTextOutput("text1")
                             )
                         ,
                         box(width = 9,
                             verbatimTextOutput("text2")
                             )

                         )
