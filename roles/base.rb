name "base"
description "Base role applied to all nodes."

default_attributes :maintenance => {
                     :deploy_user => {
                       :name => 'deploy',
                       :group => 'deploy',
                       :ssh_key => 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAIEAypn5krEiWWykcLeH7QvYUCmMLr1TYsFxDfh57OvkeOdMKubhbNFDfcFiQ0e4LuuSPbv3xLbClfDZa//O/MfXrZ0HIGIb2MWhw22Nrgobrtr+qt26m/Su+z0cyGYf0e6I6QuAiEEPhl9Ge75HfuWlwtmmiPcaB9YHu2+DWdSTvXM='
                     },
                     :admin_users => [
                       {
                         :name => 'ia',
                         :ssh_key => 'ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAIEAypn5krEiWWykcLeH7QvYUCmMLr1TYsFxDfh57OvkeOdMKubhbNFDfcFiQ0e4LuuSPbv3xLbClfDZa//O/MfXrZ0HIGIb2MWhw22Nrgobrtr+qt26m/Su+z0cyGYf0e6I6QuAiEEPhl9Ge75HfuWlwtmmiPcaB9YHu2+DWdSTvXM='
                       }
                     ]
                   }

run_list "recipe[ufw]", "recipe[maintenance]"