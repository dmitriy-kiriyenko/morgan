name 'chef-server'
description 'Chef server - open firewall ports for connections to chef-server'

default_attributes firewall: {
                     rules: [
                       { chef_server: { port: '4000'} },
                       { chef_server_webui: { port: '4040'} }
                     ]
                   }

run_list 'recipe[ufw]'