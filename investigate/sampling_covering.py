#サンプリングしたユーザの正解との比較 
#上位＊ユーザをcoverしているか

from collections import defaultdict
N = 30
sampling = ["rand","bfs","dfs","sec"]
per = [100,90,80,70,60,50,40,30,20,10,5,2,1,0.5,0.2,0.1]
result = defaultdict(lambda : defaultdict(lambda : defaultdict(list)))
cover = [20,50,100,200,500,1000,2000]
#リツイート数による正解のランキングをrt_rankに入れる
rt_rank = []
rt_num = defaultdict(int)
for line in open("../data/citation_result.txt"):
    sp = line.split(" ")
    rt_rank.append(int(sp[0]))
    rt_num[sp[0]] = sp[1] 

for n in range(1,N+1):
    for s in sampling:
        ###rankに順位を入れる
        for p in per:
            rank = []
            for line in open("../sampling/{}/{}_{}per_node.txt".format(n,s,p)):
                rank.append(int(line))
            #Overlap p
            for c in cover:
                result[n][s][c].append(len(set(rank) & set(rt_rank[:c]))/c)
                #print(result[n][s][c])
    print(n)
                    

ave = defaultdict(lambda: defaultdict(dict))
out = []
for s in sampling:
    for p in per:
        for c in cover:
            sum = 0
            for n in range(1,N+1):
                sum += result[n][s][c][per.index(p)]
            ave[s][c][per.index(p)] = sum/N


f = open("sampling_covering.csv","w")
for c in cover:
    f.write("\nCover{},RANDOM,BFS,DFS,SEC\n".format(c))

    for p in per:
        f.write("{}%".format(p))
        for s in sampling:
            f.write(",{}".format(ave[s][c][per.index(p)]))
        f.write("\n")

f.write("\n")
for s in sampling:
    f.write("\n{}".format(s))
    f.write("\n,Cover20,Cover50,Cover100,Cover200,Cover500,Cover1000,Cover2000\n".format(s))
    for p in per:
        f.write("{}%".format(p))
        for c in cover:
            f.write(",{}".format(ave[s][c][per.index(p)]))
        f.write("\n")

