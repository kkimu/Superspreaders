t0 = Time.now

dataset = "Twitter"  #Twitter_NoW Facebook APS Twitter
percent = [0.1,0.2,0.5,1,2,5,10,20,30,40,50,60,70,80,90,100]

g = Hash.new{|hash,key| hash[key] = Array.new} #g[node][0..] = following
data = []
idlist = []
open("#{dataset}/data/link.txt").each do |line|
  sp = line.strip.split(" ")
  data << sp[0]+" "+sp[1]
  g[sp[0]] << sp[1]
  idlist << sp[0]
  idlist << sp[1]
end
g.each do |k,v|
  g[k].shuffle!
end
  
idlist.uniq!  
len = idlist.length
  
for n in ARGV[0].to_i..ARGV[1].to_i
  percent.each do |i|
    t1 = Time.now
    num = (len*i*0.01).to_i
    idlist.shuffle!
    
    target_id = Hash.new
    node = idlist[0]
    target_id[node] = 1
    idnum = 1
    index = 1
    follower = Hash.new(0)
    for j in 0..g[node].length-1
      follower[g[node][j]] += 1
    end
    while idnum < num
      if follower.length == 0
        for index2 in index..len-1
          if target_id[idlist[index2]] != 1
            node = idlist[index2]
            target_id[node] = 1
            follower.delete(node)
            idnum += 1
            index += 1
            for m in 0..g[node].length-1
              if target_id[g[node][m]] != 1
                follower[g[node][m]] += 1
              end
            end
            break
          else
            index += 1
          end
        end
      else
        node = follower.max_by{|k,v| v}[0]
        target_id[node] = 1
        idnum += 1
        follower.delete(node)
        for m in 0..g[node].length-1
          if target_id[g[node][m]] != 1
            follower[g[node][m]] += 1
          end
        end
      end
      #puts follower.length
    end
    print target_id.length,"\t"

    list = []
    target_id.each {|k,v| list << k}
    open("#{dataset}/sampling/#{n}/sec_#{i}per_node.txt","w") {|f| f.puts list}
    
    data1 = []
    data.each do |line|
      sp = line.strip.split(" ")
      if target_id[sp[0]] == 1 && target_id[sp[1]] == 1
        data1 << line
      end
    end
    
    
    open("#{dataset}/sampling/#{n}/sec_#{i}per.txt","w") do |f|
      f.puts data1
    end
    puts "Time_#{i}per_#{n}:#{Time.now-t1}"
  end
  
  puts "Time_#{n}:#{Time.now-t0}"
end
