local jsonschema_mocker = require "jsonschema-mocker"

local mocker = jsonschema_mocker.new()

describe("integer", function()
  it("type assertion", function()
    local res = mocker:mock({ type = "integer" })
    assert.equal("number", type(res))
  end)

  describe("range", function()
    it("result should between minimum and maximum", function()
      local schema = { type = "integer", minimum = 10, maximum = 20 }
      for i = 0, 100 do
        local res = mocker:mock(schema)
        assert.is_true(res >= 10 and res <= 20)
      end
    end)

    it("result should between exclusiveMinimum and exclusiveMaximum", function()
      local schema = { type = "integer", exclusiveMinimum = 10, exclusiveMaximum = 20 }
      for i = 0, 100 do
        local res = mocker:mock(schema)
        assert.is_true(res > 10 and res < 20)
      end
    end)

    it("result should between minimum and exclusiveMaximum", function()
      local schema = { type = "integer", minimum = 10, exclusiveMaximum = 20 }
      for i = 0, 100 do
        local res = mocker:mock(schema)
        assert.is_true(res >= 10 and res < 20)
      end
    end)

    it("result should between minimum(exclusiveMinimum=true) and maximum(exclusiveMaximum=true)", function()
      local schema = { type = "integer", minimum = 10, exclusiveMinimum = true, maximum = 20, exclusiveMaximum = true }
      for i = 0, 100 do
        local res = mocker:mock(schema)
        assert.is_true(res > 10 and res < 20)
      end
    end)
  end)
end)
