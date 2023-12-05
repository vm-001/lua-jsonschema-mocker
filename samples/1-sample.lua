local jsonschema_mocker = require "jsonschema-mocker"
local pretty = require "pl.pretty"

math.randomseed(os.time())

local mocker = jsonschema_mocker.new()

local res = mocker:mock({
  type = "object",
  properties = {
    age = { type = "integer", minimum = 0 },
    name = { type = "string" },
    activated = { type = "boolean" },
    hobbies = { type = "array", items = { type = "string" }, minItems = 0, maxItems = 5 },
    rank = { enum = { "A", "B", "C", "D" } },
  }
})

pretty.dump(res)
