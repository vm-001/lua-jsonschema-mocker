local pairs = pairs
local ipairs = ipairs

local _M = {}

function _M.generate(self, schema, opts)
  local value = {}
  if schema.properties then
    if opts.object.only_required_properties then
      for _, k in ipairs(schema.required) do
        value[k] = self:mock(schema.properties[k])
      end
    else
      for k, v in pairs(schema.properties) do
        value[k] = self:mock(v)
      end
    end
  end
  return value
end

return _M
