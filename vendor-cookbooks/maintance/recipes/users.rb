username = node[:maintance][:deploy_user][:name]
ssh_key  = node[:maintance][:deploy_user][:ssh_key]

group "deploy"

user username do
  comment "Deployment User"
  home "/home/#{username}"
  gid "deploy"
  supports :manage_home => true
end

directory "/home/#{username}/.ssh" do
  owner username
  group "deploy"
  mode 0700
  recursive true
end

cookbook_file "/home/#{username}/.ssh/config" do
  owner "deploy"
  group "deploy"
  mode 0600
  source "ssh/config.conf"
end

if !ssh_key.nil? || !ssh_key = ""
  file "/home/#{username}/.ssh/authorized_keys" do
    action :create_if_missing
    content ssh_key
    owner username
    group "deploy"
    mode 0600
  end
end

file "/etc/sudoers.d/deploy_chef" do
  owner "root"
  group "root"
  mode 0440
  content <<-EOS
    Defaults        env_keep = "SSH_AUTH_SOCK"
    #{username} ALL= NOPASSWD: /usr/local/bin/chef-client
  EOS
end