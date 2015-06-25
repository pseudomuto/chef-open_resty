#
# Cookbook Name:: open_resty
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require "spec_helper"

describe "open_resty::user" do
  context "when default attributes are used" do
    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new
      runner.converge(described_recipe)
    end

    it "creates a system user for nginx" do
      expect(chef_run).to create_user("www-data").with(
        system: true,
        shell: "/bin/false",
        home: "/var/www"
      )
    end
  end

  context "when the custom attribute is set" do
    let(:user) { "myuser" }
    let(:home) { "/some/location" }

    let(:chef_run) do
      runner = ChefSpec::SoloRunner.new do |node|
        node.set["open_resty"]["user"] = user
        node.set["open_resty"]["home"] = home
      end

      runner.converge(described_recipe)
    end

    it "creates the specified user for nginx" do
      expect(chef_run).to create_user(user).with(
        system: true,
        shell: "/bin/false",
        home: home
      )
    end
  end
end
