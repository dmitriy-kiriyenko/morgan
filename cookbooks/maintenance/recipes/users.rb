username    = node['maintenance']['deploy_user']['name']
group       = node['maintenance']['deploy_user']['group']
admin_users = Array(node['maintenance']['admin_users'])
ssh_key     = admin_users.map {|user| user[:ssh_key]}.unshift(
                node['maintenance']['deploy_user']['ssh_key']
              ).join("\n")

group 'deploy'

user username do
  comment 'Deployment User'
  home "/home/#{username}"
  gid group
  shell '/bin/bash'
  supports :manage_home => true
end

directory "/home/#{username}/.ssh" do
  owner username
  group group
  mode 0700
  recursive true
end

cookbook_file "/home/#{username}/.ssh/config" do
  owner username
  group group
  mode 0600
  source 'ssh/config.conf'
end

file "/home/#{username}/.ssh/authorized_keys" do
  content ssh_key
  owner username
  group group
  mode 0600
  only_if { ssh_key && ssh_key != '' }
end

file '/etc/sudoers.d/deploy_chef' do
  owner 'root'
  group 'root'
  mode 0440
  content <<-EOS
    Defaults        env_keep = "SSH_AUTH_SOCK"
    #{username} ALL= NOPASSWD: #{`which chef-client`.chomp}
  EOS
end
