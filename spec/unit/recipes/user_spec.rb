#
# Cookbook Name:: open_resty
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require "spec_helper"

describe "open_resty::user" do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new
    runner.converge(described_recipe)
  end

  it "creates a system user for nginx" do
    expect(chef_run).to create_user("www-data")
  end
end
