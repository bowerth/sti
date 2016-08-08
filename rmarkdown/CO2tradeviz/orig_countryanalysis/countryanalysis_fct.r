library(scales)

# industries and countries of origin, total final domestic demand
emindcou_totdomFD <- function(c){
  countrydata <- FDCO2_byemind_MtCO2[,,,c]
  sum(countrydata[17,,])
  byemitcou <- countrydata[,,1]
  byemitcouperc <- byemitcou
  for(t in 1:noyears) byemitcou[t,] <- rowSums(countrydata[t,,])
  for(t in 1:noyears) byemitcouperc[t,] <-byemitcou[t,]/sum(byemitcou[t,])
  byemitind <- countrydata[,1,]
  byemitindperc <- byemitind
  for(t in 1:noyears) byemitind[t,] <- colSums(countrydata[t,,])
  for(t in 1:noyears) byemitindperc[t,] <-byemitind[t,]/sum(byemitind[t,])
  
  filename <- paste0(thisanalysis,countries[c],"_byemitcou_ind.pdf")
  pdf(filename, width=11.69, height=8.27) # A4 landscape
  par(mfrow=c(1,2))
  barplot(t(byemitcou),main=countries[c])
  barplot(t(byemitcouperc))
  barplot(t(byemitind),main=countries[c])
  barplot(t(byemitindperc))
  dev.off()
  
  domCO2 <- countrydata[,c,]
  AnnexICO2 <- domCO2; AnnexICO2[,] <- 0
  nonAnnexICO2 <- domCO2;nonAnnexICO2[,] <- 0
  
  for(t in 1:noyears)
    for(p in 1:nocou)if(p!=c){
      AnnexICO2[t,] <- AnnexICO2[t,] + AnnexI[p]*countrydata[t,p,]
      nonAnnexICO2[t,] <- nonAnnexICO2[t,] + (1-AnnexI[p])*countrydata[t,p,]
    }
  
  domCO2 <- cbind(domCO2,rowSums(domCO2));dimnames(domCO2)[[2]][noind+1] <- "TOT"
  AnnexICO2 <- cbind(AnnexICO2,rowSums(AnnexICO2));dimnames(AnnexICO2)[[2]][noind+1] <- "TOT"
  nonAnnexICO2 <- cbind(nonAnnexICO2,rowSums(nonAnnexICO2));dimnames(nonAnnexICO2)[[2]][noind+1] <- "TOT"
  
  filename <- paste0(thisanalysis,countries[c],"_byemitreg_ind.pdf")
  pdf(filename, width=11.69, height=8.27) # A4 landscape
  par(mfrow=c(1,1))
  graphsdata <- rbind(nonAnnexICO2[,"TOT"],AnnexICO2[,"TOT"],domCO2[,"TOT"])
  barplot(graphsdata,legend=c("non-Annex I","Annex I","domestic"),main=countries[c])
  par(mfrow=c(2,3))
  for(i in industries){
    graphsdata <- rbind(nonAnnexICO2[,i],AnnexICO2[,i],domCO2[,i])
    barplot(graphsdata,main=i)#legend=c("non-Annex I","Annex I","domestic"))
  }
  dev.off()
  
  return(list(domCO2,AnnexICO2,nonAnnexICO2))
}# end emindcou_totdomFD

emindcou_inddomFD <- function(c,FDCO2ind,selind){
  countrydata <- FDCO2ind[,,,c]
  sum(countrydata[17,,])
  byemitcou <- countrydata[,,1]
  byemitcouperc <- byemitcou
  for(t in 1:noyears) byemitcou[t,] <- rowSums(countrydata[t,,])
  for(t in 1:noyears) byemitcouperc[t,] <-byemitcou[t,]/sum(byemitcou[t,])
  byemitind <- countrydata[,1,]
  byemitindperc <- byemitind
  for(t in 1:noyears) byemitind[t,] <- colSums(countrydata[t,,])
  for(t in 1:noyears) byemitindperc[t,] <-byemitind[t,]/sum(byemitind[t,])
  
  domCO2 <- countrydata[,c,]
  AnnexICO2 <- domCO2; AnnexICO2[,] <- 0
  nonAnnexICO2 <- domCO2;nonAnnexICO2[,] <- 0
  
  for(t in 1:noyears)
    for(p in 1:nocou)if(p!=c){
      AnnexICO2[t,] <- AnnexICO2[t,] + AnnexI[p]*countrydata[t,p,]
      nonAnnexICO2[t,] <- nonAnnexICO2[t,] + (1-AnnexI[p])*countrydata[t,p,]
    }
  
  domCO2 <- cbind(domCO2,rowSums(domCO2));dimnames(domCO2)[[2]][noind+1] <- "TOT"
  AnnexICO2 <- cbind(AnnexICO2,rowSums(AnnexICO2));dimnames(AnnexICO2)[[2]][noind+1] <- "TOT"
  nonAnnexICO2 <- cbind(nonAnnexICO2,rowSums(nonAnnexICO2));dimnames(nonAnnexICO2)[[2]][noind+1] <- "TOT"
  
  if(selind=="TOT") filename <- paste0(thisanalysis,countries[c],"_byemitreg_ind_FD",selind,".pdf")
  else filename <- paste0(thisanalysis,countries[c],"_byemitreg_ind_FD",industries[selind],".pdf")
  pdf(filename, width=8.27, height=11.69) # A4 landscape
  par(mfrow=c(2,1))
  graphsdata <- rbind(nonAnnexICO2[,"TOT"],AnnexICO2[,"TOT"],domCO2[,"TOT"])
  barplot(graphsdata,legend=c("non-Annex I","Annex I","domestic"),main=countries[c])
  indexdata <- graphsdata; for(idc in 1:3)indexdata[idc,] <- graphsdata[idc,]/colSums(graphsdata);
  barplot(indexdata,main="TOTAL")
  par(mfrow=c(3,2))
  for(i in 1:(noind-1)){
    graphsdata <- rbind(nonAnnexICO2[,i],AnnexICO2[,i],domCO2[,i]);rownames(graphsdata)=c("non-Annex I","Annex I","domestic")
    barplot(graphsdata,main=industries[i])#legend=c("non-Annex I","Annex I","domestic"))  
    indexdata <- graphsdata; for(idc in 1:3)indexdata[idc,] <- graphsdata[idc,]/colSums(graphsdata);
    barplot(indexdata,main=industries[i])#legend=c("non-Annex I","Annex I","domestic"))    
#     datm <- melt(graphsdata);names(datm) <- c("VAR","YEAR","VALUE")
#     pl <- ggplot(datm) + geom_bar(aes(x = YEAR, y = VALUE,fill = VAR),position = "fill",stat="identity")+ 
#       scale_y_continuous(labels = percent_format()) + ggtitle(industries[i])
#     print(pl)    
  }
  dev.off()
  
  return(list(domCO2,AnnexICO2,nonAnnexICO2))
}# end emindcou_inddomFD


SDAindicator <- function(indicorig){
  SDAindic <- array(0,dim=c(noyears,nocou,noind,nocou))
  dimnames(SDAindic) <- list(years,countries,industries,countries)
  for(c in 1:(nocou)){
    c1=(c-1)*(noind)+1;
    c2=c*(noind);
    SDAindic[,c,,]<-indicorig[,c1:c2,]
  }
  return(SDAindic)
}