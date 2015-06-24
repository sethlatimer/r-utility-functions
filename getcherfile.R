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