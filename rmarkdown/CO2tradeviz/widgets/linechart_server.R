
output$text1 <- renderText({
  paste(input$var)

})
output$text2 <- renderText({
  paste(indicatortext[[input$var]])
})

output$linechart <- renderPlot({
  ## data_mat <- data_linechart[["indic.EXGR_DoverDFCO2"]]
  ## names(dimnames(data_mat)) <- c("year", "cou", "ind", "ptn")
  ## input <- list(cou = c("AUS", "AUT"), ind = c("CTOTAL"), ptn = c("WOR"))
  ## input <- list(cou = c("AUT"), ind = c("CTOTAL"), ptn = c("WOR"))
  data_mat <- data_linechart[[input$var]]
  dimnames(data_mat) <- ui_dimnames

  ## data_plot <- reshape2::melt(data_mat[, input$cou, input$ind, input$ptn], drop = FALSE)
  data_plot <- reshape2::melt(data_mat[, input$cou, input$ind, input$ptn], drop = FALSE)
  if (length(data_plot)==1) data_plot[["year"]] <- rownames(data_plot)
  ## names(data_plot)
  ## dim <- "cou"
  for (dim in c("cou", "ind", "ptn")) {
    if (length(input[[dim]])==1) data_plot[[dim]] <- input[[dim]]
  }
  data_plot <- subset(data_plot, select = c("year", "cou", "ind","ptn", "value"))
  ## names(data_plot) <- c("year", "cou", "ind","ptn", "value")

  ggplot(data = data_plot, aes(group=ind)) +
    geom_line(aes(x = year, y = value, col = ind, linetype=ind), width = 0.8, stat = "identity") +
    ## geom_line(aes(x = year, y = value, col = ind), width = 0.8, stat = "identity") + # using "linetype" limits to 12 lines max
      facet_grid(ptn ~cou) + # (. ~ ptn) horizontal (ptn ~ .) vertical
      ## scale_y_continuous(limits = c(0, 100)) +
        xlab("Country") +
          ylab("Partner")

})
