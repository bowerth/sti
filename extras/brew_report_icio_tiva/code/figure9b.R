data9 <- data2009[data2009$cou==cou & data2009$indic=='EXGRDVA',]

data9$share <- data9$value / data9$value[data9$ind=='Total'] * 100

data9 <- merge(data9, nameind)
industry_wrap <- NULL
for(i in seq(along=nameind$industry)) industry_wrap[i] <- sub('_', '\n', nameind$industry[i])
data9$industry <- factor(data9$industry, levels=nameind$industry, labels=industry_wrap)
data9$col <- 1
## data9$col[data9$ind=='Total'] <- 2
data9 <- data9[!data9$ind%in%c('Total','40T41','45'),] # drop on request


data9a <- data1995[data1995$cou==cou & data1995$indic=='EXGRDVA',]
data9a$share <- data9a$value / data9a$value[data9a$ind=='Total'] * 100

data9a <- merge(data9a, nameind)
industry_wrap <- NULL
for(i in seq(along=nameind$industry)) industry_wrap[i] <- sub('_', '\n', nameind$industry[i])
data9a$industry <- factor(data9a$industry, levels=nameind$industry, labels=industry_wrap)
data9a$col <- 1
## data9a$col[data9a$ind=='Total'] <- 2
data9a <- data9a[!data9a$ind%in%c('Total','40T41','45'),] # drop on request

f9 <- qplot(industry,
            share,
            ## data = data9,
            data = data9,
            geom = "bar",
            stat = "identity",
            ## fill = as.factor(col),
            fill = as.factor(-col),
            width = 0.6,
            position = "stack") +
    scale_fill_manual(guide = "none",
                      values = '#377EB8',
                      ## palette = 'Set1',
                      name="",
                      labels=c("", "1995")) +
    geom_point(data = data9a, aes(x = as.factor(industry), y = share, colour = as.factor(col)), size = 4, shape = 18) +
    geom_point(data = data9a, aes(x = as.factor(industry), y = share), colour = "white", size = 3.5, shape = 18) +
    scale_colour_manual(
        values=c("black"),
        guide = "none",
        ## guide = guide_legend(keyheight=.2),
        name="",
        labels=c("1995")) +
    theme(axis.title.x=element_blank(),
          axis.title.y=element_blank(),
          axis.text.x = element_text(angle=90, hjust=1, vjust=.4, size=axis.text.size),
          axis.text.y = element_text(size=axis.text.size),
          axis.ticks=element_line(linetype=0),
          legend.position="top")
## guides(fill = guide_legend("title", keyheight=.2))
print(f9)

## data9 <- data9[order(data9$variable,-data9$value),1:4]
## .perc21 <- round(data9$value[data9$variable=='EXGR_F'][1])
## .perc22 <- round(data9$value[data9$variable=='EXGR_F'][2])
## .perc24 <- round(data9$value[data9$variable=='EXGR_F'][4])
## .ind21 <- nameind$indlabel[nameind$ind==data9$ind[data9$variable=='EXGR_F'][1]]
## .ind22 <- nameind$indlabel[nameind$ind==data9$ind[data9$variable=='EXGR_F'][2]]
## .ind23 <- nameind$indlabel[nameind$ind==data9$ind[data9$variable=='EXGR_F'][3]]
## .ind24 <- nameind$indlabel[nameind$ind==data9$ind[data9$variable=='EXGR_F'][4]]
