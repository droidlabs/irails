def remote_file_exists?(full_path)
  "true" ==  capture("if [ -e #{full_path} ]; then echo 'true'; fi").strip
end