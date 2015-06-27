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
  link_action = file(enabled_site_path) do
    action :delete
    only_if { ::File.exists?(enabled_site_path) }
  end

  source_action = file(available_site_path) do
    action :delete
    only_if { ::File.exists?(available_site_path) }
  end

  updated = link_action.updated_by_last_action? || source_action.updated_by_last_action?
  new_resource.updated_by_last_action(updated)

  # TODO: reload nginx
end

action :enable do
  sub_action = link(enabled_site_path) do
    to available_site_path
    owner "root"
    group "root"
    mode 0644
    not_if { ::File.exists?(enabled_site_path) }
  end

  new_resource.updated_by_last_action(sub_action.updated_by_last_action?)

  # TODO: reload nginx
end

action :disable do
  sub_action = link(enabled_site_path) do
    action :delete
    only_if { ::File.exists?(enabled_site_path) }
  end

  new_resource.updated_by_last_action(sub_action.updated_by_last_action?)

  # TODO: reload nginx
end
