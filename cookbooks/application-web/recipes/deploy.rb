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

  before_symlink do
    execute 'prepare_application' do
      command 'bundle exec rake db:create db:migrate assets:precompile --trace'
      user deploy_user
      group deploy_group
      cwd release_path
      environment ({'RAILS_ENV' => node['application_web']['environment']})
    end
  end

  rails do
    gems ['bundler']

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
  end
end
