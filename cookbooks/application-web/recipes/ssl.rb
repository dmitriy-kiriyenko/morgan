# Install the ssl-cert package.
package 'ssl-cert' do
  action :install
end

# Create the directory where SSL certificates will be stored.
directory node['ssl_certificates']['path'] do
  owner 'root'
  group 'ssl-cert'
  mode  '0750'
end

# Install the ssl certificates

template node['ssl_certificates']['crt_file'] do
  source   'cert.erb'
  owner    'root'
  group    'ssl-cert'
  mode     '0640'
  variables cert: data_bag_item('ssl_certificates', 'crt')['content']
end

template node['ssl_certificates']['key_file'] do
  source   'cert.erb'
  owner    'root'
  group    'ssl-cert'
  mode     '0640'
  variables cert: data_bag_item('ssl_certificates', 'key')['content']
end
