deploy_user  = node['maintenance']['deploy_user']['name']
deploy_group = node['maintenance']['deploy_user']['group']
database_params = node['application_web']['database'].to_hash.merge('password' => node['postgresql']['password']['postgres'])

application node['application_web']['app_name'] do
  path "/var/www/apps/#{node['application_web']['app_name']}"
  environment_name node['application_web']['environment']
  owner deploy_user
  group deploy_group

  repository node['application_web']['repository']
  revision node['application_web']['revision']

  purge_before_symlink ['log', 'tmp/pids', 'public/uploads']

  symlinks 'log' => 'log',
           'tmp_pids' => 'tmp/pids',
           'public_uploads' => 'public/uploads'

  migrate true
  migration_command "bundle exec rake db:create"

  rails do
    gems ['bundler']
    precompile_assets true

    database do
      database_params.each do |key, value|
        send(key.to_sym, value)
      end
    end
  end

  unicorn do
    restart_command do
      service node['application_web']['app_name'] do
        action :restart
      end
    end
  end

  nginx_load_balancer do
    only_if { node['roles'].include?('web-load-balancer') }
    application_server_role node['application_web']['application_server_role']
    application_port 8080
    static_files '/assets' => 'public/assets'
    ssl false
    template 'load_balancer.conf.erb'
  end
end
