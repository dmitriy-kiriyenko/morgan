deploy_user  = node['maintenance']['deploy_user']['name']
deploy_group = node['maintenance']['deploy_user']['group']
database_params = node['clearnda_web']['database'].to_hash.merge('password' => node['postgresql']['password']['postgres'])

application node['clearnda_web']['app_name'] do
  path "/var/www/apps/#{node['clearnda_web']['app_name']}"
  environment_name node['clearnda_web']['environment']
  owner deploy_user
  group deploy_group
  action :force_deploy # FIXME: remove this line when all works

  repository node['clearnda_web']['repository']
  revision node['clearnda_web']['revision']

  # FIXME: shit. Should use reciped from application_ruby
  before_symlink do
    execute 'create_and_migrate_database' do
      command 'bundle exec rake db:create db:migrate'
      user deploy_user
      group deploy_group
      cwd release_path
      environment ({'RAILS_ENV' => node['clearnda_web']['environment']})
    end

    execute 'compile_assets' do
      command 'bundle exec rake assets:precompile'
      user deploy_user
      group deploy_group
      cwd release_path
      environment ({'RAILS_ENV' => node['clearnda_web']['environment']})
    end
  end

  rails do
    #migration_command "bundle exec rake db:create db:migrate"
    gems ['bundler']

    database do
      database_params.each do |key, value|
        send(key.to_sym, value)
      end
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
