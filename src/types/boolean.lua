local random = math.random

local _M = {}

function _M.generate(self, schema, opts)
  return random(0, 1) == 0
end

return _M
