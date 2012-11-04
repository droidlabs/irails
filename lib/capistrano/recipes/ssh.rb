task :ssh do
  puts "connecting to the #{dns_name}"
  system("ssh -p #{port} #{user}@#{dns_name}")
end