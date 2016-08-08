## columns:
## - indicator
## - location
## - subject
## - year
## - unit
## - unit_mult
## - value

## dimIndic.df and dimSubject.df created in data_dotstat.R


## flags.df <- data.frame(dsflag = sapply(text.split, "[[", 2),
##                        labelen = sapply(text.split, "[[", 3),
##                        labelfr = sapply(text.split, "[[", 4))
## names(flags.df) <- c("dsflag", "labelen", "labelfr")
## flags_csv <- paste0('dataflags_', ds_code, '.txt')
## write.table(flags.df, file = file.path(outpath, flags_csv), sep = "|", quote=FALSE, row.names = FALSE, col.names = FALSE)

action <- "Create"
xml_filename <- paste0(action, "_", ds_code, ".xml")
command <- createDotStatXML(contacts=contacts,
                            notifications=notifications,
                            owners=owners,
                            security=security,
                            ds_names=ds_names,
                            ds_code=ds_code,
                            languages=languages,
                            action=action,
                            updatequeries=updatequeries,
                            theme=theme,
                            dir=dir,
                            nbdims=nbdims,
                            dim_names_e=dim_names_e,
                            dim_names_f=dim_names_f,
                            dim_codes=dim_codes,
                            dim_common=dim_common,
                            dim_members_columns=dim_members_columns,
                            dim_members_csv=dim_members_csv,
                            ## data_flags=data_flags,
                            ## flags_csv=flags_csv,
                            domain=domain,
                            entrygate=entrygate,
                            csv_folder=csv_folder,
                            xml_filename=xml_filename,
                            print=TRUE)
## cat(command)
## shell(cmd = command, shell = PATH.SHELL)
## ds_names
cat(command)
## shell(cmd = command, shell = PATH.SHELL)

## check DPI activity report
## http://dotstat/ActivityReport/GlobalView.aspx
