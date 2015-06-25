# open_resty

A cookbook for installing [openresty].

## Dependencies

* `apt`
* `ark`

## Attributes

### Default
Name | Description | Default
-----| ----------- | -------
`node["open_resty"]["user"]` | The user to run as | `www-data`
`node["open_resty"]["home"]` | The home directory for nginx | `/var/www`

### Source
Name | Description | Default
-----| ----------- | -------
`node["open_resty"]["source"]["version"]` | The version to install | `1.7.10.1`
`node["open_resty"]["source"]["checksum"]` | The checksum for the version | see _attributes/default.rb_

### Nginx
Name | Description | Default
-----| ----------- | -------
`node["open_resty"]["nginx"]["dir"]` | Where to setup nginx | `/etc/nginx`
`node["open_resty"]["nginx"]["log_dir"]` | Nginx log directory | `/var/log/nginx`

[openresty]: http://www.openresty.org/
