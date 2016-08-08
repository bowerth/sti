
## comment: can't include Chinese Taipei becaus value for Eastern Asia is lower than the sum of 7 countries previously used to calculate implicit number for Chinese Taipei

require(dplyr)
require(tidyr)
require(stanData)
## data(STANNAi3)
## data <- DATA.UNSDSNA2013
require(ggplot2)
library(scales)
library(RColorBrewer)

year.last <- 2013
nameyear <- c(1990, 2000, year.last)
nameind <- "C15T37"
namevar <- "VALU"
split.cou <- 6
namecou <- c("CHN", "USA", "JPN", "DEU", "ITA", "KOR", "BRA", "RUS", "FRA", "IND", "GBR", "MEX", "IDN", "ESP", "CAN", "TUR", "AUS", "TWN", "CHE", "THA")

## create colors
twitterblue <- rgb(red = 66, green = 139, blue = 202, maxColorValue = 255)
palette <- colorRampPalette(c("grey20", twitterblue))(length(nameyear)) ## (n)


data.online <- transUNSDSNA(xrates=FALSE
                           ,
                            currency="USD"
                           ,
                            download=FALSE
                           ,
                            destdir=file.path(dbpath, "GitHub", "stanData", "data-raw", "FILE")
                           ,
                            year.min=1970
                            ,
                            countrycode=TRUE
                            )
## h(data.online)

data <- data.online
## add values for China manually

## using dplyr
## data.manuf <- data %>% filter(ind == nameind & year %in% nameyear)
data.manuf <- data %>% filter(ind == nameind)

## begin test: TWN

## ## obtain Taiwan data from difference of East Asia
## ## row 151 from http://unstats.un.org/unsd/snaama/dnltransfer.asp?fID=3
## data.eastasia.manuf.total$cou <- "EastAsia"
## for TWN calculated from East Asia
data.online.region <- transUNSDSNA(xrates=FALSE
                                  ,
                                   currency="USD-REG"
                                  ,
                                   download=FALSE
                                  ,
                                   destdir=file.path(dbpath, "GitHub", "stanData", "data-raw", "FILE")
                                  ,
                                   year.min=1970
                                  ,
                                   countrycode=FALSE
                                   )

## h(data.online.region)
data.eastasia <-
    data.online.region %>%
    filter(cou=="Eastern Asia" & ind==nameind & year%in%nameyear) %>%
        tidyr::spread(key = cou, value = "value") %>%
            dplyr::rename(region = `Eastern Asia`)

## data.eastasia
## h(data.eastasia)
namecou.taiwan <- c("KOR", "MNG", "JPN", "PRK", "MAC", "HKG", "CHN")
## namecou.taiwan.label <- gsub(", ", ".", toString(namecou.taiwan))

data.eastasia.diff <-
    data.manuf %>%
    filter(cou %in% namecou.taiwan) %>%
        group_by(year) %>%
            dplyr::summarise(sum = sum(value))

## filter(data.eastasia.diff, year > 2000)

data.taiwan <- left_join(data.eastasia, data.eastasia.diff) %>%
    mutate(value = region - sum)

data.taiwan$cou <- "TWN"
data.taiwan <- subset(data.taiwan, select = names(data.manuf))
## > left_join(data.eastasia, data.eastasia.diff)
## Joining by: "year"
##    var    ind year Eastern Asia    total
## 1 VALU C15T37 1990     9.23e+11 9.83e+11
## 2 VALU C15T37 2000     1.25e+12 1.51e+12
## 3 VALU C15T37 2013     4.18e+12 4.04e+12
## value in cell AG2112 of Download-GDPcurrent-USD-all.xls:     1246646329581.06
## value in cell AG151  of Download-GDPcurrent-USD-regions.xls: 1246646329581.06

## end test: TWN


## hard code data for China
data.china.yearbook <- rbind.data.frame(c(1990, 0.0268411286553873),
                                        c(2000, 0.0655929105787619))
names(data.china.yearbook) <- c("year", "percentage")
data.china.yearbook <- left_join(data.china.yearbook, data.manuf.total)
data.china.yearbook[["value"]] <- data.china.yearbook[["percentage"]] * data.china.yearbook[["total"]]
data.china.yearbook$cou <- "CHN"
data.china.yearbook$var <- namevar
data.china.yearbook$ind <- nameind
data.china.yearbook <- subset(data.china.yearbook, select = names(data.online))



data.manuf <- rbind(data.manuf, data.taiwan)
data.manuf <- rbind(data.manuf, data.china.yearbook)


## ## calculate "World" as sum of all countries
## by_year <- group_by(data.manuf, year)
## data.manuf.total <- dplyr::summarise(by_year, total = sum(value))

## use total from region "World"
data.manuf.total <-
    data.online.region %>%
    filter(cou=="World" & ind==nameind) %>% #  & year%in%nameyear)
        dplyr::select(year, total = value)


data.calc <- data.manuf %>% left_join(data.manuf.total) %>% mutate(ratio = value / total)
## h(data.calc)
## data.calc[["ratio"]] <- data.calc[["value"]] / data.calc[["total"]]

data.calc.plot <- data.calc %>% filter(cou %in% namecou & year %in% nameyear)
## sort countries according to values
data.calc.plot$cou <- factor(data.calc.plot$cou, levels =
                                 unique(data.calc.plot$cou[order(-data.calc.plot$year, -data.calc.plot$ratio)])
                             )

cou.group1 <- levels(data.calc.plot$cou)[1:split.cou]
## cou.group2 <- setdiff(levels(data.calc.plot$cou), cou.group1)
## length(data.calc.plot$cou)

data.calc.plot$group <- ifelse(data.calc.plot$cou%in%cou.group1, "Group 1" , "Group 2")

ggplot(data = data.calc.plot) +
    geom_bar(aes(x = cou, y = ratio, fill = factor(year)), position = "dodge", stat = "identity") +
    facet_wrap(facets =  ~ group, ncol = 1, scales = "free") +
        scale_y_continuous(labels = percent) +
            theme_minimal() +
                ## scale_fill_brewer(palette="Blues") +
                scale_fill_manual(values = palette) +
                    labs(x = "", y = "") +
                        theme(legend.position = "top") +
                            guides(fill = guide_legend("Year")) ## +
## ggtitle(paste('Top manufacturers in the last 20 years, 1990, 2000 and', year.last))

plotname <- "top_manuf_twn.png"
plotpath <- file.path(dbpath, "GitHub", "jekyll", "industry", "figures", "report_stan_score15")
plotpath.site <- file.path(dbpath, "GitHub", "jekyll", "industry", "_site", "figures", "report_stan_score15")

ggsave(filename = file.path(plotpath, plotname),      width = 8, height = 7, scale = 1, dpi = 90)
ggsave(filename = file.path(plotpath.site, plotname), width = 8, height = 7, scale = 1, dpi = 90)

require(knitr)
require(reshape2)

data.calc.table <- subset(data.calc.plot, select = c("cou", "year", "ratio"))
## data.calc.table <- data.calc.table[order(-data.calc.table$year, -data.calc.table$ratio),]
data.calc.table$ratio <- data.calc.table$ratio * 100
data.calc.table$ratio <- round(data.calc.table$ratio, 2)
data.calc.table <- merge(data.calc.table, STAN.COUEN, all.x = TRUE)
data.calc.table$countryUNen <- as.character(data.calc.table$countryUNen)
data.calc.table$countryUNen[data.calc.table$cou=="TWN"] <- "Chinese Taipei"
## data.calc.table <- dcast(data.calc.table, cou ~ year, value.var = "ratio")
data.calc.table <- dcast(data.calc.table, countryUNen ~ year, value.var = "ratio")
data.calc.table <- data.calc.table[order(-data.calc.table[[as.character(year.last)]]),]
## names(data.calc.table) <- sub("cou", "", names(data.calc.table))
names(data.calc.table) <- sub("countryUNen", "", names(data.calc.table))
kable(x = data.calc.table, row.names = FALSE)
