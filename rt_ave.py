import time
from collections import defaultdict

t0 = time.time()
num = [100,500,1000,2000]
a = []
for n in num:
    j = 0
    sum = 0
    for line in open("data/diffusion_result.txt"):
        if j<n:
            sum += int(line.split(" ")[1].strip())
            j+=1
        else:
            break

    a.append("average{} \t{}\n".format(n,sum/n))


f = open("truth_rt_average.txt","w")
for str in a:
    f.write(str)
f.close
print("time:{}".format(time.time() - t0))
    
