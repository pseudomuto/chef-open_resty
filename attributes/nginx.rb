default["open_resty"]["nginx"]["dir"]     = "/etc/nginx"
default["open_resty"]["nginx"]["log_dir"] = "/var/log/nginx"

default["open_resty"]["nginx"]["worker_processes"]     = "auto"
default["open_resty"]["nginx"]["worker_rlimit_nofile"] = 2_000_00
default["open_resty"]["nginx"]["worker_connections"]   = 4096
default["open_resty"]["nginx"]["pid"]                  = "/var/run/nginx.pid"

default["open_resty"]["nginx"]["gzip"]              = "on"
default["open_resty"]["nginx"]["gzip_buffers"]      = "16 8k"
default["open_resty"]["nginx"]["gzip_http_version"] = "1.0"
default["open_resty"]["nginx"]["gzip_comp_level"]   = 6
default["open_resty"]["nginx"]["gzip_min_length"]   = 256
default["open_resty"]["nginx"]["gzip_proxied"]      = "any"
default["open_resty"]["nginx"]["gzip_disable"]      = "MSIE [1-6]\.(?!\.*SV1)"
default["open_resty"]["nginx"]["gzip_vary"]         = "on"
default["open_resty"]["nginx"]["gzip_types"]        = %w(
  application/javascript
  application/json
  application/vnd.ms-fontobject
  application/x-font-ttf
  application/x-javascript
  application/xml
  application/xml+rss
  font/opentype
  image/svg+xml
  image/x-icon
  text/css
  text/javascript
  text/plain
  text/xml
)

default["open_resty"]["nginx"]["open_file_cache_max"]      = 1000
default["open_resty"]["nginx"]["open_file_cache_inactive"] = "20s"
default["open_resty"]["nginx"]["open_file_cache_valid"]    = "30s"
default["open_resty"]["nginx"]["open_file_cache_min_uses"] = 2
default["open_resty"]["nginx"]["open_file_cache_errors"]   = "on"

default["open_resty"]["nginx"]["server_names_hash_bucket_size"] = 64
default["open_resty"]["nginx"]["types_hash_bucket_size"]        = 64
default["open_resty"]["nginx"]["types_hash_max_size"]           = 2048
default["open_resty"]["nginx"]["client_body_buffer_size"]       = "8k"
default["open_resty"]["nginx"]["client_max_body_size"]          = "20M"
default["open_resty"]["nginx"]["large_client_header_buffers"]   = "32 32k"

default["open_resty"]["nginx"]["lua_use_default_type"] = "off"
default["open_resty"]["nginx"]["lua_package_path"]     = ";;"
default["open_resty"]["nginx"]["lua_package_cpath"]    = ";;"
