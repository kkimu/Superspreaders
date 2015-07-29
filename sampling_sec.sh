#!/bin/bash
nohup python3.4 sampling_sec.py 1 3 >out1.log 2>err1.log &
nohup python3.4 sampling_sec.py 4 6 >out2.log 2>err2.log &
nohup python3.4 sampling_sec.py 7 9 >out3.log 2>err3.log &
nohup python3.4 sampling_sec.py 10 12 >out4.log 2>err4.log &
nohup python3.4 sampling_sec.py 13 15 >out5.log 2>err5.log &
nohup python3.4 sampling_sec2.py 16 18 >out6.log 2>err6.log &
nohup python3.4 sampling_sec2.py 19 21 >out7.log 2>err7.log &
nohup python3.4 sampling_sec2.py 22 24 >out8.log 2>err8.log &
nohup python3.4 sampling_sec2.py 25 27 >out9.log 2>err9.log &
nohup python3.4 sampling_sec2.py 28 30 >out10.log 2>err10.log &
