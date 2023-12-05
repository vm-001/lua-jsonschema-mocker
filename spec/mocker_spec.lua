local jsonschema_mocker = require "jsonschema-mocker"
local mocker = jsonschema_mocker.new()
local cjson = require "cjson"

local function structure_like(source, target)
  for k, v in pairs(source) do
    local source_type = type(v)
    local target_value = target[k]
    if source_type ~= type(target_value) then
      return false, string.format("%s(%s) and %s(%s) are not the same type", v, source_type, target_value, type(target_value))
    end
    if source_type == "table" then
      local ok, err = structure_like(v, target_value)
      if not ok then
        return false, err
      end
    end
  end
  return true, nil
end

describe("jsonschema-mocker", function()

  it("enum", function()
    local enums = { "red", "amber", "green", cjson.null, 42 }
    local res = mocker:mock({ enum = enums })
    local matched = false
    for _, enum in ipairs(enums) do
      if res == enum then
        matched = true
        break
      end
    end
    assert.is_true(matched)
  end)

  it("invalid schema type", function()
    local res = mocker:mock({ type = "invalid" })
    assert.equal("Unknown Type: invalid", res)
    local res = mocker:mock({ type = 1 })
    assert.equal("Unknown Type: 1", res)
    local res = mocker:mock({ type = false })
    assert.equal("Unknown Type: false", res)
    local res = mocker:mock({ type = "object", properties = { invalid = { type = "invalid" } } })
    assert.same({ invalid = "Unknown Type: invalid" }, res)
  end)

  it("allOf", function()
    local schema = {
      allOf = {
        {
          type = "object",
          properties = { key_a = { type = "string" } }
        },
        {
          type = "object",
          properties = { key_b = { type = "string" } }
        },
      }
    }

    local res = mocker:mock(schema)
    structure_like({
      key_a = "",
      key_b = "",
    }, res)
  end)

end)
