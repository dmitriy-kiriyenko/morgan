require 'librarian/chef/integration/knife'

chef_server_url          'http://192.168.33.11:4000' # chef server url
node_name                'ia'                        # your client name
client_key               'client.pem'                # your client key

log_level                :info
log_location             STDOUT

cookbook_path            "./vendor-cookbooks", Librarian::Chef.install_path

validation_client_name   'chef-validator'
validation_key           './.chef/validation.pem'

cache_type               'BasicFile'
cache_options            :path => '.chef/checksums'
