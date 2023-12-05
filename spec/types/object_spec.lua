local jsonschema_mocker = require "jsonschema-mocker"

local mocker = jsonschema_mocker.new()


describe("object", function()
  it("type assertion", function()
    local res = mocker:mock({ type = "object" })
    assert.equal("table", type(res))
  end)


  describe("customizes options.object", function()
    it("object.only_required_properties", function()
      --local customize_mocker = jsonschema_mocker.new({
      --  object = {
      --    only_required_properties = true
      --  }
      --})
    end)
  end)
end)
