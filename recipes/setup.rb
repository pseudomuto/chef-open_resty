#
# Cookbook Name:: open_resty
# Recipe:: setup
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

nginx_user  = node["open_resty"]["user"]
nginx_group = nginx_user

nginx_dir     = node["open_resty"]["nginx"]["dir"]
nginx_log_dir = node["open_resty"]["nginx"]["log_dir"]
nginx_subdirs = %w(conf.d sites-available sites-enabled ssl)
nginx_testing = node["open_resty"]["testing"]

nginx_worker_processes = node["open_resty"]["nginx"]["worker_processes"]
if nginx_worker_processes == "auto"
  nginx_worker_processes = node.fetch("cpu", {}).fetch("total", 1)
end

lua_variables = {
  use_default_type:  node["open_resty"]["nginx"]["lua_use_default_type"],
  package_path:      node["open_resty"]["nginx"]["lua_package_path"],
  package_cpath:     node["open_resty"]["nginx"]["lua_package_cpath"],
  modules:           node["open_resty"]["lua_modules"]
}

nginx_template_vars = {
  user:                  nginx_user,
  group:                 nginx_group,
  config_includes:       "#{nginx_dir}/conf.d/*.conf",
  sites_enabled:         "#{nginx_dir}/sites-enabled/*",
  worker_processes:      nginx_worker_processes,
  worker_rlimit_nofile:  node["open_resty"]["nginx"]["worker_rlimit_nofile"],
  worker_connections:    node["open_resty"]["nginx"]["worker_connections"],
  pid:                   node["open_resty"]["nginx"]["pid"],
  access_log:            ::File.join(nginx_log_dir, "access.log"),
  error_log:             ::File.join(nginx_log_dir, "error.log"),

  gzip:               node["open_resty"]["nginx"]["gzip"],
  gzip_buffers:       node["open_resty"]["nginx"]["gzip_buffers"],
  gzip_http_version:  node["open_resty"]["nginx"]["gzip_http_version"],
  gzip_comp_level:    node["open_resty"]["nginx"]["gzip_comp_level"],
  gzip_min_length:    node["open_resty"]["nginx"]["gzip_min_length"],
  gzip_proxied:       node["open_resty"]["nginx"]["gzip_proxied"],
  gzip_disable:       node["open_resty"]["nginx"]["gzip_disable"],
  gzip_vary:          node["open_resty"]["nginx"]["gzip_vary"],
  gzip_types:         node["open_resty"]["nginx"]["gzip_types"],

  open_file_cache_max:       node["open_resty"]["nginx"]["open_file_cache_max"],
  open_file_cache_inactive:  node["open_resty"]["nginx"]["open_file_cache_inactive"],
  open_file_cache_valid:     node["open_resty"]["nginx"]["open_file_cache_valid"],
  open_file_cache_min_uses:  node["open_resty"]["nginx"]["open_file_cache_min_uses"],
  open_file_cache_errors:    node["open_resty"]["nginx"]["open_file_cache_errors"],

  server_names_hash_bucket_size:  node["open_resty"]["nginx"]["server_names_hash_bucket_size"],
  types_hash_bucket_size:         node["open_resty"]["nginx"]["types_hash_bucket_size"],
  types_hash_max_size:            node["open_resty"]["nginx"]["types_hash_max_size"],
  client_body_buffer_size:        node["open_resty"]["nginx"]["client_body_buffer_size"],
  client_max_body_size:           node["open_resty"]["nginx"]["client_max_body_size"],
  large_client_header_buffers:    node["open_resty"]["nginx"]["large_client_header_buffers"],

  lua_variables: lua_variables
}

directory node["open_resty"]["home"] do
  owner nginx_user
  group nginx_group
  mode 00755
  recursive true
end

directory nginx_dir do
  owner "root"
  group "root"
  mode 00755
  recursive true
end

nginx_subdirs.each do |subdir|
  directory ::File.join(nginx_dir, subdir) do
    owner "root"
    group "root"
    mode 00755
  end
end

directory nginx_log_dir do
  owner "root"
  group "root"
  mode 00755
end

template ::File.join(nginx_dir, "nginx.conf") do
  source "nginx.conf.erb"
  variables nginx_template_vars
  owner "root"
  group "root"
  mode 00644
  notifies :reload, "open_resty_service[nginx]"
end

cookbook_file "test_module.lua" do
  path "/var/www/test_module.lua"
  action :create_if_missing
  only_if { nginx_testing }
end

open_resty_service "nginx"

open_resty_site "test_site.conf.erb" do
  action [:create, :enable]
  only_if { nginx_testing }
end
