
## comment: can't include Chinese Taipei becaus value for Eastern Asia is lower than the sum of 7 countries previously used to calculate implicit number for Chinese Taipei

require(dplyr)
require(tidyr)
require(stanData)
## data(STANNAi3)
## data(STANNAi4)
## data <- DATA.UNSDSNA2013
require(ggplot2)
library(scales)
library(RColorBrewer)

year.last <- 2013
nameyear <- c(1990, 2000, year.last)
nameyear <- year.last
namevar <- "VALU"

nameind <- c("B1GVA", "B1GVB_E", "B1GVF", "B1GVO_U", "B1GVG_N") # also reverse order
nameind.label <- c('Agriculture', 'Industry', 'Construction', '"Non-market" services', '"Market" services')
nameind.label.df <- cbind.data.frame(nameind, nameind.label)
names(nameind.label.df) <- c("ind", "label")

## create colors
twitterblue <- rgb(red = 66, green = 139, blue = 202, maxColorValue = 255)
palette <- colorRampPalette(c("grey20", twitterblue))(length(nameind)) ## (n)

namecou <- c("AUS", "AUT", "BEL", "CAN", "CHL", "CZE", "DNK", "EST", "FIN", "FRA", "DEU", "GRC", "HUN", "ISL", "IRL", "ISR", "ITA", "JPN", "KOR", "LUX", "MEX", "NLD", "NZL", "NOR", "POL", "PRT", "SVK", "SVN", "ESP", "SWE", "CHE", "TUR", "GBR", "USA", "BRA", "CHN", "IND", "IDN", "RUS", "ZAF")

## cat(paste0('c("', namecou, '", "", ""),\n'))
## metadata <- rbind.data.frame(
## )

## require(RODBC)
## SQL.STAT <-odbcDriverConnect(connection = "SERVER=VS-DOTSTAT-SQL3; DRIVER={SQL Server}; DATABASE=DOTSTAT; TRUSTED_CONNECTION=TRUE")
datasetcode <- "SNA_TABLE1"
namedim <- dotStatGetDimensionList(channel = SQL.STAT,
                                   datasetcode = datasetcode,
                                   lang = "en")

dim.list <- lapply(namedim, dotStatGetDimensionMemberList,
                   channel = SQL.STAT,
                   datasetcode = datasetcode,
                   lang = "en")
names(dim.list) <- namedim

## setdiff(namecou, dim.list[["LOCATION"]])
## dim.list[["TRANSACT"]]
## transact_codes <- c("B1G", "B1GA_B", "B1GC_E", "B1GD", "B1GF", "B1GG_I", "B1GJ_K", "B1GL_P", "B1GVA", "B1GVB_E", "B1GVC", "B1GVF", "B1GVG_I", "B1GVJ", "B1GVK", "B1GVL", "B1GVM_N", "B1GVO_Q", "B1GVR_U") # "GDP", "B1_GA", "B1G_P119",
transact_codes <- c("B1G", "B1GVA", "B1GVB_E", "B1GVF", "B1GVG_I", "B1GVJ", "B1GVK", "B1GVL", "B1GVM_N", "B1GVO_Q", "B1GVR_U") # "GDP", "B1_GA", "B1G_P119", "B1GVC",
## dim.list[["MEASURE"]]
mktserv <- c("B1GVG_I", "B1GVJ", "B1GVK", "B1GVL", "B1GVM_N")
nmktserv <- c("B1GVO_Q", "B1GVR_U")
## market: D45T82: G-N
## non-market: D84T99: O-U

dim.list.sna1 <- list(LOCATION = namecou,
                      TRANSACT = transact_codes,
                      MEASURE = "C" # current prices
                      )

data.sna1.dotstat <- dotstatGetData(channel = SQL.STAT,
                            datasetcode = "SNA_TABLE1",
                            dim.list = dim.list.sna1,
                            time = c(2011, 2014))

data.sna1 <- data.sna1.dotstat
## max(data.sna1$TIME)
names(data.sna1) <- tolower(names(data.sna1))

data.sna1 <- data.sna1 %>%
    tidyr::spread(key = transact, value = "value") %>% # show variables in columns
    filter(!location %in% c("CHN", "RUS", "ZAF")) %>% # only B1G
    filter(!location %in% c("CHL")) %>% # sector L missing
    filter(!location %in% c("JPN")) %>% # sector M_N missing
    filter(!(location %in% c("CZE") & time == 2014)) # sector F missing in 2014
## remove: RUS, ZAF, CHN
## remove: CZE 2014

latestyear_by_country <- data.sna1 %>% group_by(location) %>% dplyr::summarise(time = max(time))
## h(data.sna1)
data.sna1.latest <- right_join(data.sna1, latestyear_by_country)

## "B1GVO_Q" "B1GVR_U" # nmktserv
## data.sna1.latest %>% mutate(B1GVO_U = B1GVO_Q + B1GVR_U)

data.sna1.m <- data.sna1.latest %>% tidyr::gather(transact, value, -location, -measure, -time)

data.sna1.m.total <- filter(data.sna1.m, transact == "B1G") %>% subset(select = c("location", "value"))
names(data.sna1.m.total) <- sub("value", "total", names(data.sna1.m.total))
## data.sna1.m.total

data.sna1.plot <-
    data.sna1.m %>%
    left_join(data.sna1.m.total, by = "location") %>%
        mutate(value = value / total) %>%
            dplyr::select(-total) %>%
                tidyr::spread(key = transact, value = "value") %>%
                    mutate(B1GVG_N = B1GVG_I + B1GVJ + B1GVK + B1GVL + B1GVM_N,
                           B1GVO_U = B1GVO_Q + B1GVR_U) %>%
                               gather(transact, value, -location, -measure, -time) %>%
                                   filter(transact %in% nameind)

data.sna1.plot$transact <- factor(data.sna1.plot$transact, levels = rev(nameind))
## factor(data.sna1.plot$transact)

ggplot(data = data.sna1.plot) +
    geom_bar(aes(x = location, y = value, fill = transact, order = transact), position = "stack", stat = "identity") +
        theme_minimal() +
            scale_y_continuous(labels = percent) +
                scale_fill_manual(values = palette, labels = rev(nameind.label)) +
                    labs(x = "", y = "") +
                        theme(legend.position = "top",
                              axis.text.x = element_text(angle = 45, hjust = 1)) +
                                  guides(fill = guide_legend("Activity"))

ggsave(filename = file.path(dbpath, "GitHub", "jekyll", "industry", "figures", "report_stan_score15", "gdp_composition.png"), width = 8, height = 5, scale = 1, dpi = 90)
## ggsave(filename = file.path(dbpath, "GitHub", "jekyll", "industry", "_site", "figures", "report_stan_score15", "gdp_composition.png"), width = 8, height = 5, scale = 1, dpi = 90)



require(knitr)
require(reshape2)

data.sna1.table <- subset(data.sna1.plot, select = c("location", "transact", "value"))
## data.sna1.table <- data.sna1.table[order(-data.sna1.table$year, -data.sna1.table$ratio),]
data.sna1.table$value <- data.sna1.table$value * 100
data.sna1.table$value <- round(data.sna1.table$value, 2)
data.sna1.table <- merge(data.sna1.table, nameind.label.df, by.x = "transact", by.y = "ind")

data.sna1.table <- dcast(data.sna1.table, location ~ label, value.var = "value")
data.sna1.table <- subset(data.sna1.table, select = c("location", rev(nameind.label)))
names(data.sna1.table) <- sub("location", "", names(data.sna1.table))
kable(x = data.sna1.table, row.names = FALSE)

## test: facetting


ggplot(data = data.sna1.plot) +
    geom_bar(aes(x = location, y = value, fill = transact, order = transact), position = "stack", stat = "identity") +
        facet_grid(transact ~ .,
                   scales = "free") +
        theme_minimal() +
            scale_y_continuous(labels = percent) +
                scale_fill_manual(values = palette, labels = rev(nameind.label)) +
                    labs(x = "", y = "") +
                        theme(legend.position = "top",
                              axis.text.x = element_text(angle = 45, hjust = 1)) +
                                  guides(fill = guide_legend("Activity"))

ggsave(filename = file.path(dbpath, "GitHub", "jekyll", "industry", "figures", "report_stan_score15", "gdp_composition_facet.png"), width = 8, height = 8, scale = 1, dpi = 90)
ggsave(filename = file.path(dbpath, "GitHub", "jekyll", "industry", "_site", "figures", "report_stan_score15", "gdp_composition_facet.png"), width = 8, height = 8, scale = 1, dpi = 90)


## add data from UNMADT
unique(data.sna1.plot$location)
setdiff(namecou, data.sna1.plot$location)
# "CAN" "CHL" "JPN" "CHN" "IND" "RUS" "ZAF"
require(stanData)
data(STANNAi4)

## DATA.UNDATA206SNA93
## namecou.add <- c("CAN", "CHL", "JPN", "CHN", "IND", "RUS", "ZAF")
year.last.add <- year.last-2 # 2011
namecou.add <- c("RUS", "ZAF")
## unique(DATA.UNDATA206SNA08$ind)
## unique(DATA.UNDATA203CON$ind)
## nameind.unsd.i4 <-  c("DTOTAL", "D01T03", "D05T39", "D41T43", "D45T56", "D58T63", "D64T66", "D68", "D69T82", "D84T88", "D97T98", "D86T88")
nameind.unsd.i3 <- c("CTOTAL", "C01T05", "C10T14", "C15T37", "C40T41", "C45", "C50T55", "C60T64", "C65T74", "C75", "C80T93", "C95")
nameind.label.df.unsd <- cbind.data.frame(nameind.label.df, data.frame(ind.unsd = c("C01T05", "C10T41", "C45", "C75T95", "C50T74")))
##       ind                 label ind.unsd
## 1   B1GVA           Agriculture   C01T05
## 2 B1GVB_E              Industry   C10T37
## 3   B1GVF          Construction      C45
## 4 B1GVO_U "Non-market" services   C75T95
## 5 B1GVG_N     "Market" services   C50T74

data.plot.all <-
    data.sna1.plot %>%
    dplyr::select(-measure) %>%
    dplyr::rename(ind = transact, cou = location, year = time, share = value) %>%
    right_join(nameind.label.df) %>% tbl_df

data.unsd <- DATA.UNDATA203CON
data.add <-
    data.unsd %>%
    filter(cou %in% namecou.add & ind %in% nameind.unsd & var %in% namevar & year %in% year.last.add)

data.total <-
    data.add %>%
        filter(ind == "CTOTAL") %>%
            dplyr::rename(total = value)

data.add.share <-
    data.total %>%
        dplyr::select(-var, -ind, -year) %>%
            right_join(data.add) %>%
                mutate(share = value / total) %>%
                    dplyr::select(-total, -value) %>%
                        tidyr::spread(ind, value = "share") %>%
                            mutate(C10T41 = C10T14 + C15T37 + C40T41,
                                   C50T74 = C50T55 + C60T64 + C65T74,
                                   C75T95 = C75 + C80T93 + C95) %>%
                                tidyr::gather(ind, share, -cou, -var, -year) %>%
                                    dplyr::select(-var)

data.plot.add <-
    data.add.share %>%
    dplyr::rename(ind.unsd = ind) %>%
        right_join(nameind.label.df.unsd) %>%
            ## dplyr::select(-ind.unsd)
            subset(select = names(data.plot.all))

data.plot.all.2 <- rbind(data.plot.all,
                       data.plot.add)

coulist.2013 <- data.plot.all.2 %>% filter(year==2013) %>% dplyr::select(cou)
## coulist.2014 <- data.plot.all.2 %>% filter(year==2014) %>% dplyr::select(cou)

coulist.2013.label <- STAN.COUEN$countryUNen[STAN.COUEN$cou%in%collect(coulist.2013)[[1]]]
toString(coulist.2013.label)

## data.plot.all.2$ind <- factor(data.plot.all.2$ind, levels = rev(nameind))
data.plot.all.2$label <- factor(data.plot.all.2$label, levels = rev(nameind.label))
data.plot.all.2$cou <- factor(data.plot.all.2$cou, levels = namecou)

namecou.briics <- namecou[!namecou%in%STAN.COU[["OECD"]]]
data.plot.all.2$group <- "OECD"
data.plot.all.2$group[data.plot.all.2$cou%in%namecou.briics] <- "BRIICS"
data.plot.all.2$group <- factor(data.plot.all.2$group, levels = rev(sort(unique(data.plot.all.2$group))))

plotpath <- file.path(dbpath, "GitHub", "jekyll", "industry", "figures", "report_stan_score15")
plotpath.site <- file.path(dbpath, "GitHub", "jekyll", "industry", "_site", "figures", "report_stan_score15")

ggplot(data = data.plot.all.2) +
    geom_bar(aes(x = cou, y = share, fill = label, order = label), position = "stack", stat = "identity") +
        facet_grid(. ~ group,
                   scales = "free",
                   space = "free_x") +
        theme_minimal() +
            scale_y_continuous(labels = percent) +
                ## scale_fill_manual(values = palette, labels = rev(nameind.label)) +
                scale_fill_manual(values = palette) +
                    labs(x = "", y = "") +
                        theme(legend.position = "top",
                              axis.text.x = element_text(angle = 45, hjust = 1)) +
                                  guides(fill = guide_legend("Activity"))

plotname <- "gdp_composition.png"
ggsave(filename = file.path(plotpath, plotname),      width = 8, height = 5, scale = 1, dpi = 90)
ggsave(filename = file.path(plotpath.site, plotname), width = 8, height = 5, scale = 1, dpi = 90)

require(knitr)
require(reshape2)

data.plot.all.table <- subset(data.plot.all.2, select = c("cou", "label", "share"))
## data.plot.all.table <- data.plot.all.table[order(-data.plot.all.table$year, -data.plot.all.table$ratio),]
data.plot.all.table$share <- data.plot.all.table$share * 100
data.plot.all.table$share <- round(data.plot.all.table$share, 2)
## data.plot.all.table <- merge(data.plot.all.table, nameind.label.df, by.x = "transact", by.y = "ind")
data.plot.all.table <- merge(data.plot.all.table, STAN.COUEN)
## data.plot.all.table <- dcast(data.plot.all.table, cou ~ label, share.var = "value")
data.plot.all.table <- dcast(data.plot.all.table, cou + countryUNen ~ label, value.var = "share")
## data.plot.all.table <- subset(data.plot.all.table, select = c("cou", rev(nameind.label)))
## names(data.plot.all.table) <- sub("cou", "", names(data.plot.all.table))
data.plot.all.table <- data.plot.all.table[order(data.plot.all.table$cou),]
data.plot.all.table <- data.plot.all.table[, -1] # remove "cou" column
names(data.plot.all.table) <- sub("countryUNen", "", names(data.plot.all.table))
kable(x = data.plot.all.table, row.names = FALSE)


ggplot(data = data.plot.all.2) +
    ## geom_bar(aes(x = cou, y = share, fill = ind, order = ind), position = "stack", stat = "identity") +
    geom_bar(aes(x = cou, y = share, fill = label, order = label), position = "stack", stat = "identity") +
        ## facet_grid(label ~ .,
        ##            scales = "free") +
        facet_grid(label ~ group,
                   scales = "free",
                   space = "free_x") +
        theme_minimal() +
            scale_y_continuous(labels = percent) +
                ## scale_fill_manual(values = palette, labels = rev(nameind.label)) +
                scale_fill_manual(values = palette) +
                    labs(x = "", y = "") +
                        theme(legend.position = "top",
                              axis.text.x = element_text(angle = 45, hjust = 1)) +
                                  guides(fill = guide_legend("Activity"))

plotname <- "gdp_composition_facet.png"
ggsave(filename = file.path(plotpath, plotname),      width = 8, height = 8.5, scale = 1, dpi = 90)
ggsave(filename = file.path(plotpath.site, plotname), width = 8, height = 8.5, scale = 1, dpi = 90)


## export to plot.ly platform

devtools::install_github("ropensci/plotly")


## export to dotstat: data_dotstat.R
