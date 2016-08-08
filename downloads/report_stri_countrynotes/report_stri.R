## install.packages("brew")
## install.packages("xlsx")

require(brew)
require(knitr)
require(markdown)
## require(xlsx)
## detach("package:xlsx", unload = TRUE)
require(XLConnect) # https://cran.r-project.org/web/packages/XLConnect/vignettes/XLConnect.pdf
require(ggplot2)
require(reshape2)
library(RColorBrewer)
library(gridExtra)

library(dplyr)
library(tidyr)

################
## begin
################

path <- file.path(dbpath, "GitHub", "jekyll", "industry", "extras", "brew_report_stri")
path.Rmd <- file.path(path, "Rmd") # Rnw and tex files are created here
path.rmd <- file.path(path, "md")
## path.html <- file.path(path, "html")
setwd(path)

data_figures <-
    file.path("data", "stri_figures_aut_deu_notes_2015.csv") %>%
        read.csv() %>%
            setNames(tolower(names(.))) %>%
                tidyr::gather(key = var, value = value, -membership, -cou3, -sector_id, -sector_name, -sector_code)

## for sorting
sector_levels <- unique(data_figures$sector_name[order(data_figures$sector_id)])
data_figures$sector_name = factor(data_figures$sector_name, levels = sector_levels)
data_figures$var = factor(data_figures$var, levels = c("restriction_on_foreign_entry", "restrictions_movement_people", "other_discriminatory_measures", "barriers_to_competition", "regulatory_transparency", "all_average", "minimum"))

data_shares <-
    file.path("data", "stri_services_shares_graphs_2015.csv") %>%
        read.csv() %>%
            setNames(tolower(names(.))) %>%
                tidyr::gather(key = var, value = value, -cou_label, -cou3)
## h(data_shares)

namereg <-
    file.path("data", "namereg.csv") %>%
        read.csv()

## cntext <- read.xlsx(file = file.path(path, "text", "CN_custom_text.xlsx"), sheetIndex=1, header=T)
cntext <-
    file.path("text", "CN_custom_text.xlsx") %>%
        XLConnect::loadWorkbook() %>%
            XLConnect::readWorksheet(sheet = 1)

year <- 2014

fill_1 <- rgb(red = 41, green = 80, blue = 131, alpha = 255, maxColorValue = 255)
fill_2 <- rgb(red = 255, green = 255, blue = 201, alpha = 255, maxColorValue = 255)
fill_3 <- rgb(red = 252, green = 163, blue = 82, alpha = 255, maxColorValue = 255)
fill_4 <- rgb(red = 220, green = 212, blue = 232, alpha = 255, maxColorValue = 255)
fill_5 <- rgb(red = 61, green = 147, blue = 61, alpha = 255, maxColorValue = 255)
plot_fill <- c(fill_1, fill_2, fill_3, fill_4, fill_5)

colour_1 <- rgb(red = 255, green = 102, blue = 153, alpha = 255, maxColorValue = 255)
colour_2 <- rgb(red = 75, green = 172, blue = 198, alpha = 255, maxColorValue = 255)
plot_colour <- c(colour_1, colour_2)

## x='CHN'
create.report <- function(x
                          ,
                          prepend = "report_stri_"
                          ){
  ## rnw.file <- paste0(path.temp, prepend, x, ".Rnw")
  Rmd.file <- file.path(path.Rmd, paste0(prepend, x, ".Rmd"))
  ## rmd.file <- file.path(path.rmd, paste0(prepend, x, ".rmd")) # .md doesn't convert hash tags
  rmd.file <- file.path(path.rmd, paste0(prepend, x, ".md")) # .md doesn't convert hash tags
  brew(file = file.path(path, "report_stri.brew"), output = Rmd.file)
  ## knit(input=rnw.file, output=paste0(path.temp, prepend, x, ".tex"))
  knit(input = Rmd.file, output = rmd.file)
  ## markdownToHTML(file = md.file, output = file.path(path, paste0(prepend, x, ".html")))
  ## latex.file <- paste0(path.temp, prepend, x, ".tex")
  ## texi2pdf(latex.file, clean = TRUE, quiet = TRUE)
  ## out.file <- paste0(prepend, x, ".pdf")
  ## out.file <- paste0(prepend, x, ".rmd")
  out.file <- paste0(prepend, x, ".md")
  return(out.file)
}


## modify scientific notation
options(scipen=8)
axis.text.size=12
legend.text.size=14

## coulist <- c("NLD")
## coulist <- sample(STAN.COU[["OECD"]], 5)
coulist <- c("AUT", "DEU") # , "ESP", "IRL", "USA")
seeds <- as.character(coulist)

## ## package data
## ## ls()
## ## h(data2009)
## ## h(data1995)
## icioIndic_data <- rbind(data2009, data1995)
## ## nrow(icioIndic_data)
## icioIndic_data_bsci <- EXGR_VA_BSCI_ind

## ## h(coulist)
## ## h(namereg)
## ## h(cntext)
## ## end package data

results <- sapply(seeds, create.report)
##
## for (file in list.files(file.path(path, "rmd"))) {
for (file in list.files(file.path(path, "md"))) {
  file.copy(from = file.path(path, "md", file), to = file.path(dbpath, "GitHub", "jekyll", "industry", file), overwrite = TRUE)
}
##
if (Sys.info()["sysname"]=="Windows") {
    system(paste0('xcopy "', file.path(path, "figures", "report_stri"), '" "', file.path(dbpath, "GitHub", "jekyll", "industry", "figures", "report_stri"), '" /e /Y'))
} else {
    system(paste('cp -r', file.path(path, "figures", "report_stri"), file.path(dbpath, "GitHub", "jekyll", "industry", "figures")))
}


#########################
## include menus
#########################
cou.label <- STAN.COUEN[STAN.COUEN$cou%in%coulist,]
cat(paste0('<li><a href="report_stri_', cou.label[,1], '.html">', cou.label[,2], '</a></li>', '\n'))


## #########################
## ## test code scripts
## #########################
## cat(paste0('source(file.path( path, "code", "', list.files(file.path(path, "code")), '"))\n'))
## source(file.path( path, "code", "figure1.R"))
## source(file.path( path, "code", "figure2b.R"))
## ##
## source(file.path( path, "code", "figure3.R")) # Error in Ops.factor(nameind$ind, data3$ind[!data3$ind == "Total"][i]) (from figure3.R#44) : level sets of factors are different
## source(file.path( path, "code", "figure4.R")) # Error in eval(expr, envir, enclos) (from figure4.R#1) : object 'EXGR_VA_BSCI' not found
## source(file.path( path, "code", "figure5b.R"))
## source(file.path( path, "code", "figure6b.R"))
## source(file.path( path, "code", "figure7.R"))
## source(file.path( path, "code", "figure8.R"))
## source(file.path( path, "code", "figure9b.R"))
