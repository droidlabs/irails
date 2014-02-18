set(:rbenv_ruby_version, '2.1.0')

namespace :rbenv do
  task :create_version_file, roles: :web do
    run ("rm  #{latest_release}/.ruby-version &&
          touch  #{latest_release}/.ruby-version &&
          echo #{rbenv_ruby_version} > #{latest_release}/.ruby-version
        ")
  end
end