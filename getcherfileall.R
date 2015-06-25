#******************************
#*** Export all yer scp coding files
source("getcher.R")
forms="nurse_visit_audio_tracking"
events=NULL
ids=getcher(forms,events)


if(F){# stuff to download everything
ids=ids[which(! is.na(ids$ob_file_scp_1)|!is.na(ids$ob_file_scp_2)|!is.na(ids$ob_file_scp_3)),]

ids1=ids[which(!is.na(ids$ob_file_scp_1)),c("study_id","redcap_event_name",
                                            "nvat_visit_date","ob_filename_scp_1",
                                            "ob_file_scp_1")]
ids2=ids[which(!is.na(ids$ob_file_scp_2)),c("study_id","redcap_event_name",
                                            "nvat_visit_date","ob_filename_scp_2",
                                            "ob_file_scp_2")]
ids3=ids[which(!is.na(ids$ob_file_scp_3)),c("study_id","redcap_event_name",
                                            "nvat_visit_date","ob_filename_scp_3",
                                            "ob_file_scp_3")]
names(ids1)=names(ids2)=names(ids3)=c("study_id","redcap_event_name",
                                      "nvat_visit_date","ob_filename_scp",
                                      "ob_file_scp")
idst=rbind(ids1,ids2,ids3)


}

if(F){ #stuff to help hollie debug something
  
  table(is.na(ids$nv_coder_use_scp),
    ids$howmanytapes=rowSums(data.frame(!is.na(ids$ob_file_scp_1),!is.na(ids$ob_file_scp_2),!is.na(ids$ob_file_scp_3)))   
    debugdata=ids[which(is.na(ids$nv_coder_use_scp) & ids$howmanytapes>1),]
    write.csv(debugdata,'debugdata.csv')
    )
  
  
}
owd=getwd()
setwd("./obfiles")
for(i in 1:nrow(idst)){
  
  #ids$nv_coder_use_scp
 # whichfile=
  x <- POST(url="https://redcap01.brisc.utah.edu/nursing/redcap/api/",
            body=list(token='F84DB2B17064BE1414B6867D51703A3F',
                      content='file',       # Required
                      action='export',      # Required
                      record=idst$study_id[i],  # Required
                      field="ob_file_scp",   # Required
                      event=idst$redcap_event_name[i],   # Required (if longitudinal)
                      
                      returnFormat=   'csv'
            ))
  if (x$status_code == '200'){
    
    # this should be the name from ob_filename_scp_3, paste on '.odx'
    filename=idst$ob_filename_scp[i]
      if(F){
    filename <-  sub('[[:print:]]+; name=', '', x$headers$'content-type')
    filename <-  gsub('\"', '', filename)
    filename <-  sub(';charset[[:print:]]+', '', filename)
      }
    writeBin(as.vector(x$content), filename, useBytes=TRUE)
    
  } else x
  rm(x)
  
  
  
}







