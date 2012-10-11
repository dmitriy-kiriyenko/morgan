default['clearnda_web']['app_name'] = 'clearnda-web'
default['clearnda_web']['repository']  = 'git@github.com:ClearNDA/clearnda-web.git'
default['clearnda_web']['environment'] = 'production'
default['clearnda_web']['revision']    = 'master'

default['clearnda_web']['application_server_role'] = 'web_live'

default['clearnda_web']['database']['adapter']  = 'postgresql'
default['clearnda_web']['database']['database'] = 'clearnda'
default['clearnda_web']['database']['host']     = 'localhost'
default['clearnda_web']['database']['username'] = 'postgres'
default['clearnda_web']['database']['password'] = node['postgresql']['password']['postgres']
