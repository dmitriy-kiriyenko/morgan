default['copycopter']['environment'] = 'production'
default['copycopter']['revision']    = 'master'

default['copycopter']['database']['adapter']  = 'postgresql'
default['copycopter']['database']['database'] = 'copycopter'
default['copycopter']['database']['host']     = 'localhost'
default['copycopter']['database']['username'] = 'postgres'
default['copycopter']['database']['password'] = node['postgresql']['password']['postgres']
