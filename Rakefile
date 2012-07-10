require 'rubygems'
require 'chef'

task :deploy do
  system('./bin/knife cookbook upload -a')
  system('./bin/knife ssh "role:base" -x deploy "sudo chef-client"')
end