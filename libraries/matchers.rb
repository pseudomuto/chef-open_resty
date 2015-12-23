if defined?(ChefSpec)
  def create_nginx_site(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:open_resty_site, :create, resource_name)
  end

  def enable_nginx_site(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:open_resty_site, :enable, resource_name)
  end

  def create_open_resty_service(resource_name)
    ChefSpec::Matchers::ResourceMatcher.new(:open_resty_service, :create, resource_name)
  end
end
