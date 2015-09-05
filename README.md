# Superspreaders
研究
ソーシャルネットワークにおけるSuperspreader(拡散者・影響力の高いユーザ)を推定する。
データセットは4つTwitter・Facebook・APS(http://lev.ccny.cuny.edu/~hmakse/soft_data.html),Twitter_NoW(研究室でクローリングしたデータ)

##プログラムについて
### diffusion.py
拡散数によるユーザランキングを作成。
[Twitter,Facebook,APS,Twitter_NoW]/data/diffusion.txtに引用のデータ
[Twitter,Facebook,APS,Twitter_NoW]/data/diffusion_result.txtに結果を出力

### sampling_xxx.rb
ランダムサンプリング(rand)・幅優先探索(bfs)・深さ優先探索(dfs)・Sample Edge Count(sec)によってネットワークをサンプリングする。
[Twitter,Facebook,APS,Twitter_NoW]/data/link.txtにリンクのデータ
[Twitter,Facebook,APS,Twitter_NoW]/result/に結果を出力

## c_xxx.R
サンプリングされたネットワークそれぞれで、影響力推定の指標(degree,closeness,betweenness,PageRank,k-core)を計算する。
計算結果はwork/resultに保存

## overlap.py
指標の計算結果から上位100,500,1000,2000ノードのOverlapを計算する。

## diffusion_average.py
指標の計算結果から上位100,500,1000,2000ノードの平均被引用数を計算する。

### investigate/
#### node_irekawari.py
ノードの順位の変動を出す
#### sampling_covering.py
サンプリングの結果、被引用数ランキングの上位をどれだけカバーしているか出す
#### degree_distribution.py
サンプリングの結果の次数分布を出す
