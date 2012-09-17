name 'postfix'
description 'Installs and configures postfix MTA for a single server setup'

default_attributes postfix: {
                     mydomain: 'domain.com',
                     myorigin: 'domain.com'
                   }

run_list 'recipe[postfix]'