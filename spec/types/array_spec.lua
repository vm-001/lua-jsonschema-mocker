local jsonschema_mocker = require "jsonschema-mocker"


local mocker = jsonschema_mocker.new()


describe("array", function()
  it("type assertion", function()
    local res = mocker:mock({ type = "array" })
    assert.equal("table", type(res))
  end)

  describe("items", function()
    it("result element type need to be of the same", function()
      for _, t in ipairs({ "boolean", "integer", "number", "string" }) do
        local value = mocker:mock({ type = "array", items = { type = t }, minItems = 5, maxItems = 10 })
        assert.is_true(type(value) == "table")
        assert.is_true(#value >= 5 and #value <= 10)
        for _, v in ipairs(value) do
          if t == "integer" then
            t = "number"
          end
          assert.equal(t, type(v))
        end
      end
    end)
  end)

  describe("length", function()
    it("result length should between minItems and maxItems", function()
      local schema = { type = "array", items = { type = "integer" },  minItems = 2, maxItems = 3 }
      local res = mocker:mock(schema)
      assert.is_true(#res >= 2 and #res <= 3)
    end)
  end)

  describe("customizes options.array", function()
    it("array.min_items and array.max_items", function()
      local customize_mocker = jsonschema_mocker.new({
        array = {
          min_items = 5,
          max_items = 5,
        }
      })
      local res = customize_mocker:mock({ type = "array", items = { type = "integer" } })
      assert.is_true(#res == 5)
    end)
  end)
end)
