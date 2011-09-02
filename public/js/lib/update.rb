File.open("./links.txt").each do |line|
  parts = line.chomp.split
  filename = parts[0]
  url = parts[1]

  `rm -f #{filename}`
  `wget #{url} -O #{filename}`
end
