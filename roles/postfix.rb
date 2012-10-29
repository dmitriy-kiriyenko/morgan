name 'postfix'
description 'Installs and configures postfix MTA for a single server setup'

default_attributes postfix: {
                     mydomain: 'clearnda.com',
                     myorigin: 'clearnda.com'
                   }

run_list 'recipe[postfix]'