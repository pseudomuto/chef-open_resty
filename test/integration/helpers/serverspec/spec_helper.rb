require "serverspec"

set :backend, :exec
set :os, family: "ubuntu", release: "14.04", arch: "x86_64"
