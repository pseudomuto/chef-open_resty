local _M = {}

function _M.call()
  ngx.say("Content returned from the module")
end

return _M
