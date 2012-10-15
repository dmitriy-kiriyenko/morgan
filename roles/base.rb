name 'base'
description 'Base role applied to all nodes.'

default_attributes maintenance: {
                     deploy_user: {
                       name: 'deploy',
                       group: 'deploy',
                       ssh_key: <<DEPLOY_KEYS
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCwcvxEFDJRBZrroAQOnQzH8H1IcdIu/FdqWgf7Cht/GOGxb7uusnMS+0vlutKZnG6pZc7OT/atDkh/T/YJatEffoc0HDatb0bslAh1hLUksb64ZyjMr1CPLQF6zNpxKEkQgWzYDQJlfy/0NtHyHVUil7fs//LVhUYDVxBnSRQ66sUqVUIAbfuMYo7VpkBYCP9HDwpsQtMcHUcKx5HKo0B4KeWNplLRU1dY8oHe/WoQ5e5cyS3ogJEehHJ4tuOm2bFH8L1gZ1oR22QX1+2mdq1DO2XA91gGep0ZYDFE7MCUPe333ccwhToZFxd8c29YAYzHRsq8eBguoSqh+nqf7GPaympCKLO/coh1TfhHnlLNZuGb7G9C2dp6dc6iDG0JBV7uXXHNeYQ6CpDRaqteEqolGAFO7mLS4gxiFqfdAKnwkxLUfHhFgp/vzAUyaavzK7wanz9ztXzEvoQWfrng6xNN00tP2KZ/zjbuywFAC8Eoj97UeMypdv1WH/OqkZDj78ZbDkbehdU6AQwlY/3w97eDrqG7a1CgClRXf4TGGSL7BrtXUJY/J3+IwDfzXZS/0pVWuPvM2K54qNhlDA0gIZ2MRsvJgck31p2z+F0RCHzdoQB05yW+WygGdoP0GCC9KEkITdfCGZdbY4RxMJF1l3l7AqbAtPMaeqeFnT0khXReZw== eum@anahoret.com
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCzofUrrYyyBoB4ZdviK0ezQgoJNsDzL/a/DVQDwL549xn+vhkzuIWphTINNwsdSeEY6V+AvHGVqfzaMF2R47Bb1Ye1NhSP+L3dTYVPXis8tXeOrXgo1Bwn9T4O9OPA5Hir5kuJwoWunaXKNgFOPXFEkQeEXjrVibPy1aFjNFSAcfivbbTAqxyiR3E7vN4qclwh0KV4zASZGz6Jjd5xx+wrZtCFFOy/Vagnd6x+eVJ5FZbC4PhJtMta4QJq7xnCdB5RKwoma2gxCbx/nYBpU+HeTId6SNMUVYLDjkDRPAei/UKtDI3Ar6UQ6VUVHxtSC1ht7xQRbjFqGkEhjN4iZ42HYpJazirc5j6vS8pS0ON/kMwKG2wxokUfYM429saVhdEvnNJYbLUuqHpjc/foJxBMEip9331Kgx3CekIw3qO5VT1+SnHBUQyoE0QWWXFXWfeS60VA/LGYwVEuoRHk5eMoZPd3Cpc4A5FxJNvo1nlOzWWwn7cLv62fVAvjQincklGOAgD+KkhD77ZycmRm6/Yb/GrW92AwN1cYEY3kcbzDTVpiEH9aIU+DiYtSbiXePYv3o1YiUblOVPF3rT/3Egnx4Br40iJhx6arUi7B+g35Ev+12mJsGYRDtDVRH1JnuYs1gef0ltYGU9ygQQU8Z3Cn76jjS/fvI4kpHh/smQaaAQ== jz@anahoret.com
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAIEA+AwyvE4+LKS/0jU3abhD4Hpiu9pYTOeJjIPX5r2pOC/mh6I5zkFsrVZDfmZgKJwzRc4Vpj9W5dwvk8tArgNlQ7pXff+SAdTeE9piTn+9j+jhaBYzHKNlBXFRGT0o3huj2YA+SAIPGm5+egW0tBP2QyMQxjhP5EvUO8lkHvoYsjM= dak@anahoret.com
DEPLOY_KEYS
                     },
                     admin_users: [
                       {
                         name: 'dak',
                         ssh_key: <<DAK_KEY
ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAIEA+AwyvE4+LKS/0jU3abhD4Hpiu9pYTOeJjIPX5r2pOC/mh6I5zkFsrVZDfmZgKJwzRc4Vpj9W5dwvk8tArgNlQ7pXff+SAdTeE9piTn+9j+jhaBYzHKNlBXFRGT0o3huj2YA+SAIPGm5+egW0tBP2QyMQxjhP5EvUO8lkHvoYsjM= dak@anahoret.com
DAK_KEY
                       },
                       {
                         name: 'eum',
                         ssh_key: <<EUM_KEY
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCwcvxEFDJRBZrroAQOnQzH8H1IcdIu/FdqWgf7Cht/GOGxb7uusnMS+0vlutKZnG6pZc7OT/atDkh/T/YJatEffoc0HDatb0bslAh1hLUksb64ZyjMr1CPLQF6zNpxKEkQgWzYDQJlfy/0NtHyHVUil7fs//LVhUYDVxBnSRQ66sUqVUIAbfuMYo7VpkBYCP9HDwpsQtMcHUcKx5HKo0B4KeWNplLRU1dY8oHe/WoQ5e5cyS3ogJEehHJ4tuOm2bFH8L1gZ1oR22QX1+2mdq1DO2XA91gGep0ZYDFE7MCUPe333ccwhToZFxd8c29YAYzHRsq8eBguoSqh+nqf7GPaympCKLO/coh1TfhHnlLNZuGb7G9C2dp6dc6iDG0JBV7uXXHNeYQ6CpDRaqteEqolGAFO7mLS4gxiFqfdAKnwkxLUfHhFgp/vzAUyaavzK7wanz9ztXzEvoQWfrng6xNN00tP2KZ/zjbuywFAC8Eoj97UeMypdv1WH/OqkZDj78ZbDkbehdU6AQwlY/3w97eDrqG7a1CgClRXf4TGGSL7BrtXUJY/J3+IwDfzXZS/0pVWuPvM2K54qNhlDA0gIZ2MRsvJgck31p2z+F0RCHzdoQB05yW+WygGdoP0GCC9KEkITdfCGZdbY4RxMJF1l3l7AqbAtPMaeqeFnT0khXReZw== eum@anahoret.com
EUM_KEY
                       },
                       {
                         name: 'jz',
                         ssh_key: <<JZ_KEY
ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCzofUrrYyyBoB4ZdviK0ezQgoJNsDzL/a/DVQDwL549xn+vhkzuIWphTINNwsdSeEY6V+AvHGVqfzaMF2R47Bb1Ye1NhSP+L3dTYVPXis8tXeOrXgo1Bwn9T4O9OPA5Hir5kuJwoWunaXKNgFOPXFEkQeEXjrVibPy1aFjNFSAcfivbbTAqxyiR3E7vN4qclwh0KV4zASZGz6Jjd5xx+wrZtCFFOy/Vagnd6x+eVJ5FZbC4PhJtMta4QJq7xnCdB5RKwoma2gxCbx/nYBpU+HeTId6SNMUVYLDjkDRPAei/UKtDI3Ar6UQ6VUVHxtSC1ht7xQRbjFqGkEhjN4iZ42HYpJazirc5j6vS8pS0ON/kMwKG2wxokUfYM429saVhdEvnNJYbLUuqHpjc/foJxBMEip9331Kgx3CekIw3qO5VT1+SnHBUQyoE0QWWXFXWfeS60VA/LGYwVEuoRHk5eMoZPd3Cpc4A5FxJNvo1nlOzWWwn7cLv62fVAvjQincklGOAgD+KkhD77ZycmRm6/Yb/GrW92AwN1cYEY3kcbzDTVpiEH9aIU+DiYtSbiXePYv3o1YiUblOVPF3rT/3Egnx4Br40iJhx6arUi7B+g35Ev+12mJsGYRDtDVRH1JnuYs1gef0ltYGU9ygQQU8Z3Cn76jjS/fvI4kpHh/smQaaAQ== jz@anahoret.com
JZ_KEY
                       }
                     ]
                   }

run_list 'recipe[ufw]', 'recipe[maintenance]'
