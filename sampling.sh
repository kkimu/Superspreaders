#!/bin/bash
nohup ruby sampling_rand.rb 1 30 >out.log 2> err.log &
nohup ruby sampling_bfs.rb 1 30 >out2.log 2>err2.log &
nohup ruby sampling_dfs.rb 1 30 >out3.log 2>err3.log &
nohup ruby sampling_sec.rb 1 4 >out4.log 2>err4.log &
nohup ruby sampling_sec.rb 5 8 >out5.log 2>err5.log &
nohup ruby sampling_sec.rb 9 12 >out6.log 2>err6.log &
nohup ruby sampling_sec.rb 13 16 >out7.log 2>err7.log &
nohup ruby sampling_sec.rb 17 20 >out8.log 2>err8.log &
nohup ruby sampling_sec.rb 21 25 >out9.log 2>err9.log &
nohup ruby sampling_sec.rb 26 30 >out10.log 2>err10.log &
