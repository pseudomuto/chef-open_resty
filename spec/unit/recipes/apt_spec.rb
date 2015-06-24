#
# Cookbook Name:: open_resty
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require "spec_helper"

describe "open_resty::apt" do
  EXPECTED_PACKAGES = %w(
    libreadline-dev
    libncurses5-dev
    libpcre3-dev
    libssl-dev
    perl
    build-essential
  )

  let(:chef_run) do
    runner = ChefSpec::ServerRunner.new
    runner.converge(described_recipe)
  end

  it "should include the apt recipe" do
    expect(chef_run).to include_recipe("apt")
  end

  EXPECTED_PACKAGES.each do |pkg|
    it "should install #{pkg}" do
      expect(chef_run).to install_package(pkg)
    end
  end
end
