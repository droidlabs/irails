task :ssh do
  puts "connecting to the #{dns_name}"
  system("ssh #{user}@#{dns_name} -p #{port} -t \"cd #{current_path}; bash --login\"")
end

task :log do
  puts "connecting to the #{dns_name}"
  system("ssh #{user}@#{dns_name} -p #{port} -t \"cd #{current_path}; tail -f log/#{rails_env}.log; bash --login\"")
end