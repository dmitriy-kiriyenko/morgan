name "copycopter"
description "Sample role. Manages rails application deployment. See vendor-cookbooks/copycopter."

default_attributes :copycopter => {
                     :environment => "production",
                   }

run_list "role[_base]",
         "role[_chef-server]",
         "role[_postgresql-server]",
         "role[_nginx]",
         "role[_postfix]",
         "role[_nodejs]",
         "recipe[copycopter]"