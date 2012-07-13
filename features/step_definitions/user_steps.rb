require 'rest-client'

When /^I run '(.*)' bootstrap script$/ do |distro|
  require 'socket'

  system("ssh-add ~/.ssh/identity")
  system("./bin/knife bootstrap localhost --ssh-user #{ENV['USER']} --distro #{distro} --node-name '#{Socket.gethostname}' --sudo")
end

Then /^chef\-server should be installed and ready to use$/ do
  RestClient.get("http://#{Socket.gethostname}:4000").should_not be_empty

  RestClient.get("http://#{Socket.gethostname}:4040").should_not be_empty
end