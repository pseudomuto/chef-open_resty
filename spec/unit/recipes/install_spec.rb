#
# Cookbook Name:: open_resty
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require "spec_helper"

describe "open_resty::install" do
  context "with default attributes" do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it "should make install open resty" do
      expect(chef_run).to install_with_make_ark("openresty")
    end
  end

  context "when version and checksum are supplied" do
    let(:version)  { "1.7.9.0" }
    let(:checksum) { "a" * 64 }

    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new do |node|
        node.set["open_resty"]["version"]  = version
        node.set["open_resty"]["checksum"] = checksum
      end

      runner.converge(described_recipe)
    end

    it "should make install the specific version of open resty" do
      expect(chef_run).to install_with_make_ark("openresty").with(
        version: version,
        checksum: checksum
      )
    end
  end
end
