service_options = {
  conf: ::File.join(node["open_resty"]["nginx"]["dir"], "nginx.conf")
}

action :create do
  runit_service "nginx" do
    default_logger true
    reload_command "sv reload nginx"
    options service_options
  end
end

action :restart do
  runit_service "nginx" do
    default_logger true
    reload_command "sv reload nginx"
    options service_options
    action :restart
  end
end

action :reload do
  runit_service "nginx" do
    default_logger true
    reload_command "sv reload nginx"
    options service_options
    action :reload
  end
end
