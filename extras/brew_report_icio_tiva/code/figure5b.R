n <- 10

data51 <- data2009[data2009$cou==cou & data2009$ind=='Total' & !data2009$par=='ROW' & data2009$indic%in%c('FDFVASH','FDDVASH'),]
data51 <- merge(data51, namereg, by.x='par')
names(data51) <- sub('country','partner',names(data51))
## share of VA imports
data511 <- data51[data51$indic=='FDFVASH',]
data511$partner <- factor(data511$partner, levels=data511$partner[order(data511$value)])
data511 <- data511[order(-data511$value),]
## Share of VA exports
data512 <- data51[data51$indic=='FDDVASH',]
data512$partner <- factor(data512$partner, levels=data512$partner[order(data512$value)])
data512 <- data512[order(-data512$value),]

## Gross exports
data53 <- data2009[data2009$cou==cou & data2009$ind=='Total' & !data2009$par%in%c('Total','ROW') & data2009$indic=='EXGRSH',]
data53 <- merge(data53, namereg, by.x='par')
names(data53) <- sub('country','partner',names(data53))
data53$partner <- factor(data53$partner, levels=data53$partner[order(data53$value)])
data53 <- data53[order(-data53$value),]

## Gross import share by partner
data54 <- data2009[data2009$cou==cou & data2009$ind=='Total' & !data2009$par%in%c('Total','ROW') & data2009$indic=='IMGRSH',]
data54 <- merge(data54, namereg, by.x='par')
names(data54) <- sub('country','partner',names(data54))
data54$partner <- factor(data54$partner, levels=data54$partner[order(data54$value)])
data54 <- data54[order(-data54$value),]

ylim <- max(max(data54$value),max(data53$value),max(data511$value),max(data512$value))

data55 <- rbind(data512[1:n,], data53[data53$par%in%data512$par[1:n],])
data55$par <- factor(data55$par, levels=data55$par[order(-data55$value[data55$indic=='FDDVASH'])])
data55$indic <- factor(data55$indic, levels=rev(levels(data55$indic)))

data56 <- rbind(data511[1:n,], data54[data54$par%in%data511$par[1:n],])
data56$par <- factor(data56$par, levels=data56$par[order(-data56$value[data56$indic=='FDFVASH'])])

graph1 <- qplot(par, value, data = data55, geom = "bar", fill = indic, stat = "identity", position = "dodge", width = .65) +
    scale_fill_brewer(palette = "Set1",
                      guide = guide_legend(keyheight=.2),
                      name = "",
                      labels = c("Share of VA exports","Share of gross exports")) +
    theme(axis.title.x = element_blank(),
          axis.title.y = element_blank(),
          axis.text.x = element_text(angle=90, hjust=1, vjust=.4, size=axis.text.size),
          axis.text.y = element_text(size=axis.text.size),
          axis.ticks = element_line(linetype = 0),
          legend.position="top",
          legend.text = element_text(size=legend.text.size)
          ) +
    scale_y_continuous(limits = c(0, ylim))

graph2 <-
    qplot(par, value, data = data56, geom = "bar", fill = indic, stat = "identity", position = "dodge", width = .65) +
    scale_fill_brewer(palette = "Set1",
                      guide = guide_legend(keyheight=.2),
                      name = "",
                      labels = c("Share of VA imports","Share of gross imports")) +
    theme(axis.title.x = element_blank(),
          axis.title.y = element_blank(),
          axis.text.x = element_text(angle=90, hjust=1, vjust=.4, size=axis.text.size),
          axis.text.y = element_text(size=axis.text.size),
          axis.ticks = element_line(linetype = 0),
          legend.position="top",
          legend.text = element_text(size=legend.text.size)
          ) +
        scale_y_continuous(limits = c(0, ylim))

grid.arrange(graph1, graph2, nrow=1)

## .par5grex <- data53$par[i] # gross exports
## data54 # gross imports
## data511 # VA imports
## data512 # VA exports
.par55gr <- data55$partner[data55$indic=='EXGRSH']
.share55gr <- round(data55$value[data55$indic=='EXGRSH'])
.par55va <- data55$partner[data55$indic=='FDDVASH']
.share55va <- round(data55$value[data55$indic=='FDDVASH'])
.compare55par <- NULL
for (i in seq(along=.par55gr)) {
    if (.par55gr[i] == .par55va[i]) .compare55par[i] = 'remains' else .compare55par[i] = 'becomes'
}
