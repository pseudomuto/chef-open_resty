attribute :name, kind_of: String, name_attribute: true
attribute :variables, kind_of: Array

nginx_path = node["open_resty"]["nginx"]["dir"]

action :create do
  conf_path = ::File.join(nginx_path, "sites-available", ::File.basename(new_resource.name, ".erb"))

  template conf_path do
    source new_resource.name
    variables new_resource.variables
    user "root"
    group "root"
    mode 00644
  end
end

action :delete do
  conf_path = ::File.join(nginx_path, "sites-available", ::File.basename(new_resource.name, ".erb"))
  link_path = ::File.join(nginx_path, "sites-enabled", ::File.basename(new_resource.name, ".erb"))

  open_resty_service "nginx" do
    action :nothing
  end

  file link_path do
    action :delete
    only_if { ::File.exist?(link_path) }
    notifies :reload, "open_resty_service[nginx]"
  end

  file conf_path do
    action :delete
    only_if { ::File.exist?(conf_path) }
  end
end

action :enable do
  conf_path = ::File.join(nginx_path, "sites-available", ::File.basename(new_resource.name, ".erb"))
  link_path = ::File.join(nginx_path, "sites-enabled", ::File.basename(new_resource.name, ".erb"))

  open_resty_service "nginx" do
    action :nothing
  end

  link link_path do
    to conf_path
    owner "root"
    group "root"
    mode 00644
    not_if { ::File.exist?(link_path) }
    notifies :reload, "open_resty_service[nginx]"
  end
end

action :disable do
  link_path = ::File.join(nginx_path, "sites-enabled", ::File.basename(new_resource.name, ".erb"))

  open_resty_service "nginx" do
    action :nothing
  end

  link link_path do
    action :delete
    only_if { ::File.exist?(link_path) }
    notifies :reload, "open_resty_service[nginx]"
  end
end
