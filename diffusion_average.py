# coding: utf-8
#サンプリングしたユーザの正解との比較 
#上位＊ユーザをcoverしているか
import codecs
from collections import defaultdict
dataset = "Twitter" #Twitter_NoW Facebook APS Twitter
N = 30
#cent = ["deg","clo","bet","pr","kcore"]
cent = ["deg","pr","kcore"]
sampling = ["rand","bfs","dfs","sec"]
per = [100,90,80,70,60,50,40,30,20,10]
#per = [100,90,80,70,60,50,40,30,20,10,5,2,1,0.5,0,2,0.1]
top = [100,500,1000,2000]
result = defaultdict(lambda : defaultdict(lambda : defaultdict(lambda : defaultdict(list))))
#被引用数による正解のランキングをrt_rankに入れる
rt_rank = []
rt_num = defaultdict(int)

for line in open("{}/data/diffusion_result.txt".format(dataset)):
    sp = line.strip().split(" ")
    rt_rank.append(sp[0])
    rt_num[sp[0]] = sp[1]
    
for n in range(1,N+1):
    for s in sampling:
        for c in cent:
            ###rankに順位を入れる
            for p in per:
                rank = []
                for line in open("{}/work/result/{}/{}_{}_{}per.txt".format(dataset,n,s,c,p)):
                    rank.append(line.strip().split(" ")[0])
                #上位t人の平均被引用数を数える
                for t in top:
                    sum = 0
                    for i in range(0,t):
                        sum += int(rt_num[rank[i]])
                    result[n][s][c][t].append(sum/t)
    print(n)
                    

ave = defaultdict(lambda: defaultdict(lambda: defaultdict(dict)))
out = []
for s in sampling:
    for c in cent:
        for p in per:
            for t in top:
                sum = 0
                for n in range(1,N+1):
                    sum += result[n][s][c][t][per.index(p)]
                ave[s][c][t][per.index(p)] = sum/N


f = codecs.open("{}/result_diffusion_average.csv".format(dataset),"w",'utf-8')
for t in top:
    for s in sampling:
        f.write("\n{}\nCitationAverage{},Degree,PageRank,k-core\n".format(s,t))
        for p in per:
            f.write("{}%".format(p))
            for c in cent:
                f.write(",{}".format(ave[s][c][t][per.index(p)]))
            f.write("\n")
    f.write("\n")
