name 'web-load-balancer'
description 'Manages setting up nginx load balancer'

run_list 'role[nginx]'
