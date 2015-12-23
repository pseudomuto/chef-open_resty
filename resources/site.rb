attribute :name, kind_of: String, name_attribute: true
attribute :variables, kind_of: Array

def nginx_path
  run_context.node["open_resty"]["nginx"]["dir"]
end

def conf_path
  ::File.join(nginx_path, "sites-available", ::File.basename(name, ".erb"))
end

def link_path
  ::File.join(nginx_path, "sites-enabled", ::File.basename(name, ".erb"))
end

action :create do
  template new_resource.conf_path do
    source new_resource.name
    variables new_resource.variables
    user "root"
    group "root"
    mode 00644
  end
end

action :delete do
  open_resty_service "nginx" do
    action :nothing
  end

  file new_resource.link_path do
    action :delete
    only_if { ::File.exist?(new_resource.link_path) }
    notifies :reload, "open_resty_service[nginx]"
  end

  file new_resource.conf_path do
    action :delete
    only_if { ::File.exist?(new_resource.conf_path) }
  end
end

action :enable do
  open_resty_service "nginx" do
    action :nothing
  end

  link new_resource.link_path do
    to new_resource.conf_path
    owner "root"
    group "root"
    mode 00644
    not_if { ::File.exist?(new_resource.link_path) }
    notifies :reload, "open_resty_service[nginx]"
  end
end

action :disable do
  open_resty_service "nginx" do
    action :nothing
  end

  link new_resource.link_path do
    action :delete
    only_if { ::File.exist?(new_resource.link_path) }
    notifies :reload, "open_resty_service[nginx]"
  end
end
