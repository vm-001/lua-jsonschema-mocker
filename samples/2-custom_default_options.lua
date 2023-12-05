local jsonschema_mocker = require "jsonschema-mocker"
local pretty = require "pl.pretty"

local options = {
  integer = {
    minimum = 10,
    maximum = 20,
  },
  string = {
    min_length = 10,
    max_length = 10,
    charset = "@",
    formatters = {
      uuid = function()
        return "00000000-0000-0000-0000-000000000000"
      end
    },
  },
  array = {
    min_items = 3,
    max_items = 3,
  },
}

local mocker = jsonschema_mocker.new(options)

local schema = {
  type = "object",
  properties = {
    age = { type = "integer", minimum = 0 },
    name = { type = "string" },
    activated = { type = "boolean" },
    hobbies = { type = "array", items = { type = "string" } },
    rank = { enum = { "A", "B", "C", "D" } },
  }
}

local res = mocker:mock(schema)
pretty.dump(res)
