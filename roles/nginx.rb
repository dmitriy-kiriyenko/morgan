name "nginx"
description "Installs and configures nginx reverse proxy"

default_attributes :firewall => {
  :rules => [
    { :http => { :port => "80"} }
  ]
}


run_list "recipe[nginx]"