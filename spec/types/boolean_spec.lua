local jsonschema_mocker = require "jsonschema-mocker"

local mocker = jsonschema_mocker.new()

local schema = {
  type = "boolean"
}

describe("boolean", function()
  it("type assertion", function()
    local res = mocker:mock(schema)
    assert.equal("boolean", type(res))
  end)

  it("mock randomly", function()
    local counts = {}
    for i = 1, 1000 do
      local res = mocker:mock(schema)
      counts[res] = (counts[res] or 0) + 1
    end
    assert.is_true(counts[true] > 0)
    assert.is_true(counts[false] > 0)
  end)
end)
