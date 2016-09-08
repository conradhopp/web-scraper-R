install.packages("dplyr")
install.packages("rvest")
install.packages("leafl")


library("dplyr")
library("rvest")
library("leaflet")

urls <- c("url 1", "url 2",...)
      
df <- lapply(urls, function(u) {  
          
  html.obj <- read_html(u)
  agent <- html_nodes(html.obj,"#AgentName b") %>% html_text
  phone.number<-html_nodes(html.obj, "#offNumber_mainLocContent span") %>% html_text
  address <- html_nodes(html.obj,"#locStreetContent_mainLocContent") %>% html_text
  address2 <- html_nodes(html.obj,"#locationStreet_mainLocContent+ div .row-fluid+ .row-fluid") %>% html_text
  data.frame(Agent=agent, Phone=phone.number, Address=paste(address, address2, sep = " "))
  
})

df <- do.call(rbind, df)


df2 <- lapply(urls, function(u) {  
    
    html.obj <- read_html(u)
    agent <- html_nodes(html.obj,".font26") %>% html_text
    phone.number<-html_nodes(html.obj, "#logo-bar-phone") %>% html_text
    address <- html_nodes(html.obj,".block+ .font20") %>% html_text
    address2 <- html_nodes(html.obj,".font20:nth-child(3)") %>% html_text
    address3 <- html_nodes(html.obj,".font20:nth-child(3)") %>% html_text
    data.frame(Agent=agent, Phone=phone.number, Address= paste(address, address2, address3, sep =" "))
    
  })

df2 <- do.call(rbind,df2)

df3 <- rbind(df,df2)

View(df3)

write.csv(df3,"R/scrapedata.csv")

write.table(df,"scrapedata.txt")
