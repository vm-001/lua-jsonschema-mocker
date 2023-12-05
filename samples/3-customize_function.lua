local jsonschema_mocker = require "jsonschema-mocker"
local cjson = require "cjson"

local mocker = jsonschema_mocker.new({
  customize = function(res, schema)
    if schema.example then
      -- return the example if existing
      return schema.example
    end
    if schema.type == "array" and type(res) == "table" then
      -- set metatable for json marshal
      setmetatable(res, cjson.array_mt)
      return res
    end
    if schema.type == "null" and res == nil then
      -- replace nil to cjson.null for json marshal
      return cjson.null
    end
    return res
  end
})

local schema = {
  type = "object",
  properties = {
    name = { type = "string", example = "John" },
    hobbies = { type = "array", items = { type = "string" } },
    null = { type = "null" }
  }
}

local res = mocker:mock(schema)
local json = cjson.encode(res)
print(json)
