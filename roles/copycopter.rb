name 'copycopter'
description 'Sample role. Manages rails application deployment. See cookbooks/copycopter.'

default_attributes copycopter: {
                     environment: 'production',
                   }

run_list 'role[base]',
         'role[chef-server]',
         'role[postgresql-server]',
         'role[nginx]',
         'role[postfix]',
         'role[nodejs]',
         'recipe[copycopter]'