name 'web-staging'
description 'Manages deployment of ClearNDA application'

default_attributes clearnda_web: {
                     environment: 'staging',
                     application_server_role: 'web-staging'
                   }

run_list 'role[base]',
         'role[postgresql-server]',
         'role[postfix]',
         'role[nodejs]',
         'recipe[clearnda-web]'