#
# Cookbook Name:: open_resty
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require "spec_helper"

describe "open_resty::default" do
  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new
    runner.converge(described_recipe)
  end

  it "includes the apt recipe" do
    expect(chef_run).to include_recipe("open_resty::apt")
  end

  it "includes the user recipe" do
    expect(chef_run).to include_recipe("open_resty::user")
  end
end
