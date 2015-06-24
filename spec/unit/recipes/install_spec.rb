#
# Cookbook Name:: open_resty
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require "spec_helper"

describe "open_resty::install" do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new
    runner.converge(described_recipe)
  end

  it "should make install open resty" do
    expect(chef_run).to install_with_make_ark("openresty")
  end
end
