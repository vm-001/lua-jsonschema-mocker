local jsonschema_mocker = require "jsonschema-mocker"

describe("options", function()
  describe("options.customize", function()
    it("customize result to return a hard-coded value", function()
      local customize_mocker = jsonschema_mocker.new({
        customize = function(res, schema)
          return "foo"
        end
      })
      local res = customize_mocker:mock({ type = "string" })
      assert.equal("foo", res)
      local res = customize_mocker:mock({ type = "integer" })
      assert.equal("foo", res)
    end)

    it("customize result to return provided example if existing", function()
      local customize_mocker = jsonschema_mocker.new({
        customize = function(res, schema)
          if schema.example then
            return schema.example
          end
          return res
        end
      })
      local res = customize_mocker:mock({
        type = "object",
        properties = {
          id = { type = "integer" },
          name = { type = "string", example = "name" },
        }
      })
      assert.equal("number", type(res.id))
      assert.equal("name", res.name)
    end)
  end)
end)
