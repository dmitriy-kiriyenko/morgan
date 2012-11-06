name 'postfix'
description 'Installs and configures postfix MTA for a single server setup'

default_attributes postfix: {
                     mydomain: 'your-app.com',
                     myorigin: 'your-app.com'
                   }

run_list 'recipe[postfix]'
