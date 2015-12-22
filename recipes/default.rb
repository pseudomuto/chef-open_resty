#
# Cookbook Name:: open_resty
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe "runit"

include_recipe "open_resty::apt"
include_recipe "open_resty::user"
include_recipe "open_resty::install"
include_recipe "open_resty::setup"
