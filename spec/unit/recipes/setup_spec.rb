#
# Cookbook Name:: open_resty
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require "spec_helper"

describe "open_resty::setup" do
  context "when default parameters are used" do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.converge(described_recipe)
    end

    it "creates the home directory for the nginx user" do
      expect(chef_run).to create_directory("/var/www").with(
        owner: "www-data",
        group: "www-data",
        mode: 00755
      )
    end

    it "creates the nginx directory" do
      expect(chef_run).to create_directory("/etc/nginx").with(
        owner: "root",
        group: "root",
        mode: 00755
      )

      %w(conf.d sites-available sites-enabled ssl).each do |subdir|
        expect(chef_run).to create_directory("/etc/nginx/#{subdir}").with(
          owner: "root",
          group: "root",
          mode: 00755
        )
      end
    end

    it "creates the log directory" do
      expect(chef_run).to create_directory("/var/log/nginx").with(
        owner: "root",
        group: "root",
        mode: 00755
      )
    end

    it "creates the nginx.conf file" do
      expect(chef_run).to create_template("/etc/nginx/nginx.conf").with(
        owner: "root",
        group: "root",
        mode: 0644
      )
    end

    it "installs and enables the runit service" do
      expect(chef_run).to create_open_resty_service("nginx")
    end
  end

  context "when custom attribute values are supplied" do
    cached(:chef_run) do
      runner = ChefSpec::ServerRunner.new do |node|
        node.set["open_resty"]["user"]  = "nginx-www"
        node.set["open_resty"]["nginx"] = {
          "dir" => "/etc/nginx_special",
          "log_dir" => "/var/www/logs"
        }
      end

      runner.converge(described_recipe)
    end

    it "creates the home directory for the nginx user" do
      expect(chef_run).to create_directory("/var/www").with(
        owner: "nginx-www",
        group: "nginx-www",
        mode: 00755
      )
    end

    it "creates the nginx directory" do
      expect(chef_run).to create_directory("/etc/nginx_special").with(
        owner: "root",
        group: "root",
        mode: 00755
      )

      %w(conf.d sites-available sites-enabled ssl).each do |subdir|
        expect(chef_run).to create_directory("/etc/nginx_special/#{subdir}").with(
          owner: "root",
          group: "root",
          mode: 00755
        )
      end
    end

    it "creates the log directory" do
      expect(chef_run).to create_directory("/var/www/logs").with(
        owner: "root",
        group: "root",
        mode: 00755
      )
    end

    it "installs and enables the runit service" do
      expect(chef_run).to create_open_resty_service("nginx")
    end
  end
end
