# encoding: utf-8

class Default < Thor
  include Thor::Actions
  add_runtime_options!

  desc 'deploy [pattern] [-r role_pattern] [-u]',
       'Applies the recipe to all nodes that match query'
  method_option :role, type: :string, default: nil, aliases: '-r'
  method_option :upload, type: :boolean, default: false, aliases: '-u'
  def deploy(pattern=nil)
    call_upload if options.upload?
    run "bundle exec knife ssh \"#{determine_pattern(pattern)}\" -x deploy \"sudo chef-client\""
  end

  private

  def determine_pattern(given_pattern)
    if given_pattern
      given_pattern
    elsif options.role
      "role:#{options.role}"
    else
      'role:*'
    end
  end

  def call_upload
    Upload.new.invoke :all, [], options
  end
end

class Upload < Thor
  include Thor::Actions
  add_runtime_options!

  default_task :all

  desc 'all',
       'Upload all roles and cookbooks to chef server'
  def all
    invoke :roles
    invoke :cookbooks
  end

  desc 'roles [role1, role2..]',
       'Upload roles to chef server. No args means all.'
  def roles(*role_names)
    list = roles_list(role_names)
    raise ArgumentError.new("no roles match #{role_names.join(', ')}") if list.empty?
    list.each do |role_path|
      run "bundle exec knife role from file #{role_path}"
    end
  end

  desc 'cookbooks [cookbook1, cookbook2]',
       'Upload cookbooks to chef server. No args means all.'
  def cookbooks(*cookbook_names)
    list = cookbooks_list(cookbook_names)
    raise ArgumentError.new("no cookbooks match #{cookbook_names.join(', ')}") if list.empty?
    list.each do |cookbook_name|
      run "bundle exec knife cookbook upload #{cookbook_name}"
    end
  end

  private

  def roles_list(role_names)
    if role_names.empty?
      existing_roles
    else
      existing_roles & requested_roles(role_names)
    end
  end

  def existing_roles
    Dir.glob('roles/*.rb')
  end

  def requested_roles(role_names)
    role_names.map {|r| "roles/#{r}.rb"}
  end

  def cookbooks_list(cookbook_names)
    if cookbook_names.empty?
      ['-a']
    else
      existing_cookbooks & cookbook_names
    end
  end

  def existing_cookbooks
    Dir.glob('cookbooks/*').map { |cookbook_path|
      cookbook_path.scan(/\/(.*)$/).first.first
    }
  end
end

class Node < Thor
  include Thor::Actions
  add_runtime_options!

  desc 'assign staging.your-domain.com base web-staging',
       'Assign roles to the node'
  def assign(node, *roles)
    raise ArgumentError.new("Can't assign empty roles list") if roles.empty?
    roles_list = roles.map {|r| "role[#{r}]"}.join(',')
    run "bundle exec node run_list add #{node} \"#{roles_list}\""
  end
end
