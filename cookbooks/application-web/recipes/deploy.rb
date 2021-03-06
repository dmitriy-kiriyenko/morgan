deploy_user  = node['maintenance']['deploy_user']['name']
deploy_group = node['maintenance']['deploy_user']['group']
database_params = node['application_web']['database'].to_hash.merge(
  'password' => node['postgresql']['password']['postgres']
)

shared_children = {
  'log' => 'log',
  'tmp_pids' => 'tmp/pids',
  'public_uploads' => 'public/uploads'
}

application node['application_web']['app_name'] do
  path "/var/www/apps/#{node['application_web']['app_name']}"
  environment_name node['application_web']['environment']
  owner deploy_user
  group deploy_group

  repository node['application_web']['repository']
  revision node['application_web']['revision']

  before_symlink do
    shared_children.each do |dir, _|
      directory "#{shared_path}/#{dir}" do
        owner deploy_user
        group deploy_group
        mode "0755"
      end
    end
  end

  purge_before_symlink shared_children.values
  symlinks shared_children

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
    application_port        8080
    static_files            '/assets' => 'public/assets'
    ssl                     true
    ssl_certificate         node['ssl_certificates']['crt_file']
    ssl_certificate_key     node['ssl_certificates']['key_file']
    template                'load_balancer.conf.erb'
  end
end
