local jsonschema_mocker = require "jsonschema-mocker"

local mocker = jsonschema_mocker.new()

local schema = {
  type = "null"
}

describe("null", function()
  it("type assertion", function()
    local res = mocker:mock(schema)
    assert.equal("nil", type(res))
  end)
end)
