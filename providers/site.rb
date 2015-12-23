use_inline_resources

def nginx_path
  node["open_resty"]["nginx"]["dir"]
end

def available_site_path
  ::File.join(nginx_path, "sites-available", ::File.basename(new_resource.name, ".erb"))
end

def enabled_site_path
  ::File.join(nginx_path, "sites-enabled", ::File.basename(new_resource.name, ".erb"))
end

action :create do
  sub_action = template(available_site_path) do
    source new_resource.name
    variables new_resource.variables
    user "root"
    group "root"
    mode 0644
  end

  new_resource.updated_by_last_action(sub_action.updated_by_last_action?)
end

action :delete do
  open_resty_service "nginx" do
    action :nothing
  end

  link_action = file(enabled_site_path) do
    action :delete
    only_if { ::File.exist?(enabled_site_path) }
    notifies :reload, "open_resty_service[nginx]"
  end

  source_action = file(available_site_path) do
    action :delete
    only_if { ::File.exist?(available_site_path) }
  end

  updated = link_action.updated_by_last_action? || source_action.updated_by_last_action?
  new_resource.updated_by_last_action(updated)
end

action :enable do
  open_resty_service "nginx" do
    action :nothing
  end

  sub_action = link(enabled_site_path) do
    to available_site_path
    owner "root"
    group "root"
    mode 0644
    not_if { ::File.exist?(enabled_site_path) }
    notifies :reload, "open_resty_service[nginx]"
  end

  new_resource.updated_by_last_action(sub_action.updated_by_last_action?)
end

action :disable do
  open_resty_service "nginx" do
    action :nothing
  end

  sub_action = link(enabled_site_path) do
    action :delete
    only_if { ::File.exist?(enabled_site_path) }
    notifies :reload, "open_resty_service[nginx]"
  end

  new_resource.updated_by_last_action(sub_action.updated_by_last_action?)
end
