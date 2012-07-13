require 'rubygems'
require 'chef'

namespace :deploy do
  task :default => :all

  desc 'Update chef server with roles and cookboks and deploy application'
  task :all => [:roles, :cookbooks, :application]

  desc 'Push application code to all servers'
  task :application do
    puts 'Running chef-clients:'
    system('./bin/knife ssh "role:*" -x deploy "sudo chef-client"')
  end

  desc 'Push roles to chef-server'
  task :roles do
    puts 'Updating roles:'
    Dir.glob("roles/*.rb").each{|role_path| system("./bin/knife role from file #{role_path}")}
  end

  desc 'Push cookbooks to chef-server'
  task :cookbooks do
    puts 'Updating cookbooks:'
    system('./bin/knife cookbook upload -a')
  end
end
