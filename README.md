# open_resty
[![Build Status](https://travis-ci.org/pseudomuto/chef-open_resty.svg?branch=master)](https://travis-ci.org/pseudomuto/chef-open_resty)

A cookbook for installing [openresty].

## Dependencies

* `apt`
* `ark`

## Basic Usage

```json
run_list: ["recipe[open_resty]"],
"default_attributes": {
  "open_resty": {
    ...
  }
}
```

## Attributes

### Default
Name | Description | Default
-----| ----------- | -------
`node["open_resty"]["user"]` | The user to run as | `www-data`
`node["open_resty"]["home"]` | The home directory for nginx | `/var/www`

### Source
Name | Description | Default
-----| ----------- | -------
`node["open_resty"]["source"]["version"]` | The version to install | `1.9.3.2`
`node["open_resty"]["source"]["checksum"]` | The checksum for the version | see _attributes/default.rb_

### Nginx
Name | Description | Default
-----| ----------- | -------
`node["open_resty"]["nginx"]["dir"]` | Where to setup nginx | `/etc/nginx`
`node["open_resty"]["nginx"]["log_dir"]` | Nginx log directory | `/var/log/nginx`

#### These all correlate to nginx directives (of the same name)
Name | Default
-----| -------
`node["open_resty"]["nginx"]["worker_processes"]` | `auto` - 1 per CPU
`node["open_resty"]["nginx"]["worker_rlimit_nofile"]` | `200,000`
`node["open_resty"]["nginx"]["worker_connections"]` | `4096`
`node["open_resty"]["nginx"]["pid"]` | `/var/run/nginx.pid`
`node["open_resty"]["nginx"]["gzip"]` | `on`
`node["open_resty"]["nginx"]["gzip_buffers"]` | `16 8k`
`node["open_resty"]["nginx"]["gzip_http_version"]` | `1.0`
`node["open_resty"]["nginx"]["gzip_comp_level"]` | `6`
`node["open_resty"]["nginx"]["gzip_min_length"]` | `256`
`node["open_resty"]["nginx"]["gzip_proxied"]` | `any`
`node["open_resty"]["nginx"]["gzip_disable"]` | `MSIE [1-6]\.(?!\.*SV1)`
`node["open_resty"]["nginx"]["gzip_vary"]` | `on`
`node["open_resty"]["nginx"]["gzip_types"]` | _see attributes/nginx.rb_
`node["open_resty"]["nginx"]["open_file_cache_max"]` | `1000`
`node["open_resty"]["nginx"]["open_file_cache_inactive"]` | `20s`
`node["open_resty"]["nginx"]["open_file_cache_valid"]` | `30s`
`node["open_resty"]["nginx"]["open_file_cache_min_uses"]` | `2`
`node["open_resty"]["nginx"]["open_file_cache_errors"]` | `on`
`node["open_resty"]["nginx"]["server_names_hash_bucket_size"]` | `64`
`node["open_resty"]["nginx"]["types_hash_bucket_size"]` | `64`
`node["open_resty"]["nginx"]["types_hash_max_size"]` | `2048`
`node["open_resty"]["nginx"]["client_body_buffer_size"]` | `8k`
`node["open_resty"]["nginx"]["client_max_body_size"]` | `20M`
`node["open_resty"]["nginx"]["large_client_header_buffers"]` | `32 32k`
`node["open_resty"]["nginx"]["lua_use_default_type"]` | `off`
`node["open_resty"]["nginx"]["lua_package_path"]` | `;;`
`node["open_resty"]["nginx"]["lua_package_cpath"]` | `;;`

#### Lua Settings
Name | Description | Default
-----| ----------- | -------
`node["open_resty"]["lua_modules"]` | An array of modules to make available during `init_by_lua` | `[]`

[openresty]: http://www.openresty.org/
