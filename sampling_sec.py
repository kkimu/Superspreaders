import time
from collections import defaultdict
import random
from sys import argv
from operator import itemgetter

t0 = time.time()
t1 = time.time()
dataset = "Facebook" #Twitter_NoW Facebook APS Twitter
percent = [0.1, 0.2, 0.5, 1, 2, 5, 10, 20, 30, 40, 50, 60, 70, 80, 90] #サンプリングレート

g = defaultdict(list)
ids = set()
for line in open("{}/data/link.txt".format(dataset)):
    sp = line.strip().split(" ")
    g[sp[0]].append(sp[1])
    ids.add(sp[0])
    ids.add(sp[1])

for k,v in g.items():
    random.shuffle(g[k])

idlist = list(ids)
idlen = len(ids)
print("id length = {}\tTime:{}".format(idlen,time.time()-t1))
#for n in range(1,2):
for n in range(int(argv[1]),int(argv[2])+1):
    for p in percent:
        t1 = time.time()
        num = int(idlen*p*0.01)
        random.shuffle(idlist)
        
        target_id = defaultdict(int)
        node = idlist[0]
        target_id[node] = 1
        idnum = 1
        index = 1
        follower = defaultdict(int)
        for i in g[node]:
            follower[i] += 1
            
        while(idnum < num):
            #print("while idnum:{} target_id length:{}".format(idnum,len(target_id)))
            if(len(follower) == 0):
                for index2 in range(index,idlen):
                    if idlist[index2] not in target_id:
                        node = idlist[index2]
                        target_id[node] = 1
                        if node in follower:
                            del(follower[node])
                        idnum += 1
                        index += 1
                        for i in g[node]:
                            if i not in target_id:
                                follower[i] += 1
                        break
                    else:
                        index += 1
            else:
                #node = max(follower.items(), key = lambda x:x[1])[0]
                #node = max(follower,key=follower.get)
                node = max(follower.items(),key=itemgetter(1))[0]
                #for k,v in sorted(follower.items(),key=itemgetter(1),reverse=True):
                    #node = k
                    #break
                target_id[node] = 1
                idnum += 1
                if node in follower:
                    del(follower[node])
                for i in g[node]:
                    if i not in target_id:
                        follower[i] += 1
                
        #print("idnum:{}".format(idnum))
        print("{}\t".format(len(target_id)),end="")
        f = open("{}/sampling/{}/sec_{}per_node.txt".format(dataset,n,p),"w")
        for k,v in target_id.items():
            f.write("{}\n".format(k))
        f.close
        
        f = open("{}/sampling/{}/sec_{}per.txt".format(dataset,n,p),"w")
        for line in open("{}/data/link.txt".format(dataset)):
            sp = line.strip().split(" ")
            if(sp[0] in target_id and sp[1] in target_id):
                f.write(line)
        f.close

        print("Time_{}per_{}:{}".format(p,n,time.time() -t1))
    print("Time_{}:{}".format(n,time.time() -t0))
