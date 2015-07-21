#bfs dfs sec
sampling <- list("bfs","dfs","sec")


library(igraph)

t0 <- proc.time()
for (i in 1:10) {
t1 <- proc.time()
for (method in sampling) {

t2 <- proc.time()
j <- 10
while (j <= 100) {
fn <- paste("../sampling/",i,"/",method,"_",j,"per.txt",sep="")
d <- read.table(fn,sep=";")
g <- graph.data.frame(d,directed=T)


deg <- degree(g,mode="in")
fn1 <- paste("result/",i,"/",method,"_deg_",j,"per.txt",sep="")
write.table(deg[order(deg,decreasing=T)],fn1,quote=F,col.names=F)

bet <- betweenness(g,directed=T)
fn2 <- paste("result/",i,"/",method,"_bet_",j,"per.txt",sep="")
write.table(bet[order(bet,decreasing=T)],fn2,quote=F,col.names=F)

clo <- closeness(g,mode="in")
fn3 <- paste("result/",i,"/",method,"_clo_",j,"per.txt",sep="")
write.table(clo[order(clo,decreasing=T)],fn3,quote=F,col.names=F)

kcore<-graph.coreness(g)
fn4 <- paste("result/",i,"/",method,"_kcore_",j,"per.txt",sep="")
write.table(kcore[order(kcore,decreasing=T)],fn4,quote=F,col.names=F)

pr <- page.rank(g)$vector
fn5 <- paste("result/",i,"/",method,"_pr_",j,"per.txt",sep="")
write.table(pr[order(pr,decreasing=T)],fn5,quote=F,col.names=F)


#v1 <- c()
#v2 <- c()
#v3 <- c()

#for (k in V(g)$name){
#nei <- neighborhood(g,1,k,mode="in")
#sum1 <- 0
#sum2 <- 0

#for (l in nei[[1]][-1]){
#nei_size <- neighborhood.size(g,1,l,mode="in")
#sum1 <- sum1 + nei_size - 1
#nei2 <- neighborhood(g,1,l,mode="in")

#for (m in nei2[[1]][-1]){
#nei_size2 <- neighborhood.size(g,1,m,mode="in")
#sum2 <- sum2 + nei_size2 - 1
#}

#}

#v1 <- c(v1,k)
#v2 <- c(v2,sum1)
#v3 <- c(v3,sum2)
#}

#out1 <- data.frame(v1,v2)
#fn6 <- paste("result/",i,"/",method,"_nei1_",j,"per.txt",sep="")
#write.table(out1[order(out1$v2,decreasing=T),],fn6,quote=F,row.names=F,col.names=F)

#out2 <- data.frame(v1,v3)
#fn7 <- paste("result/",i,"/",method,"_nei2_",j,"per.txt",sep="")
#write.table(out2[order(out2$v3,decreasing=T),],fn7,quote=F,row.names=F,col.names=F)



print(j)
j <- j+10
}
print(method)
print(proc.time() - t2)
}
print(i)
print(proc.time() - t1)
}
print(proc.time() - t0)