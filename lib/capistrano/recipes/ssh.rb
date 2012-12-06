set(:ssh_cmd) {"ssh #{user}@#{dns_name} -p #{port} -t"}

task :ssh do
  puts "connecting to the #{dns_name}"
  system("#{ssh_cmd} \"cd #{current_path}; bash --login\"")
end

task :log do
  puts "connecting to the #{dns_name}"
  system("#{ssh_cmd} \"cd #{current_path}; tail -f log/#{rails_env}.log; bash --login\"")
end

task :console do
  puts "Rails console for #{application}"
  system("#{ssh_cmd} \"cd #{current_path}; #{bundle_cmd rescue 'bundle'} exec rails c #{rails_env}; bash --login\"")
end