require 'rubygems'
require 'chef'

task :deploy do
  puts "Updating roles:"
  Dir.glob("roles/*.rb").each{|role_path| system("./bin/knife role from file #{role_path}")}
  puts "Updating cookbooks:"
  system('./bin/knife cookbook upload -a')
  puts "Running chef-clients:"
  system('./bin/knife ssh "role:*" -x deploy "sudo chef-client"')
end

task :roles do
  puts "Updating roles:"
  Dir.glob("roles/*.rb").each{|role_path| system("./bin/knife role from file #{role_path}")}
end