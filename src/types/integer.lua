local random = math.random

local _M = {}

function _M.generate(self, schema, opts)
  local range_minimum, range_maximum

  if schema.exclusiveMinimum and schema.minimum then
    range_minimum = schema.exclusiveMinimum == true and schema.minimum + 1 or schema.minimum
  elseif schema.exclusiveMinimum then
    range_minimum = schema.exclusiveMinimum == true and opts.integer.minimum or schema.exclusiveMinimum + 1
  else
    range_minimum = schema.minimum or opts.integer.minimum
  end

  if schema.exclusiveMaximum and schema.maximum then
    range_maximum = schema.exclusiveMaximum == true and schema.maximum - 1 or schema.maximum
  elseif schema.exclusiveMaximum then
    range_maximum = schema.exclusiveMaximum == true and opts.integer.maximum or schema.exclusiveMaximum - 1
  else
    range_maximum = schema.maximum or opts.integer.maximum
  end

  return random(range_minimum, range_maximum)
end

return _M
