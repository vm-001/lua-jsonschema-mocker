local random = math.random
local type = type

local _M = {}

function _M.generate(self, schema, opts)
  local min_items = type(schema.minItems) == "number" and schema.minItems or opts.array.min_items
  local max_items = type(schema.maxItems) == "number" and schema.maxItems or opts.array.max_items

  local value = {}

  if type(schema.items) == "table" then
    local n = random(min_items, max_items)
    for i = 1, n do
      value[i] = self:mock(schema.items)
    end
  end

  return value
end

return _M
