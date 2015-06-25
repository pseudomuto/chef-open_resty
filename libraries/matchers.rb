if defined?(ChefSpec)
  def install_with_make_ark(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:ark, :install_with_make, resource_name)
  end
end
