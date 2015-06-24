require "spec_helper"

describe "open_resty::install" do
  describe file("/usr/local/openresty/nginx/sbin/nginx") do
    it { should exist }
    it { should be_executable }
  end
end
