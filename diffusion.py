import time
from collections import defaultdict

t0 = time.time() 

dataset = "Twitter"  #Twitter Facebook APS Twitter_NoW

diffusion = defaultdict(set)
for line in open("{}/data/diffusion.txt".format(dataset)):
#for line in oepn("data/diffusion.txt"):
    sp = line.strip().split(" ")
    diffusion[sp[1]].add(sp[0])
    
f = open("{}/data/diffusion_result.txt".format(dataset),"w")
for k,v in diffusion.items():
    diffusion[k] = len(v)
for k,v in sorted(diffusion.items(),key=lambda x:x[1],reverse=True):
    f.write("{} {}\n".format(k,v))
f.close
print("Time : {}".format(time.time() - t0))
