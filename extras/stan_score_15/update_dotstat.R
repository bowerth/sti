
## ################################ ##
## Update dimension information     ##
## ################################ ##
action <- "Update"
xml_filename <- paste0(action, "_", ds_code, ".xml")
command <- createDotStatXML(contacts=contacts,
                            notifications=notifications,
                            owners=owners,
                            ds_code=ds_code,
                            languages=languages,
                            action=action,
                            updatequeries=updatequeries,
                            nbdims=nbdims,
                            ## dim_names_e=dim_names_e,
                            ## dim_names_f=dim_names_f,
                            dim_codes=dim_codes,
                            ## dim_common=dim_common,
                            dim_members_columns=dim_members_columns,
                            dim_members_csv=dim_members_csv,
                            ##
                            ## data_flags=data_flags, # add flags using "Update" method
                            ## flags_csv=flags_csv,
                            ## domain=domain,
                            entrygate=entrygate,
                            csv_folder=csv_folder,
                            xml_filename=xml_filename,
                            useExe=TRUE,
                            print=TRUE)
cat(command)
## shell(cmd = command, shell = PATH.SHELL)
