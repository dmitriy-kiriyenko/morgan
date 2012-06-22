# Stack-rails

A convenient way to quickly setup & maintain web server infrastructure.

## Supported platforms

* Ubuntu 12.04 LTS
* Ubuntu 11.10

*more to come. CentOS is next*

## Out of the box supported stack

* MySQL || PostgreSQL
* Nginx
* Unicorn 

## How it works

### Step 1 - bootstrap environment

This step is one-off and consists of installing ruby and chef (soloist). There are several bootstrap scripts to choose from, they are located in bootstrap folder. The naming convention for them is `OS version`_`ruby version`. If default version of ruby works for you - you can skip it and install `soloist` manually (`gem install soloist`)

### Step 2 - bootstrap infrastructure and maintain it

Under the hood `stack-rails` uses opscode chef to setup and maintain your infrastructure.

## The complete walkthrough

Lets deploy for example https://github.com/RailsApps/rails3-bootstrap-devise-cancan

* Fork this repository
* Clone it on your development machine
* Edit soloistrc file to match your needs
* Push it
* Clone repository on target server
* Run ./bootstrap script of your choice to install ruby & soloist (If you already have ruby installed - skip it and run `gem install soloist`)
* Run `soloist`

