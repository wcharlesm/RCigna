#https://test-api.cigna.com/services
#https://test-healthdata.cigna.com/home

#https://healthdata.cigna.com/security
#https://healthdata.cigna.com/home
#https://api.cigna.com/services

#GET /security/auth/oauth/v2/authorize?
#client_id=fcc3073e-0500-49cb-85c4-e6f22784c477&
#  scope=phone+email+address+profile+openid&
#  response_type=code&
#  redirect_uri=http%3A%2F%2Fexample.com%2FmyApp%2FuserAuth%3Fauth%3Ddone&
#  nonce=031200026 HTTP/1.1
#Host: healthdata.cigna.comi

if (!require("RCurl")){
  install.packages("RCurl")
  library(RCurl)
}

#baseCignaApiUrl <- if(test) "https://test-healthdata.cigna.com" else "https://healthdata.cigna.com"

cignaSignInButton <- function(clientId, scope, redirectUri, displayText = "Sign in with Cigna", inputId = 'cignaSignInButton', cssClass = "btn btn-default", encodeRedirect=TRUE, test=TRUE) {
  myHref = paste(if(test) "https://test-healthdata.cigna.com" else "https://healthdata.cigna.com", "/security/auth/oauth/v2/authorize?",
                 "client_id=", clientId,
                 "&scope=", paste(scope, sep="+", collapse="+"),
                 "&response_type=code",
                 "&redirect_uri=", if(encodeRedirect) encodeURIComponent(redirectUri) else redirectUri,
                 sep = "", collapse = "")
  
  tagList(
    tags$a(id = inputId,
           class = cssClass,
           href = myHref,
           displayText)  
  )
}

getCignaAccessToken <- function(clientId, clientSecret, code, redirectUri, state = NULL, test=TRUE){
  
  myUrl <- paste(if(test) "https://test-healthdata.cigna.com" else "https://healthdata.cigna.com", "/security/auth/oauth/v2/token", sep = "", collapse = "")
  
  postForm(myUrl,
           ssl.verifypeer = TRUE,
           sslversion = '3L', 
           .params = list('client_id' = clientId, 
                          'client_secret' = clientSecret, 
                          'grant_type' = 'authorization_code', 
                          'code' = code,
                          'redirect_uri' = redirectUri),
           .opts = list( httpheader = c('Content-Type' = 'application/x-www-form-urlencoded',
                                        'Host' = if(test) "test-healthdata.cigna.com" else "healthdata.cigna.com"))
  )
  
}