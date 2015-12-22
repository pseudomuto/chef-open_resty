#
# Cookbook Name:: open_resty
# Spec:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

require "spec_helper"

describe "open_resty::default" do
  INCLUDED_RECIPES = %w(apt user install setup)

  cached(:chef_run) do
    runner = ChefSpec::ServerRunner.new
    runner.converge(described_recipe)
  end

  it "includes runit recipe" do
    expect(chef_run).to include_recipe("runit")
  end

  INCLUDED_RECIPES.each do |recipe|
    it "includes the #{recipe} recipe" do
      expect(chef_run).to include_recipe("open_resty::#{recipe}")
    end
  end
end
