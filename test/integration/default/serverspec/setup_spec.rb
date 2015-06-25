require "spec_helper"

describe "open_resty::setup" do
  describe file("/var/www") do
    it { should be_directory }
    it { should be_mode(755) }
    it { should be_owned_by("www-data") }
  end

  describe file("/etc/nginx") do
    it { should be_directory }
    it { should be_mode(755) }
    it { should be_owned_by("root") }
  end

  %w(conf.d sites-available sites-enabled ssl).each do |sub_dir|
    describe file("/etc/nginx/#{sub_dir}") do
      it { should be_directory }
      it { should be_mode(755) }
      it { should be_owned_by("root") }
    end
  end

  describe file("/var/log/nginx") do
    it { should be_directory }
    it { should be_mode(755) }
    it { should be_owned_by("root") }
  end
end
