default['application_web']['app_name'] = 'your-app-web'
default['application_web']['repository']  = 'git@github.com:your-org/your-app-web.git'
default['application_web']['environment'] = 'production'
default['application_web']['revision']    = 'master'

default['application_web']['application_server_role'] = 'web-live'

default['application_web']['database']['adapter']  = 'postgresql'
default['application_web']['database']['database'] = 'application-web'
default['application_web']['database']['host']     = 'localhost'
default['application_web']['database']['username'] = 'postgres'

default['ssl_certificates']['path']     = '/etc/ssl_certs'
default['ssl_certificates']['crt_file'] = "#{node['ssl_certificates']['path']}/#{node['application_web']['app_name']}.crt"
default['ssl_certificates']['key_file'] = "#{node['ssl_certificates']['path']}/#{node['application_web']['app_name']}.key"
