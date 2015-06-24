require "spec_helper"

describe "open_resty::user" do
  describe user("www-data") do
    it { should exist }
    it { should belong_to_group("www-data") }
    it { should have_home_directory("/var/www") }
    it { should have_login_shell("/bin/false") }
  end
end
