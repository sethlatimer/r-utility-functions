##there is now a comment in here! 11:25
require(httr)
# Set secret token specific to your REDCap project THIS IS PHC MAIN

# Set the url to the api (ex. https://YOUR_REDCAP_INSTALLATION/api/)
#api_url = switch(proj,"phc"="https://redcap01.brisc.utah.edu/nursing/redcap/api/",
          #            "phcwide"="https://redcap01.brisc.utah.edu/nursing/redcap/api/",
          #           "imrslgbt"="https://redcap01.brisc.utah.edu/ccts/redcap/api/")
api_url=    "https://redcap01.brisc.utah.edu/nursing/redcap/api/"

#*** Export Records
getcher=function(forms,events,proj='phc' , rawness="raw" ,... ){
  
  #this 
secret_token=switch(proj,"phc"='F84DB2B17064BE1414B6867D51703A3F',
                    'phcwide'='FA5BF9575F286710A680DAEAA698DC49',
                        "irmslgbt"='0E4B717AE70952E53EA2025D32AB3998')
  
# Set the url to the api (ex. https://YOUR_REDCAP_INSTALLATION/api/)
api_url = switch(proj,"phc"="https://redcap01.brisc.utah.edu/nursing/redcap/api/",
                 "phcwide"="https://redcap01.brisc.utah.edu/nursing/redcap/api/",
                 "irmslgbt"="https://redcap01.brisc.utah.edu/ccts/redcap/api/")


  x=  POST(url=api_url,
           body=list(token=secret_token,  # required
                     content='record',   # required
                     format='csv',       # required
                     type='flat',        # required
                     events=events,
                     fields="study_id,redcap_event_name",
                     forms=forms,
                     rawOrLabel= rawness          # 'raw' or 'label'
           ))
  
  #rread a string into dataframe.
  if (x$status_code == '200') x <- read.csv(textConnection(as.character(x)),                  
                                            header=TRUE, na.strings='',
                                            stringsAsFactors=FALSE)
  
  x
}
