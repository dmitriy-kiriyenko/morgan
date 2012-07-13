Feature: Bootstrapping a new chef server

Scenario: Bootstrap
  When I run 'server_ubuntu_1_9_3' bootstrap script
  Then chef-server should be installed and ready to use