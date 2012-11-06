require 'librarian/chef/integration/knife'

chef_server_url          'http://chef.your-app.com:4000' # chef server url
node_name                `whoami`.chomp                  # your client name
client_key               'client.pem'                    # your client key

log_level                :info
log_location             STDOUT

cookbook_path            Librarian::Chef.install_path, "./cookbooks"

validation_client_name   'chef-validator'
validation_key           './.chef/validation.pem'

cache_type               'BasicFile'
cache_options            :path => '.chef/checksums'
