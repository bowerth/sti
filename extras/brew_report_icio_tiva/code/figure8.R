data8 <- data2009[data2009$cou==cou & !data2009$ind%in%c('40T41','45','50T55','60T64','65T67','70T74','75T95','Total') & data2009$par=='Total' & data2009$indic%in%c('EXGR','EXGR_DDC_SV','EXGR_IDC_SV','EXGR_RIM_SV','EXGR_FVA_SV'),]
data8c <- dcast(data8, year + cou + par + ind ~ indic, value.var = 'value')
data8c$total <- (data8c$EXGR_DDC_SV + data8c$EXGR_IDC_SV + data8c$EXGR_RIM_SV + data8c$EXGR_FVA_SV) / data8c$EXGR * 100
data8c$foreign <- data8c$EXGR_FVA_SV/ data8c$EXGR * 100
data8c$domestic <- data8c$total - data8c$foreign
## do not need total because ordering by ind (not by value)
data8m <- melt(data8c[,colnames(data8c)%in%c('year','cou','par','ind','foreign','domestic')], id.vars = c('year','cou','par','ind'))
data8m <- merge(data8m, nameind)
industry_wrap <- NULL
for(i in seq(along=nameind$industry)) industry_wrap[i] <- sub('_', '\n', nameind$industry[i])
data8m$industry <- factor(data8m$industry, levels=nameind$industry[order(nameind$ind)], labels=industry_wrap)
## change order of stacking
data8m$variable <- factor(data8m$variable, levels=rev(levels(data8m$variable)))

data8a <- data1995[data1995$cou==cou & !data1995$ind%in%c('40T41','45','50T55','60T64','65T67','70T74','75T95','Total') & data1995$par=='Total' & data1995$indic%in%c('EXGR','EXGR_DDC_SV','EXGR_IDC_SV','EXGR_RIM_SV','EXGR_FVA_SV'),]
data8ac <- dcast(data8a, year + cou + par + ind ~ indic, value.var = 'value')
data8ac$total <- (data8ac$EXGR_DDC_SV + data8ac$EXGR_IDC_SV + data8ac$EXGR_RIM_SV + data8ac$EXGR_FVA_SV) / data8ac$EXGR * 100
## data8ac$foreign <- data8ac$EXGR_FVA_SV/ data8ac$EXGR * 100
## data8ac$domestic <- data8ac$total - data8ac$foreign
## do not need total because ordering by ind (not by value)
data8am <- melt(data8ac[,colnames(data8ac)%in%c('year','cou','par','ind','total')], id.vars = c('year','cou','par','ind'))
data8am <- merge(data8am, nameind)
industry_wrap <- NULL
for(i in seq(along=nameind$industry)) industry_wrap[i] <- sub('_', '\n', nameind$industry[i])
data8am$industry <- factor(data8am$industry, levels=nameind$industry[order(nameind$ind)], labels=industry_wrap)
## change order of stacking
## data8am$variable <- factor(data8am$variable, levels=rev(levels(data8am$variable)))
data8am

f8 <- qplot(industry,
            value,
            data = data8m[data8m$variable%in%c('domestic','foreign'),],
            fill = rev(variable),
            order = variable,
            width = 0.4,
            position = "stack",
            geom = "bar",
            stat = "identity") +
    scale_fill_brewer(guide = guide_legend(keyheight=.2),
                      palette = 'Paired',
                      name = "",
                      labels = c("Foreign service contents", "Domestic service contents", "1995 Total", as.character(namereg$country[match(cou, namereg$cou)]))) +
    geom_point(data = data8am, aes(x = industry, y = value), size = 3, shape = 18) +
    geom_point(data = data8am, aes(x = industry, y = value), size = 2.5, shape = 18, colour = "white") +
    theme(axis.title.x = element_blank(),
          axis.title.y = element_blank(),
          axis.text.x = element_text(angle=90, hjust=1, vjust=.4, size=axis.text.size),
          axis.text.y = element_text(size=axis.text.size),
          axis.ticks = element_line(linetype=0),
          legend.position = "top",
          legend.text=element_text(size=legend.text.size)
          )
print(f8)
