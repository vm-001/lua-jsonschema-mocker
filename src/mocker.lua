local default_options = require "jsonschema-mocker.options"
local utils = require "jsonschema-mocker.utils"

local type = type
local ipairs = ipairs
local tostring = tostring
local random = math.random
local table_merge = utils.table_merge
local table_deepcopy = utils.table_deepcopy

local _M = {}
local _mt = { __index = _M }

local generator = {}
do
  local types = { "boolean", "integer", "number", "string", "null", "object", "array" }
  setmetatable(generator, {
    __index = function(table, key)
      return function(self, schema, opts)
        return "Unknown Type: " .. tostring(key)
      end
    end
  })
  for _, t in ipairs(types) do
    local module = require("jsonschema-mocker.types." .. t)
    generator[t] = module.generate
  end
end


-- mock generate a mock
function _M:mock(schema)
  if type(schema) ~= "table" then
    error("invalid type of schema")
  end

  schema = table_deepcopy(schema)

  while schema.allOf or schema.oneOf do
    local resolved_schema = {}
    local allOf = schema.allOf
    local oneOf = schema.oneOf

    schema.allOf = nil
    schema.oneOf = nil

    if type(allOf) == "table" then
      for _, v in ipairs(allOf) do
        resolved_schema = table_merge(resolved_schema, v, true)
      end
    end

    if type(oneOf) == "table" then
      resolved_schema = table_merge(resolved_schema, oneOf[random(1, #oneOf)], true)
    end

    schema = table_merge(schema, resolved_schema)
  end

  local res
  if type(schema.enum) == "table" and #schema.enum > 0 then
    res = schema.enum[random(1, #schema.enum)]
  else
    local typ = schema.type == nil and "object" or schema.type
    res = generator[typ](self, schema, self.options)
  end

  return self.options.customize(res, schema)
end


-- new new a mocker instance
function _M.new(opts)
  opts = opts or {}

  local options = table_deepcopy(default_options)

  table_merge(options, opts, true)

  local self = {
    options = options
  }

  return setmetatable(self, _mt)
end


return _M
