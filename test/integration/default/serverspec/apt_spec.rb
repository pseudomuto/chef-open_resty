require "spec_helper"

describe "open_resty::apt" do
  PACKAGES = %w(
    libreadline-dev
    libncurses5-dev
    libpcre3-dev
    libssl-dev
    perl
    build-essential
  )

  PACKAGES.each do |pkg|
    describe package(pkg) do
      it { should be_installed }
    end
  end
end
