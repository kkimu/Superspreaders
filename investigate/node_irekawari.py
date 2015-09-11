#ランキングのノードの入れ替わりをみる
#
from collections import defaultdict

idlist = []
#cent = ["deg","clo","bet","pr","kcore"]
cent = ["deg","pr","kcore"]
sampling = ["rand","bfs","dfs","sec"]
per = [100,90,80,70,60,50,40,30,20,10]



wall_rank = defaultdict(int)
wall_num = defaultdict(int)
i=0
#wall[id]["t"]にidの正解の順位を入れる wall_num[id]にidのwall書き込み数をいれる
for line in open("../data/citation_result.txt"):
    sp = line.strip().split(" ")
    wall_rank[sp[0]] = i+1
    wall_num[sp[0]] = sp[1]
    i+=1

friends = defaultdict(set)
for line in open("../data/apscoauthor.csv"):
    sp = line.strip().split(" ")
    friends[sp[0]].add(sp[1])
    friends[sp[1]].add(sp[0])


for c in cent:
    for s in sampling:
        ###rankに順位を入れる
        rank = defaultdict(dict)
        #rank[id][percent]にidのpercentでの順位を入れる
        for p in per:
            j = 0
            for line in open("../work/result/1/{}_{}_{}per.txt".format(s,c,p)):
                sp = line.split(" ")
                rank[sp[0]][p] = j+1
                j+=1


        ###ファイルに書き込み
        f = open("node_irekawari_{}_{}.csv".format(s,c),"w")
        for p in per: # 1行目
            f.write(",{}%".format(p)) # ,100%,90%,...,10%
        f.write(",TRUTH,wall,friends\n") # ,TRUTH,wall,friends\n

        #2行目から ID,100%のときのランク,90%,...,10%
        for k,v in rank.items():
            f.write("{}".format(k))
            #予測した順位
            for p in per:
                if(p in v):
                    f.write(",{}".format(v[p]))
                else:
                    f.write(",") #順位がないときは空
                    
            #正解順位、wall書き込み数
            if(k in wall_rank):
                f.write(",{},{}".format(wall_rank[k],wall_num[k]))
            else:
                f.write(",,") #正解順位がないときは空
                
            #フォロー数
            if(len(friends[k]) > 0):
                f.write(",{}".format(len(friends[k])))
            else:
                f.write(",0")
            
            f.write("\n")
            
