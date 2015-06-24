#
# Cookbook Name:: open_resty
# Recipe:: user
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

user node["open_resty"]["user"] do
  system true
  shell "/bin/false"
  home "/var/www"
end
