#
# Cookbook Name:: open_resty
# Recipe:: setup
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

nginx_user  = node["open_resty"]["user"]
nginx_group = nginx_user

nginx_dir = node["open_resty"]["nginx"]["dir"]
nginx_log_dir = node["open_resty"]["nginx"]["log_dir"]
nginx_subdirs = %w(conf.d sites-available sites-enabled ssl)

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
  directory File.join(nginx_dir, subdir) do
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
