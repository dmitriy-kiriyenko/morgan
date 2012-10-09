namespace :deploy do
  task :default => :all

  desc 'Update chef server with roles and cookbooks and run chef-client on nodes'
  task :all => [:roles, :cookbooks, :application]

  desc 'Run chef-client on all nodes'
  task :application do
    puts 'Running chef-clients:'
    system('bundle exec knife ssh "role:*" -x deploy "sudo chef-client"')
  end

  desc 'Push roles to chef-server'
  task :roles do
    puts 'Updating roles:'
    Dir.glob("roles/*.rb").each{|role_path| system("bundle exec knife role from file #{role_path}")}
  end

  desc 'Push cookbooks to chef-server'
  task :cookbooks do
    puts 'Updating cookbooks:'
    system('bundle exec knife cookbook upload -a')
  end
end
