require "chefspec"
require "chefspec/berkshelf"

Dir["./spec/support/**/*.rb"].each { |f| require f }

RSpec.configure do |config|
  config.platform = "ubuntu"
  config.version  = "14.04"
end

# this exists upstream, but not released to supermarket yet
def install_with_make_ark(resource_name)
  ChefSpec::Matchers::ResourceMatcher.new(:ark, :install_with_make, resource_name)
end
