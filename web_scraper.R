install.packages("dplyr")
install.packages("rvest")
install.packages("leafl")


library("dplyr")
library("rvest")
library("leaflet")

urls <- c("http://www.myagentabby.com",
          "http://www.alice-white.com/",
          "http://www.billthorp.com/",
          "http://www.insurewithdianne.com",
          "http://www.doriswatson.com/",
          "http://www.drushort.net",
          "https://www.ejleinen.com/",
          "http://www.emilyswift.com",
          "https://www.callginam.com/",
          "http://www.gregmorrisagency.com/",
          "http://www.autoinsurela.com/",
          "http://www.jim-demaio.com/",
          "http://www.jimmyurban.com",
          "http://www.joebonow.com/",
          "http://www.jlanginsurance.com",
          "http://www.insureherndon.com",
          "http://www.sfphilly.com",
          "http://www.inlandempiresf.com",
          "https://www.nikkinamy.com",
          "http://www.pamelapatterson.com/",
          "http://www.robdegeorge.com",
          "http://stevealleninsurance.com",
          "http://www.tammydobrotin.com",
          "http://www.tonyedwards.net/")
      
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

write.csv(df3,"R/statefarmtest1.csv")

write.table(df,"Rstatefarm.txt")
