# coding: utf-8
#ランダムサンプリング

t0 = Time.now
dataset = "Twitter" #Twitter Facebook APS Twitter_NoW

id = []
data = []
open("#{dataset}/data/link.txt").each do |line|
  sp = line.strip.split(" ")
  data << sp[0]+" "+sp[1]
  id << sp[0]
  id << sp[1]
end

id.uniq!
len = id.length

percent = [0.1, 0.2, 0.5, 1, 2, 5, 10, 20, 30, 40, 50, 60, 70, 80, 90, 100]

for n in ARGV[0].to_i..ARGV[1].to_i
  percent.each do |i|
    t1 = Time.now
    num = (len*i*0.01).to_i #num = 60000 * percent *0.01
    #puts num
    id.shuffle!

    target_id = Hash.new
    
    for j in 0..num-1
      target_id[id[j]] = 1
    end
    print target_id.length,"\t"

    list = []
    target_id.each {|k,v| list << k}
    open("#{dataset}/sampling/#{n}/rand_#{i}per_node.txt","w") {|f| f.puts list}
    
    data1 = []
    data.each do |line|
      sp = line.strip.split(" ")
      if target_id[sp[0]] == 1 && target_id[sp[1]] == 1
        data1 << line
      end
    end
    
    open("#{dataset}/sampling/#{n}/rand_#{i}per.txt","w") do |f|
      f.puts data1
    end
    puts "Time#{i.to_s.rjust(3)}per:#{Time.now-t1}"
  end
  
  puts "#{n} Time:#{Time.now-t0}"
end
