name "mysql-server"
description "Sets up MySQL server and client"

run_list "recipe[mysql::client]", "recipe[mysql::server]"