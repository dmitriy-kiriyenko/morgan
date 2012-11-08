# Morgan - boilerplate chef repository

![Morgan Freeman](http://i.minus.com/i1r5VLCXfp6cq.jpg)

It is used to handle the infrastructure of
live and staging servers for the web application.

## Setup

Clone this repository.

Install required gems:

```console
bundle
```

## Bootstrapping the chef server

```console
bundle exec knife bootstrap chef.your-app.com --ssh-user root --distro server_ubuntu_1_9_3 --node-name "chef.your-app.com" --sudo
```

* `--distro` - bootstrap template (look for them in `.chef/bootstrap` folder)
* `--node-name` - this parameter controls hostname of chef server. It's a good idea to set the hostname to be the same as domain.

See [`knife bootstrap` manual](http://wiki.opscode.com/display/chef/Knife+Bootstrap)  for more information.

## Creating the first client

1. Navigate to http://chef.your-app.com:4040, (It's better to reset credentials for webui, default are `admin/chefchef`)
2. Create a client with the admin privileges
3. Save private key to `.chef/client.pem` file
4. Copy the validation key from server `/etc/chef/validation.pem` to your dev machine `.chef/validation.pem`
5. Edit `.chef/knife.rb` file. Set server url and your client name.

Test that everything is ok:

```console
bundle exec knife client list
```

You should see clients list.

## Cookbooks

### librarian-chef

The project uses [`librarian-chef`](https://github.com/applicationsonline/librarian) to manage cookbooks. To install cookbooks run:

```console
bundle exec librarian-chef install
```

Upload cookbooks to chef server

```console
bundle exec knife cookbook upload -a
```

*Hint: a good place to start searching for a cookbook is an official Opscode repository - [https://github.com/opscode-cookbooks](https://github.com/opscode-cookbooks)*

### Managing custom cookbooks

The `vendor-cookbooks` directory in your repository is used **only** for cookbooks managed by librarian. This directory is ignored by git and it's really bad idea to change anything inside this directory. To manage your custom cookbooks you should place them into `cookbooks` directory and put them under the version control.

`knife` is setup automatically to look for your cookbooks in both directories. The `cookbooks` directory has higher priority so when you'd run `bin/knife cookbook create foo` cookbook would be created in this directory.

## Roles

Roles are building blocks of your infrastructure. Try to keep them small, concise, and reusable.

### Creating a new role

The easiest way to create a new role is to take any of the bundled roles and use the same structure. To upload role to chef server use the following command:

```console
bundle exec knife role from file roles/[role_name].rb
```

**Important note: - Every time you update your role you have to upload it to the server**

### Assigning a role to a node

```console
bundle exec knife node run_list add nodename role[postfix]
```

## Bootstrapping a new node

Review and edit `Cheffile` and `roles/base.rb` - it is recommended to start with minimum setup (like installing one package) and then start adding new packages and make changes doing a small controllable (and reversible) steps.

```console
bundle exec knife role from file roles/base.rb
bundle exec knife bootstrap newnode.your-app.com --ssh-user root --distro node_ubuntu_1_9_3 -r 'role[base]' --node-name "newnode.your-app.com" --sudo
```

See [`knife bootstrap` manual](http://wiki.opscode.com/display/chef/Knife+Bootstrap) for more information.

## Running chef-client remotely

If you're using the bundled `base` role there is a special user on your node `deploy` which is allowed to run `chef-client` with sudo privileges. To run `chef-client` on nodes you can run the following command:

```console
bundle exec knife ssh "role:base" -x deploy "sudo chef-client"
```

There is a handy rake task `rake deploy:all` which uploads cookbooks, updates roles and runs `chef-client`

## Bundled roles

There are several pre-bundled roles which you can use as a building blocks for a bigger roles. You should create roles with a meaningful names like 'appserver' or 'db-slave' it is better to avoid names like 'mysql' or 'postfix'.

### base

Base role is applied to all nodes. It enables firewall and sets up special deployment and administrator accounts for a node. It sets up ssh authorized keys.

Deployment user is a low privileged user it can run only chef-client with sudo privileges.

Administrator users are users who can do `sudo su -`. There are could be several such users.

Here is quite self-descriptive sample attributes set for setting up deployment user and one admin user:

```ruby
maintenance: {
  deploy_user: {
    name: 'deploy',
    group: 'deploy',
    ssh_key: 'ssh-rsa AAndds...='
  },
  admin_users: [{
    name: 'ia',
    ssh_key: 'ssh-rsa KADSAW...='
  }]
}
```

### chef-server

Chef server role opens ports that are used for chef server (4000 & 4040). For a more rock-solid chef server setup it is better to put a proxy before (nginx or Apache).

### postfix

This role installs postfix package and does minimal require configuration. Pay attention to set the following attributes:

```ruby
postfix: {
  mydomain: 'node-domain.com',
  myorigin: 'node-domain.com'
}
```

See [postfix cookbook description](https://github.com/opscode-cookbooks/postfix) for advanced setup & tuning.

### postgresql-server

Installs and sets up PostgreSQL server and client. See [PostgreSQL cookbook description](https://github.com/opscode-cookbooks/postgresql) for advanced setup & tuning.

Hint: cookbook generates random password for `postgres` user. You can later retrieve it as a node attribute `node[:postgresql][:password][:postgres]`

### nginx

Installs nginx from Ubuntu repository. You can tune it to be built from sources. Also applying this role will open port 80.

### nodejs

Installs Node.js from deb package. Can be used to run node applications and as javascript environment for Rails Asset Pipeline. Package installed from Chris Lea's PPA.

## Foodcritic

[Foodcritic](http://acrmp.github.com/foodcritic/) is bundled with morgan and can be used for linting your cookbooks.

```console
bundle exec foodcritic cookbooks
```
It's a good practice to run it frequently and follow its suggestions.

## Thanks to:

* [Dmitriy Kiriyenko](https://github.com/dmitriy-kiriyenko)
* [Igor Afonov](https://iafonov.github.com)
