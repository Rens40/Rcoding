# instal a Library 
  install.packages('[InsertPackageName]')
    install.packages(c('readr', 'ggplot2', 'tidyr')) # instal more packages 
    
# Install package if it's not already installed
    if (!requireNamespace("[InsertPackageName]", quietly = TRUE))
      install.packages("[InsertPackageName]l")

# read data formats 
    read_excel(GradingKnowledge, sheet = [insert tab name]) # excel file 

    
## Data manipulation 
  # print variable names dataaset
  print(names(data)) 
  
  # rename variables 
  df <- df %>%
    rename(NewVARName1 = OldVARName1,
           NewName2 = OldName2,
           NewName3 = OldName3)
  # Recode specific levels of an variavle
  df <- df %>%
    mutate([insertVariable] = recode(ID,[insertVariable]
                       "old_level_1" = "new_level_1",
                       "old_level_2" = "new_level_2",
                       "old_level_3" = "new_level_3" 
                       ))
  #saperate a variable 
  library(dplyr)
  df <- df %>%
    separate([insertVariable], into = c("AOI", "Px"), sep = "_") 
  
  #remove a data colum 
  df <- select(df, -[insertVariable])
  
  #merge datasets 
  merged_data <- merge(df1, df2, by = "[insertVariable:e.g. ID]")
  
## Save Data 
  
  #Write Simple CSV file 
  write.csv(df, "[name df].csv")
  
  # Write CSV File with name and date code 
  current_date <- format(Sys.Date(),"%d%m%Y") # Get current date
  current_time <- format(Sys.time(), "%H%M")  # Get current time
  DateTime <- paste0(“*[INSERTPROJECTNAME]*“, current_date, current_time) # Create a file name with the current date and time
  FileName_*[INSERTDATASETNAME]* <- paste0(“*[INSERTDATASETNAME]*“, DateTime,".csv" ) # Create a file name with the current date and time
  write.csv(*[INSERTDATASETNAME]*, FileName_*[INSERTDATASETNAME]*)
      # filename:   [DATASETNAME][ProjectName][ddmmyyyyHHMM].csv
  #dd = day, mm= month, YYYY = year, HH = hour, MM = minutes
  
  
## References 
  # make bib text reference file of R package
  library(tools)
  bibEntry <- citation("tidyr")
  bibText <- toBibtex(bibEntry)
  writeLines(bibText, "/Users/rensvanhaaren/Documents/documenten/TOOLS/BiBfilesreferences.bib")
  
  # make bib text reference file from text insert: 
  library(tools)
  bibEntry <- bibEntry <- " [insert bibtext] "
  bibText <- toBibtex(bibEntry)
  writeLines(bibText, "/Users/rensvanhaaren/Documents/documenten/TOOLS/BiBfilesreferences.bib")
  
  
  
  