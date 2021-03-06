data1 <- data2009[data2009$cou%in%namereg$cou & data2009$indic=='EXGRDVA_EX' & data2009$ind=='Total',]
data1$cou <- factor(data1$cou, levels = data1$cou[order(data1$value)])
data1$col <- 1
data1$col[data1$cou==cou] <- 0

data1a <- data1995[data1995$cou%in%namereg$cou & data1995$indic=='EXGRDVA_EX' & data1995$ind=='Total',]
data1a$cou <- factor(data1a$cou, levels = data1a$cou[order(data1a$value)])
data1a$col <- 1
data1a$col[data1a$cou==cou] <- 0

.perc1 <- round(data1$value[data1$cou==cou])
avrg1 <- round(mean(data1$value[data1$cou%in%oecd]))
if(.perc1 >= (avrg1 + 5)) .rel1 <- 'above' else if(.perc1 < (avrg1 - 5)) .rel1 <- 'below' else .rel1 <- 'around'

f1 <- qplot(cou,
            value,
            data = data1,
            geom = "bar",
            stat = "identity",
            fill = as.factor(col),
            width=0.4,
            position = position_dodge(width=0.5)) +
    scale_fill_brewer(guide = "none",
                      palette = 'Set1') +
    geom_hline(yintercept = avrg1, colour = "grey50", size = 0.5, linetype = 2) +
  geom_point(data = data1a, aes(x = as.factor(cou), y = value, colour  = as.factor(col)), size = 3, shape = 18) +
    geom_point(data = data1a, aes(x = as.factor(cou), y = value), colour  = "white", size = 2.5, shape = 18) +
    scale_colour_brewer(
        guide = "none",
        ## guide = guide_legend(keyheight=.2),
        palette = 'Set1',
        name="",
        labels=c("", "1995")) +
    theme(axis.title.x=element_blank(),
          axis.title.y=element_blank(),
          axis.text.x = element_text(angle=90, hjust=1, vjust=.4),
          axis.text.y = element_text(size=axis.text.size),
          axis.ticks=element_line(linetype=0),
          legend.position="top")
print(f1)
