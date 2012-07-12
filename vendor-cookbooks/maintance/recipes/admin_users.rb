admin_users = Array(node['maintance']['admin_users'])

if admin_users.any?
  file '/etc/sudoers.d/admin' do
    owner 'root'
    group 'root'
    mode 0440
    content <<-EOS
       %server_admin ALL=NOPASSWD: ALL
    EOS
  end

  group 'server_admin'

  admin_users.each do |admin_user|
    username = admin_user[:name]
    ssh_key  = admin_user[:ssh_key]

    user username do
      comment 'Admin #{username}'
      home '/home/#{username}'
      gid 'server_admin'
      supports :manage_home => true
    end

    directory "/home/#{username}/.ssh" do
      owner username
      group 'server_admin'
      mode 0700
      recursive true
    end

    file "/home/#{username}/.ssh/authorized_keys" do
      action :create_if_missing
      content ssh_key
      owner username
      group 'server_admin'
      mode 0600
    end
  end
end