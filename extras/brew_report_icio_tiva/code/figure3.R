data3 <- data2009[data2009$cou==cou & data2009$par=='Total' & data2009$indic=='REI',]
data3 <- merge(data3, nameind)
industry_wrap <- NULL
for(i in seq(along=nameind$industry)) industry_wrap[i] <- sub('_', '\n', nameind$industry[i])
data3$industry <- factor(data3$industry, levels=nameind$industry, labels=industry_wrap)
data3$col <- 2
data3$col[data3$ind=='Total'] <- 1
data3 <- data3[!data3$ind=='45',] # removed upon request

data3a <- data1995[data1995$cou==cou & data1995$par=='Total' & data1995$indic=='REI',]
data3a <- merge(data3a, nameind)
industry_wrap <- NULL
for(i in seq(along=nameind$industry)) industry_wrap[i] <- sub('_', '\n', nameind$industry[i])
data3a$industry <- factor(data3a$industry, levels=nameind$industry, labels=industry_wrap)
data3a$col <- 1
data3a$col[data3a$ind=='Total'] <- 1
data3a <- data3a[!data3a$ind=='45',] # removed upon request

f3 <- qplot(industry,
            value,
            data = data3,
            geom = "bar",
            stat = "identity",
            fill = as.factor(col),
            width=0.4) +
    scale_fill_brewer(guide = "none",
                      palette = 'Set1') +
    geom_point(data = data3a, aes(x = industry, y = value, colour = as.factor(col)), size = 3, shape = 18) +
    geom_point(data = data3a, aes(x = industry, y = value), size = 2.5, shape = 18, colour = "white") +
    scale_colour_manual(values = c("black"),
                        guide = "none",
                        ## guide = guide_legend(keiheight=.2),
                        name = "",
                        labels = c("1995")) +
    theme(axis.title.x = element_blank(),
          axis.title.y = element_blank(),
          axis.text.x = element_text(angle=90, hjust=1, vjust=.4, size=axis.text.size),
          axis.text.y = element_text(size=axis.text.size),
          axis.ticks = element_line(linetype=0), legend.position="top")
print(f3)

data3 <- data3[order(-data3$value),]
.perc3 <- round(data3$value[!data3$ind=='Total'][1:6])
.ind3 <- NULL
for(i in c(1:6)) .ind3[i] <- as.character(nameind$indlabel[nameind$ind==data3$ind[!data3$ind=='Total'][i]])
.perc3total <- round(data3$value[data3$ind=='Total'])
