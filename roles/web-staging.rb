name 'web-staging'
description 'Manages deployment of the application'

default_attributes application_web: {
                     environment: 'staging',
                     application_server_role: 'web-staging'
                   }

run_list 'role[base]',
         'role[postgresql-server]',
         'role[postfix]',
         'role[nodejs]',
         'role[nginx]',
         'recipe[application-web]'
