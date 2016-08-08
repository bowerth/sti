## standard unit list
## http://portal.oecd.org/eshare/pac/Sites/delta/Programme%20documents/Standard%20Unit%20List.xlsx

## common dimensions
dim_general <- c("INDIC", "LOCATION", "UNIT", "UNIT_MULT", "SUBJECT", "TIME", "VALUE")
## dim_general <- c("LOCATION", "UNIT", "INDIC", "UNIT_MULT", "SUBJECT", "TIME", "VALUE")


data_indic_gdpcomp <-
    data.plot.all.2 %>%
    dplyr::rename(LOCATION = cou,
                  TIME = year,
                  ## ACTIVITY = label,
                  ACTIVITY = ind,
                  REGION = group,
                  VALUE = share) %>%
                      ## dplyr::select(-ind) %>%
                      dplyr::select(-label) %>%
                          mutate(VALUE = round(100 * VALUE, 2))

data_indic_gdpcomp$INDIC <- "GDP-COMP"
data_indic_gdpcomp$UNIT <- "PC" # Percentage, alt. "RATIO"
data_indic_gdpcomp$UNIT_MULT <- 0

data_indic_gdpcomp$ACTIVITY <- sub("_", "", data_indic_gdpcomp$ACTIVITY)
## unite into SUBJECT
dim_specific <- names(data_indic_gdpcomp)[!names(data_indic_gdpcomp)%in%dim_general]
data_indic_gdpcomp_subj <-
    data_indic_gdpcomp %>%
    ## tidyr::unite(SUBJECT, ACTIVITY, REGION, sep = "_")
        tidyr::unite_("SUBJECT", dim_specific)
data_indic_gdpcomp_subj_vector <- unique(collect(data_indic_gdpcomp_subj)[["SUBJECT"]])
data_indic_gdpcomp_subj <- subset(data_indic_gdpcomp_subj, select = dim_general)

data_indic_topmanuf <-
    data.calc.plot %>%
        dplyr::select(-value, -total) %>%
            ## head()
            dplyr::rename(
                LOCATION = cou,
                TIME = year,
                REGION = group,
                VALUE = ratio) %>%
                    mutate(VALUE = round(100 * VALUE, 2))
data_indic_topmanuf$REGION <- sub(" ", "-", data_indic_topmanuf$REGION)

data_indic_topmanuf$INDIC <- "TOP-MANUF"
data_indic_topmanuf$UNIT <- "PC" # Percentage, alt. "RATIO"
data_indic_topmanuf$UNIT_MULT <- 0

## unite into SUBJECT
dim_specific <- names(data_indic_topmanuf)[!names(data_indic_topmanuf)%in%dim_general]
data_indic_topmanuf_subj <-
    data_indic_topmanuf %>%
    ## tidyr::unite(SUBJECT, ACTIVITY, REGION, sep = "_")
        tidyr::unite_("SUBJECT", dim_specific)
data_indic_topmanuf_subj_vector <- unique(collect(data_indic_topmanuf_subj)[["SUBJECT"]])
data_indic_topmanuf_subj <- subset(data_indic_topmanuf_subj, select = dim_general)
## h(data_indic_topmanuf_subj)

data_indic_all <- NULL
data_indic_all <- rbind(data_indic_all, data_indic_gdpcomp_subj)
data_indic_all <- rbind(data_indic_all, data_indic_topmanuf_subj)


dimIndic.df <- rbind.data.frame(
    c("GDP-COMP", "GPD Composition in OECD and BRIICS countries", "GPD Composition in OECD and BRIICS", 1),
    c("TOP-MANUF", "Percentage share of total world manufacturing value added", "Percentage share of total world manufacturing value added", 2)
                                )
names(dimIndic.df) <- c("Key", "NameEN", "NameFR", "Order")

## unique(data_indic_gdpcomp_subj$SUBJECT)

subject_all <- NULL
subject_all <- c(subject_all, data_indic_gdpcomp_subj_vector)
subject_all <- c(subject_all, data_indic_topmanuf_subj_vector)

dimSubject.df <- cbind.data.frame(
    subject_all,
    subject_all,
    subject_all,
    c(1:length(subject_all)
))
names(dimSubject.df) <- c("Key", "NameEN", "NameFR", "Order")

## dimSubject.df
## dimIndic.df


create.dimensions.list <- list(
    indic =
        list(code = "INDIC",
             nameen = "Indicator",
             namefr = "Indicateur",
             common = FALSE,
             columns = "CLO",
             data = dimIndic.df),
    location =
        list(code = "LOCATION",
             nameen = "Location",
             namefr = "Pays",
             common = TRUE),
    unit =
        list(code = "UNIT",
             nameen = "Unit",
             namefr = "Unité",
             common = TRUE),
    unit_mult =
        list(code = "UNIT_MULT",
             nameen = "Code list for the Unit Multiplier",
             namefr = "Code list for the Unit Multiplier",
             common = TRUE),
    subject =
        list(code = "SUBJECT",
             nameen = "Subject",
             namefr = "Sujét",
             common = FALSE,
             columns = "CLO",
             data = dimSubject.df),
    time =
        list(code = "TIME",
             nameen = "Time",
             namefr = "Temps",
             common = TRUE)
)

## create.dimensions.list

## #############################################
## define parameters and create dimensions files
## #############################################

contacts <- owners <- security <- Sys.info()[["user"]]
domain <- "OECDMAIN"

notifications <- "" # "f"
updatequeries <- TRUE # exe uses "1" and "0"
## data_flags <- TRUE
data_flags <- FALSE

theme <- "Industry and Services|Structural Analysis (STAN) Databases"
dir <- "STI"
entrygate <- "STI - Structural Analysis (STAN) Databases"
ds_names <- c("STI Scoreboard 2015 STAN", "STI Scoreboard 2015 STAN")
ds_code <- "STISCORE_2015_STAN"
languages <- c("en", "fr")

nbdims <- length(create.dimensions.list)
dim_names_e <- sapply(create.dimensions.list, function(x) x[["nameen"]])
dim_names_f <- sapply(create.dimensions.list, function(x) x[["namefr"]])
dim_codes <- sapply(create.dimensions.list, function(x) x[["code"]])
dim_common <- sapply(create.dimensions.list, function(x) ifelse(x[["common"]], return(x[["code"]]), "*"))
dim_members_columns <- sapply(create.dimensions.list, function(x) ifelse(x[["common"]], "\\*", return(x[["columns"]])))
dim_members_csv <- sapply(create.dimensions.list, function(x) ifelse(x[["common"]], "*", return(paste0('dim_', x[["code"]], '_', ds_code, '.txt'))))

## write dimension members to folder
outpath <- file.path(PATH.DOTSTAT, entrygate, "CSVFILES")
sapply(create.dimensions.list,
       function(x, outpath) {
           if(x[["common"]]==FALSE) {
               ## write.table(x[["data"]][c(1:3),],
               write.table(x[["data"]],
                           file = file.path(outpath, paste0('dim_', x[["code"]], '_', ds_code, '.txt')), sep = "|", quote=FALSE, row.names = FALSE, col.names = FALSE)
           }
       },
       outpath = outpath
       )


