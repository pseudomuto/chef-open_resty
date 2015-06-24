#
# Cookbook Name:: open_resty
# Recipe:: install
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

version  = node["open_resty"]["version"]
checksum = node["open_resty"]["checksum"]

ark "openresty" do
  url "http://openresty.org/download/ngx_openresty-#{version}.tar.gz"
  version version
  checksum checksum
  autoconf_opts %w(--with-pcre-jit --with-ipv6)
  action :install_with_make
end
