name 'base'
description 'Base role applied to all nodes.'

default_attributes maintenance: {
                     deploy_user: {
                       name: 'deploy',
                       group: 'deploy',
                       ssh_key: <<DEPLOY_KEYS
ssh-rsa AAAAB3NzaC1yc2EAAADVQDwL549xn+vhkzuIWphTINNwsdSeEY6V+AvHGVqfzaMF2R47Bb1Ye1NhSP+L3dTYVPXis8tXeOrXgo1Bwn9T4O9OPA5Hir5kuJwoWunaXKNgFOPXFEkQeEXjrVibPy1aFjNFSAcfivbbTAqxyiR3E7vN4qclwh0KV4zASZGz6Jjd5xx+wrZtCFFOy/Vagnd6x+eVJ5FZbC4PhJtMta4QJq7xnCdB5RKwoma2gxCbx/nYBpU+HeTId6SNMUVYLDjkDRPAei/YtSbiXePYv3o1YiUblOVPF3rT/3Egnx4Br40iJhx6arUi7B+g35Ev+12mJsGYRDtDVRH1JnuYs1gef0ltYGU9ygQQU8Z3Cn76jjS/fvI4kpHh/smQaaAQ== special_key_if_needed
DEPLOY_KEYS
                     },
                     admin_users: [
                       {
                         name: 'first_developer',
                         ssh_key: <<KEY
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAIEA+AwyvE4+LKS/0jU3abhD4Hpiu9pYTOeJjIPX5r2pOC/mh6I5zkFsrVZDfmZgKJwzRc4Vpj9W5dwvk8tArgNlQ7pXfSAdTeE9piTn+9j+jhaBYzHKNlBXFRGT0o3huj2YA+SAIPGm5+egW0tBP2QyMQxjhP5EvUO8lkHvoYsjM= first_developer
KEY
                       },
                       {
                         name: 'second_developer',
                         ssh_key: <<KEY
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCzofUrrYyyBoB4ZdviK0ezQgoJNsDzL/a/DVQDwL549xn+vhkzuIWphTINNwsdSeEY6V+AvHGVqfzaMF2R47Bb1Ye1NhSP+L3dTYVPXis8tXeOrXgo1Bwn9T4O9OPA5Hir5kuJwoWunaXKNgFOPXFEkQeEXjrVibPy1aFjNFSAcfivbbTAqxyiR3E7vN4qclwh0KV4zASZGz6Jjd5xx+wrZtCFFOy/Vagnd6x+eVJ5FZbC4PhJtMta4QJq7xnCdB5RKwoma2gxCbx/nYBpU+HeTId6SNMUVYLDjkDRPAei/UKtDI3Ar6UQ6VUVHxtSC1ht7xQRbjFqGkEhjN4iZ42HYpJazirc5j6vS8pS0ON/khD77ZycmRm6/Yb/GrW92AwN1cYEY3kcbzDTVpiEH9aIU+DiYtSbiXePYv3o1YiUblOVPF3rT/3Egnx4Br40iJhx6arUi7B+g35Ev+12mJsGYRDtDVRH1JnuYs1gef0ltYGU9ygQQU8Z3Cn76jjS/fvI4kpHh/smQaaAQ== second_developer
KEY
                       }
                     ]
                   }

run_list 'recipe[ufw]', 'recipe[maintenance]', 'recipe[ntp]'
