#サンプリングしたユーザの正解との比較 
#Overlap サンプリングしたユーザ数だけ

from collections import defaultdict
N = 30
sampling = ["rand","bfs","dfs","sec"]
per = [100,90,80,70,60,50,40,30,20,10,5,2,1,0.5,0.2,0.1]
result = defaultdict(lambda :defaultdict(list))

for n in range(1,N+1):
    #リツイート数による正解のランキングをrt_rankに入れる
    rt_rank = []
    rt_num = defaultdict(int)
    for line in open("../../twitter-rt/result/rt_result_{}.txt".format(n)):
        sp = line.split(" ")
        rt_rank.append(int(sp[0]))
        rt_num[sp[0]] = sp[1] 
        
    for s in sampling:
        ###rankに順位を入れる
        for p in per:
            rank = []
            for line in open("../sampling/{}/{}_{}per_node.txt".format(n,s,p)):
                rank.append(int(line))
            #Overlap p
            rtlen = int(p*0.01*len(rt_rank))
            result[n][s].append(len(set(rank) & set(rt_rank[:rtlen]))/rtlen)
            

ave = defaultdict(dict)
out = []
for s in sampling:
    for p in per:
        sum = 0
        for n in range(1,N+1):
            sum += result[n][s][per.index(p)]
        ave[s][per.index(p)] = sum/N

f = open("sampling_result.csv","w")
f.write(",RANDOM,BSF,DFS,SEC\n")

for p in per:
    f.write(str(p))
    for s in sampling:
        f.write(",{}".format(ave[s][per.index(p)]))
    f.write("\n")
