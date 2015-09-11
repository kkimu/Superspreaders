from collections import defaultdict

deg = defaultdict(set)
for line in open("../data/apscoauthor.csv"):
    sp = line.strip().split(" ")
    deg[sp[1]].add(sp[0])

N = 30
sampling = ["rand","bfs","dfs","sec"]
percent = [10,20,30,40,50,60,70,80,90,100]

for n in range(1,N+1):
    for s in sampling:
        for p in percent:
            deg2 = defaultdict(int)
            for line in open("../sampling/{}/{}_{}per_node.txt".format(n,s,p)):
                deg2[line.strip()] = len(deg[line.strip()])

            f = open("../sampling/{}/{}_{}per_degree.txt".format(n,s,p),"w")
            for k,v in sorted(deg2.items(),key=lambda x:x[1],reverse=True):
                f.write("{} {}\n".format(k,v))
            f.close
