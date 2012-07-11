nginx_site "default" do
  enable false
end

template "/etc/nginx/sites-available/copycopter" do
  source "copycopter.conf.erb"
  mode 644
end

nginx_site 'copycopter' do
  enable true
end