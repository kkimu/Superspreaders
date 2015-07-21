path = ARGV[0]
for i in 1..30
  Dir.mkdir("#{path}/#{i.to_s}") unless Dir.exist?("#{path}/#{i.to_s}")
end
