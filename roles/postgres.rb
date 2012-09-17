name "postgresql-server"
description "Sets up postgresql server and client"

run_list "recipe[postgresql::client]", "recipe[postgresql::server]"