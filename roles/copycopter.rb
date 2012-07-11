name "copycopter"
description "Example role. Manages rails application deployment. See vendor-cookbooks/copycopter."

default_attributes :copycopter => {
                     :environment => "production",
                   }

run_list "recipe[copycopter]"