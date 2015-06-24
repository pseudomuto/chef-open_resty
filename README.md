# open_resty

A cookbook for installing [openresty].

## Dependencies

* `apt`
* `ark`

## Attributes

Name | Description | Default
-----| ----------- | -------
`node["open_resty"]["user"]` | The user to run as | `www-data`
`node["open_resty"]["home]"` | The home directory for nginx | `/var/www`
`node["open_resty"]["version"]` | The version to install | `1.7.10.1`
`node["open_resty"]["checksum"]` | The checksum for the version | see _attributes/default.rb_

[openresty]: http://www.openresty.org/
