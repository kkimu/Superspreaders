dataset <- "Twitter" #Twitter_NoW Facebook APS Twitter
method <- "bfs"

library(igraph)

print(commandArgs()[5])
t0 <- proc.time()
for (i in commandArgs()[5]:commandArgs()[6]) {
    t1 <- proc.time()
    j <- 10
    while (j <= 100) {
        fn <- paste(dataset,"/sampling/",i,"/",method,"_",j,"per.txt",sep="")
        d <- read.table(fn,sep=" ")
        g <- graph.data.frame(d,directed=F)
        
        
        deg <- degree(g,mode="all")
        fn1 <- paste(dataset,"/result/",i,"/",method,"_deg_",j,"per.txt",sep="")
        write.table(deg[order(deg,decreasing=T)],fn1,quote=F,col.names=F)
        
        #bet <- betweenness(g,directed=F)
        #fn2 <- paste(dataset,"/result/",i,"/",method,"_bet_",j,"per.txt",sep="")
        #write.table(bet[order(bet,decreasing=T)],fn2,quote=F,col.names=F)
        
        #clo <- closeness(g,mode="all")
        #fn3 <- paste(dataset,"/result/",i,"/",method,"_clo_",j,"per.txt",sep="")
        #write.table(clo[order(clo,decreasing=T)],fn3,quote=F,col.names=F)
        
        kcore<-graph.coreness(g)
        fn4 <- paste(dataset,"/result/",i,"/",method,"_kcore_",j,"per.txt",sep="")
        write.table(kcore[order(kcore,decreasing=T)],fn4,quote=F,col.names=F)
        
        pr <- page.rank(g)$vector
        fn5 <- paste(dataset,"/result/",i,"/",method,"_pr_",j,"per.txt",sep="")
        write.table(pr[order(pr,decreasing=T)],fn5,quote=F,col.names=F)

        print(j)
        j <- j+10
    }
    print(i)
    print(proc.time() - t1)
}
print(proc.time() - t0)
