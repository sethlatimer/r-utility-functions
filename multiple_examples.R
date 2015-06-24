library(httr)

#******************************
#*** Export Records
x <- POST(url=[api_url],
          body=list(token=[api_token],  # required
                    content='record',   # required
                    format='csv',       # required
                    type='flat',        # required
                    
                    records=paste([vector_of_record_ids], collapse=','),
                    fields=paste([vector_of_field_names], collapse=','),
                    forms=paste([vector_of_form_names], collapse=','),
                    events=paste([vector_of_events], collapse=','),
                    rawOrLabel= ,              # 'raw' or 'label'
                    rawOrLabelHeaders= ,       # 'raw' or 'label'
                    eventName= ,               # 'unique' or 'label'
                    returnFormat= ,            # 'csv','json', or'xml'
                    exportSurveyFields= ,      # 'true' or'false'
                    exportDataAccessGroups = , # 'true' or 'false'
                    exportCheckboxLabel = ,    # 'true' or 'false' (ver. 6.0+)
          ))
if (x$status_code == '200') x <- read.csv(textConnection(as.character(x)),                  
                                          header=TRUE, na.strings='',
                                          stringsAsFactors=FALSE)
x



#******************************
#*** Import Records
X <- [some_data_frame]
name_string <- names(X, collapse=',')
data_string <- capture.output(write.table(X, sep=',', 
                                          col.names=FALSE, row.names=FALSE))
x_string <- paste(c(name_string, data_string, ''), collapse='\n')

POST(url=[api_url],
     body=list(token=[api_token],  # required
               content='record',   # required
               format='csv',       # required
               type='flat',        # required
               type=,              # required: 'normal' or 'overwrite'
               data=x_string,      # required
               
               returnContent= , # 'ids','count', or 'nothing'
               returnFormat = , # 'csv', 'json', or 'xml'
     ))




#******************************
#*** Export Report  (REDCap 6.0+)
x <- POST(url=[api_url],
          body=list(token=[api_token],      # Required
                    content='report',       # Required
                    report_id=[report_id],  # Required
                    format='csv',           # Required
                    
                    returnFormat= ,          # 'csv', 'json', or 'xml'
                    rawOrLabel= ,            # 'raw' or 'label'
                    rawOrLabelHeaders=,      # 'raw' or 'label'
                    exportCheckboxLabel= ,   # 'true' or 'false'
          ))
if (x$status_code == '200') x <- read.csv(textConnection(as.character(x)),
                                          header=TRUE, na.strings='',  
                                          stringsAsFactors=FALSE)
x



#******************************
#*** Export MetaData
x <- POST(url=[api_url],
          body=list(token=[api_token],   # required
                    content='metadata',  # required
                    format='csv',        # required
                    
                    fields=paste([vector_of_field_names], collapse=','),
                    forms=paste([vector_of_forms], collapse=','),
                    returnFormat=  # 'csv', 'json', or 'xml'
          ))
if(x$status_code == '200') x <- read.csv(textConnection(as.character(x)),
                                         header=TRUE, na.strings='',
                                         stringsAsFactors=FALSE)
x



#******************************
#*** Export a File
x <- POST(url=[api_url],
          body=list(token=[api_token],    # Required
                    content='file',       # Required
                    action='export',      # Required
                    record=[subject_id],  # Required
                    field=[field_name],   # Required
                    event=[event_name],   # Required (if longitudinal)
                    
                    returnFormat=  # 'csv', 'json', or 'xml'
          ))

if (x$status_code == '200'){
  filename <- sub('[[:print:]]+; name=', '', x$headers$'content-type')
  filename <- gsub('\"', '', filename)
  filename <- sub(';charset[[:print:]]+', '', filename)
  writeBin(as.vector(x$content), filename, useBytes=TRUE)
}
else x



#******************************
#*** Import a File
x <- tryCatch(
  POST(url=[api_url],
       body=list(token=[api_token],     # Required
                 content='file',        # Required
                 action='import',       # Required
                 record=[subject_id],   # Required
                 field=[field_name],    # Required
                 event=[event_name],    # Required (if longitudinal)
                 file=upload_file([file_path]),  # Required
                 
                 returnFormat=  # 'csv', 'json', or 'xml'
       )),
  error=function(cond) list(status_code='200: File import successful'))

x 

#* With no real content to return, POST returns an error after uploading the file.
#* The tryCatch call catches this error and replaces it with a success message that 
#* can be returned to the user.


#******************************
#*** Delete a File
x <- tryCatch(
  POST(url=[api_url],
       body=list(token=[api_token],     # Required
                 content='file',        # Required
                 action='delete',       # Required
                 record=[subject_id],   # Required
                 field=[field_name],    # Required
                 event=[event_name],    # Required (if longitudinal)
                 
                 returnFormat=  # 'csv', 'json', or 'xml'
       )),
  error=function(cond) list(status_code='200: File delete successful'))

x 

#* With no real content to return, POST returns an error after deleting the file.
#* The tryCatch call catches this error and replaces it with a success message that 
#* can be returned to the user.

#******************************
#*** Export Events
x <- POST(url=[api_url],
          body=list(token=[api_token],   # Required
                    content='event',     # Required
                    format='csv',        # Required
                    
                    arms=paste([vector_of_arm_numbers], collapse=','),
                    returnFormat=  # 'csv', 'json', or 'xml'
          ))
if (x$status_code == '200') x <- read.csv(textConnection(as.character(x)),
                                          header=TRUE, na.strings='',
                                          stringsAsFactors=FALSE)
x



#******************************
#*** Export Arms
x <- POST(url=[api_url],
          body=list(token=[api_token],   # Required
                    content='arm',       # Required
                    format='csv',        # Required
                    
                    arms=paste([vector_of_arm_numbers], collapse=','),
                    returnFormat=  # 'csv', 'json', or 'xml'
          ))
if (x$status_code == '200') x <- read.csv(textConnection(as.character(x)),
                                          header=TRUE, na.strings='',
                                          stringsAsFactors=FALSE)
x



#******************************
#*** Form-Event Mappings
x <- POST(url=[api_url],
          body=list(token=[api_token],   # Required
                    content='arm',       # Required
                    format='csv',        # Required
                    
                    arms=paste([vector_of_arm_numbers], collapse=','),
                    returnFormat=  # 'csv', 'json', or 'xml'
          ))
if (x$status_code == '200') x <- read.csv(textConnection(as.character(x)),
                                          header=TRUE, na.strings='',
                                          stringsAsFactors=FALSE)
x 



#******************************
#*** Export Users
x <- POST(url[api_url],
          body=list(token=[api_token],  # Required
                    content='user',     # Required
                    format='csv',       # Required
                    
                    returnFormat=  # 'csv', 'json', or 'xml'
          ))
if (x$status_code == '200') <- read.csv(textConnection(as.character(x)),
                                        header=TRUE, na.strings='',
                                        stringsAsFactors=FALSE)
x