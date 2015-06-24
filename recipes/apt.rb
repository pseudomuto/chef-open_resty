#
# Cookbook Name:: open_resty
# Recipe:: apt
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

PACKAGES = %w(
  libreadline-dev
  libncurses5-dev
  libpcre3-dev
  libssl-dev
  perl
  build-essential
)

include_recipe("apt")

PACKAGES.each do |pkg|
  package(pkg) { action :install }
end
