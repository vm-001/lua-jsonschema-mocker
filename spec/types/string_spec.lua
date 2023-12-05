local jsonschema_mocker = require "jsonschema-mocker"


local mocker = jsonschema_mocker.new({
  string = {
    min_length = 10,
    max_length = 10,
    charset = "@",
    formatters = {
      ["uuid"] = function()
        return "00000000-0000-0000-0000-000000000000"
      end
    },
  }
})


describe("string", function()
  it("type assertion", function()
    local res = mocker:mock({ type = "string" })
    assert.equal("string", type(res))
  end)

  describe("length", function()
    it("result length should between minLength and maxLength", function()
      local schema = { type = "string", minLength = 2, maxLength = 3 }
      local res = mocker:mock(schema)
      assert.is_true(#res >= 2 and #res <= 3)
    end)
  end)

  describe("format", function()
    it("result should match to format", function()
      assert.truthy(string.match(mocker:mock({ type = "string", format = "date" }), "^%d+%-%d%d%-%d%d$"))
      assert.truthy(string.match(mocker:mock({ type = "string", format = "date-time" }), "^%d+%-%d%d%-%d%dT%d%d:%d%d:%d%dZ$"))
    end)
  end)

  describe("customizes options.string", function()
    it("string.min_length and string.max_length", function()
      local res = mocker:mock({ type = "string" })
      assert.is_true(#res == 10)
    end)

    it("string.charset", function()
      local res = mocker:mock({ type = "string" })
      assert.truthy(string.match(res, "^@+$"))
    end)

    it("string.formatters", function()
      local res = mocker:mock({ type = "string", format = "uuid" })
      assert.truthy(string.match(res, "%x%x%x%x%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%-%x%x%x%x%x%x%x%x%x%x%x%x"))
    end)
  end)

end)
