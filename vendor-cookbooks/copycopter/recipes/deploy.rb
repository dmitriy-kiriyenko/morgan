deploy_user  = node[:deploy_user][:name]
deploy_group = node[:deploy_user][:group]
database_params = node[:copycopter][:database]

application "copycopter" do
  path "/var/www/apps/copycopter"
  owner deploy_user
  group deploy_group

  before_symlink do
    execute 'create_and_migrate_database' do
      command 'bundle exec rake db:create db:migrate'
      user deploy_user
      group deploy_group
      cwd release_path
      environment ({'RAILS_ENV' => node[:copycopter][:environment]})
    end

    execute "compile_assets" do
      command "bundle exec rake assets:precompile"
      user deploy_user
      group deploy_group
      cwd release_path
      environment ({"RAILS_ENV" => node[:copycopter][:environment]})
    end
  end

  repository "git@github.com:iafonov/copycopter-server.git"
  revision node[:copycopter][:revision]

  rails do
    gems ["bundler"]

    database do
      database_params.each do |key, value|
        send(key.to_sym, value)
      end
    end
  end

  unicorn do
    restart_command do
      execute "/etc/init.d/copycopter restart" do
      end
    end
  end
end