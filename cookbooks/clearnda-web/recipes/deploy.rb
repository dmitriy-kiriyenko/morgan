deploy_user  = node['maintenance']['deploy_user']['name']
deploy_group = node['maintenance']['deploy_user']['group']
database_params = node['clearnda_web']['database']

application node['clearnda_web']['app_name'] do
  path "/var/www/apps/#{node['clearnda_web']['app_name']}"
  owner deploy_user
  group deploy_group

  repository node['clearnda_web']['repository']
  revision node['clearnda_web']['revision']

  rails do
    gems ['bundler']

    database do
      database_params.each do |key, value|
        send(key.to_sym, value)
      end
      password node['postgresql']['password']['postgres']
    end
  end

  unicorn do
    restart_command do
      execute "/etc/init.d/#{node['clearnda_web']['app_name']} hup" do
        user "root"
      end
    end
  end

  nginx_load_balancer do
    only_if { node['roles'].include?('web-load-balancer') }
    application_server_role node['clearnda_web']['application_server_role']
    application_port 8080
  end
end
