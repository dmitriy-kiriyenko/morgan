# Boilerplate Chef Repository

Template chef repository extracted from several projects.

## Setup

Fork this repository and name it appropriately (usually [project-name]-chef).

Install required gems:

`$ bundle install --binstubs`

## Bootstrapping the chef server

`$ ./bin/knife bootstrap 192.168.33.11 --ssh-user vagrant --distro server_ubuntu_1_9_3 --node-name "chef.domain.com" --sudo`

* `--distro` - bootstrap template (look for them in `.chef/bootstrap` folder)
* `--node-name` - this parameter controls hostname of chef server. It's a good idea to set the hostname to be the same as domain.

See [`knife bootstrap` manual](http://wiki.opscode.com/display/chef/Knife+Bootstrap)  for more information.

## Creating the first client

1. Navigate to http://192.168.33.11:4040, (It's better to reset credentials for webui, default are `admin/chefchef`)
2. Create a client with the admin privileges
3. Save private key to `.chef/client.pem` file
4. Copy the validation key from server `/etc/chef/validation.pem` to your dev machine `.chef/validation.pem`
5. Edit `.chef/knife.rb` file. Set server url and your client name.

Test that everything is ok:

`$ ./bin/knife client list`

You should see clients list.

## Cookbooks

### librarian-chef

The project uses [`librarian-chef`](https://github.com/applicationsonline/librarian) to manage cookbooks. To install cookbooks run:

`$ ./bin/librarian-chef install`

Upload cookbooks to chef server

`$ ./bin/knife cookbook upload -a`

*Hint: a good place to start searching for a cookbook is an official Opscode repository - [https://github.com/opscode-cookbooks](https://github.com/opscode-cookbooks)*

### Managing custom cookbooks

The `cookbooks` directory in your repository is used **only** for cookbooks managed by librarian. This directory is ignored by git and it's really bad idea to change anything inside this directory. To manage your custom cookbooks you should place them into `vendor-cookbooks` directory and put them under the version control.

`knife` is setup automatically to look for your cookbooks in both directories. The `vendor-cookbooks` directory has higher priority so when you'd run `bin/knife cookbook create foo` cookbook would be created in vendored directory.

## Roles

Roles are building blocks of your infrastructure. Try to keep them small, concise, and reusable.

### Creating a new role

The easiest way to create a new role is to take any of the bundled roles and use the same structure. To upload role to chef server use the following command:

`$ ./bin/knife role from file roles/[role_name].rb`

**Important note: - Every time you update your role you have to upload it to the server**

### Assigning a role to a node

`$ ./bin/knife node run_list add nodename role[postfix]`

## Bootstrapping a new node

Review and edit `Cheffile` and `roles/base.rb` - it is recommended to start with minimum setup (like installing one package) and then start adding new packages and make changes doing a small controllable (and reversible) steps.

`$ ./bin/knife role from file roles/base.rb`
`$ ./bin/knife bootstrap 192.168.33.11 --ssh-user vagrant --distro ubuntu12.04-gems -r 'role[base]' --node-name "application" --sudo`

See [`knife bootstrap` manual](http://wiki.opscode.com/display/chef/Knife+Bootstrap) for more information.

## Running chef-client remotely

If you're using the bundled `base` role there is a special user on your node `deploy` which is allowed to run `chef-client` with sudo privileges. To run `chef-client` on nodes you can run the following command:

`$ ./bin/knife ssh "role:base" -x deploy "sudo chef-client"`

There is a handy rake task `rake deploy` which uploads cookbooks, updates roles and runs `chef-client`

## Bundled roles

### base

Base role is applied to all nodes. It enables firewall and sets up special deployment and administrator accounts for a node. It sets up ssh authorized keys.

Deployment user is a low privileged user it can run only chef-client with sudo privileges.

Administrator users are users who can do `sudo su -`. There are could be several such users.

Here is quite self-descriptive sample attributes set for setting up deployment user and one admin user:

    :maintance => {
      :deploy_user => {
        :name => 'deploy',
        :ssh_key => 'ssh-rsa AAAAB3Nza...='
      },
      :admin_users => [
        {
          :name => 'igor',
          :ssh_key => 'ssh-rsa AAAAB3Nza...='
        }
      ]
    }

### chef-server

Chef server role opens ports that are used for chef server (4000 & 4040). For a more rock-solid chef server setup it is better to put a proxy before (nginx or Apache).

### postfix

This role installs postfix package and does minimal require configuration. Pay attention to set the following attributes:

    :postfix => {
      "mydomain" => "node-domain.com",
      "myorigin" => "node-domain.com"
    }

See [postfix cookbook description](https://github.com/opscode-cookbooks/postfix) for advanced setup & tuning.

### mysql-server

Installs and sets up MySQL server and client. See [MySQL cookbook description](https://github.com/opscode-cookbooks/mysql) for advanced setup & tuning.

Hint: cookbook generates random password for `root` mysql user. You can later retrieve it as a node attribute `node[:mysql][:server_root_password]`

### nginx

Installs nginx from Ubuntu repository. You can tune it to be built from sources. Also applying this role will open port 80. 

### elasticsearch

Installs elasticsearch & creates a service wrapper for it

© 2012 [Igor Afonov](https://iafonov.github.com) MIT License