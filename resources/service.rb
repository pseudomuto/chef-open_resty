default_action :create

def configure_service(service)
  service_dir = run_context.node["open_resty"]["nginx"]["dir"]

  service.default_logger(true)
  service.reload_command("sv reload nginx")
  service.options(conf: ::File.join(service_dir, "nginx.conf"))
end

action :create do
  runit_service "nginx" do
    configure_service(self)
  end
end

action :restart do
  runit_service "nginx" do
    configure_service(self)
    action :restart
  end
end

action :reload do
  runit_service "nginx" do
    configure_service(self)
    action :reload
  end
end
