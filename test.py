import time
from collections import defaultdict
import random
t0 = time.time()
g = defaultdict(list)
for line in open("Twitter/data/link.txt"):
    sp = line.split(" ")
    g[sp[0]].append(sp[1])

for k,v in g.items():
    random.shuffle(g[k])
    
print("Time:{}".format(time.time()-t0))
