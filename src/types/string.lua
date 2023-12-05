--local new_tab = require "table.new"

local type = type
local date = os.date
local random = math.random
local concat = table.concat


local _M = {}

local formatters = {
  ["date"] = function()
    return date("!%Y-%m-%d")
  end,
  ["date-time"] = function()
    return date("!%Y-%m-%dT%H:%M:%SZ")
  end,
}

local function random_character(charset)
  local i = random(1, #charset)
  return charset:sub(i, i)
end

local function random_string(min_length, max_length, charset)
  local length = random(min_length, max_length)
  --local buf = new_tab(length, 0)
  local buf = {}
  for i = 1, length do
    buf[i] = random_character(charset)
  end

  return concat(buf)
end


function _M.generate(slef, schema, opts)
  local min_length = type(schema.minLength) == "number" and schema.minLength or opts.string.min_length
  local max_length = type(schema.maxLength) == "number" and schema.maxLength or opts.string.max_length

  -- format
  if schema.format then
    local formatter = opts.string.formatters and opts.string.formatters[schema.format]
    if not formatter then
      formatter = formatters[schema.format]
    end
    if formatter then
      return formatter()
    end
  end

  -- pattern: does not support yet

  return random_string(min_length, max_length, opts.string.charset)
end


return _M
