local jsonschema_mocker = require "jsonschema-mocker"

local mocker = jsonschema_mocker.new()

describe("number", function()
  it("type assertion", function()
    local res = mocker:mock({ type = "number" })
    assert.equal("number", type(res))
    print(res)
  end)
end)
