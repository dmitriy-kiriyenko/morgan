# Stack-rails

A convenient way to quickly setup & maintain web server infrastructure using [chef](http://www.opscode.com/chef/) & [soloist](https://github.com/mkocher/soloist).

## Supported platforms

* Ubuntu 12.04 LTS

## Out of the box supported stacks

* PostgreSQL/Nginx/Unicorn
* MySQL/Nginx/Unicorn

## How it works

Stack-rails is a set of preselected cookbooks that are used to quickly setup and run Rails applications and maintain underlying infrastructure.

### Step 1 - bootstrap environment

This step should be run once and consists of installing ruby and chef (soloist). There are several bootstrap scripts to choose from, they are located in bootstrap folder. The naming convention for them is `OS version`_`ruby version`. If default version of ruby works for you - you can run `./bootstrap/ubuntu_system.sh` this script will only install soloist gem.

### Step 2 - bootstrap infrastructure and maintain it using chef

Stack-rails uses soloist to run chef-solo and configure attributes via YAML file. Every time when you're running `soloist` command from the stack-rails folder it would pick-up configuration from `soloistrc` file and converge the system.

## Quick real world example

Let's bootstrap infrastructure and deploy thoughtbot's open-source [copycopter](https://github.com/copycopter/copycopter-server) application. This is modern and up-to-date Rails 3 application which uses bundler and asset pipeline.

* Download this repository to target server

```bash
$ wget https://github.com/iafonov/stack-rails/tarball/master
$ tar -zxf stack-rails.tar.gz
$ mv iafonov-stack-rails-246c815/ stack-rails
```
* It is really recommended to import this repository to your internal git repo (or fork it) and commit every changes you're making
* Run `./bootstrap/ubuntu_1_9_3.sh` to install Ruby 1.9.3
* Review and edit `soloistrc` file. The most important section is `attributes` section where you can customize recipes behavior and tune configuration files:

```yaml
node_attributes:
  postgresql:
    password:
      postgres: changeit      # password for postgres user
  rails_ghetto:
    deployment_user: deploy   # user under which the application will run
    deployment_group: deploy  # group under which the application will run
    libs:                     # gems native extensions compile time dependencies
      - libxslt-dev  
      - libxml2-dev
    applications:
      copycopter:             # application name. it would be used to generate init.d script
        repository: https://github.com/iafonov/copycopter-server.git # code repository
        revision: master      # revision - you can use branch name/tag name or exact SHA id of commit
        unicorn_port: 8080
        server_name: "_"      # server name that would be used in site's nginx configuration, "_" - is catch-all name
        compile_assets: true  # if true - `bundle exec rake assets:compile` would be run before deployment
        run_migrations: true  # if true - `bundle exec rake db:create db:migrate` would be run before deployment
        rails_environment: production
        # configuration for database.yml
        database: { adapter: postgresql, database: copycopter, host: localhost, username: postgres, password: changeit }
```

* Run `soloist` to converge the system and make a first deploy!

## Testing with Vagrant

* [Setup Vagrant on your system](http://vagrantup.com/v1/docs/getting-started/index.html).
* Add Ubuntu 12.04 image and run virtual machine

```bash
$ vagrant box add precise64 http://files.vagrantup.com/precise64.box
$ vagrant init precise64
$ vagrant up
```

* Now you're ready to test stack-rails. If at any time you're feel that you're got stuck you can respawn the machine by running:

```bash
$ vagrant destroy && vagrant up
```

Extracted from [telemetry.io](http://telemetry.io) project.
© 2012 [Igor Afonov](https://iafonov.github.com) MIT License