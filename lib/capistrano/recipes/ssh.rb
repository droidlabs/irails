task :ssh do
  puts "connecting to the #{dns_name}"
  system("ssh #{user}@#{dns_name} -p #{port} -t \"cd #{current_path}; bash --login\"")
end

task :log do
  puts "connecting to the #{dns_name}"
  system("ssh #{user}@#{dns_name} -p #{port} -t \"cd #{current_path}; tail -f log/#{rails_env}.log; bash --login\"")
end

task :console do
  puts "Rails console for #{application}"
  system("ssh #{user}@#{dns_name} -p #{port} -t \"cd #{current_path}; #{bundle_cmd rescue 'bundle'} exec rails c; bash --login\"")
end