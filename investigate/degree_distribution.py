import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import numpy as np
from collections import defaultdict
from math import *

div = 8
sampling = ["rand","bfs","dfs","sec"]
for s in sampling:
    plt.figure()
    deg = defaultdict(int)
    for line in open("../sampling/1/{}_100per_degree.txt".format(s)):
        sp = line.strip().split(" ")
        deg[sp[0]] = int(sp[1])
    maxdeg = max(deg.values())
    dist = [0]*div
    for k,v in deg.items():
        if(v != 0):
            dist[int(log(float(v)) / (log(float(maxdeg))+1) * div)] += 1
        else:
            dist[0] += 1
    plt.plot(dist,label="100%")
        
    percent = [90,80,70,60,50,40,30,20,10]
    for p in percent:
        deg = defaultdict(int)
        for line in open("../sampling/1/{}_{}per_degree.txt".format(s,p)):
            sp = line.strip().split(" ")
            deg[sp[0]] = int(sp[1])
        dist = [0]*div
        for k,v in deg.items():
            if(v != 0):
                dist[int(log(float(v)) / (log(float(maxdeg))+1) * div)] += 1
            else:
                dist[0] += 1
        plt.plot(dist,label="{}%".format(p))
    plt.legend()
    plt.yscale("log")
    #plt.xlim([0,maxdeg])
    plt.xlabel("Degree")
    plt.ylabel("Freqency")
    plt.savefig("dd_{}.png".format(s))
