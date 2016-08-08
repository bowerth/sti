
## ################################ ##
## Replace data in existing dataset ##
## ################################ ##
action <- "Replaceall"
xml_filename <- paste0(action, "_", ds_code, ".xml")
data_csv <- paste0("data_", ds_code, '.txt')

## ## write data to folder
write.table(data_indic_all,
            file = file.path(PATH.DOTSTAT, entrygate, "CSVFILES", data_csv),
            sep = "|", quote=FALSE, row.names = FALSE, col.names = FALSE, na = "")
## h(data_indic_all)

command <- createDotStatXML(contacts=contacts,
                            notifications=notifications,
                            owners=owners,
                            ds_code=ds_code,
                            languages=languages,
                            action=action,
                            updatequeries=updatequeries,
                            nbdims=nbdims,
                            dim_codes=dim_codes,
                            data_csv=data_csv,
                            ## data_flags=data_flags,
                            ## flags_csv=flags_csv,
                            entrygate=entrygate,
                            csv_folder=csv_folder,
                            xml_filename=xml_filename,
                            print=TRUE)
cat(command)
## shell(cmd = command, shell = PATH.SHELL)
