# lua-jsonschema-mocker

JSON Schema Mocker is a Lua library to generate mock data from a [JSON Schema](https://json-schema.org/specification).

## Supported features

| Category |          Supported                                                    |
|----------|--------------------------------------------------------------|
| boolean  | supported                                                    |
| integer  | `minimum`, `maximum`, `exclusiveMinimum`, `exclusiveMaximum` |
| number   | `minimum`, `maximum`, `exclusiveMinimum`, `exclusiveMaximum` |
| string   | `minLength`, `maxLength`, `format`(`date` and `date-time`)   |
| array    | `minItems`, `maxItems`                                       |
| object   | supported                                                    |
| null     | supported                                                    |
| others   | `enum`, `allOf`, `oneOf`                                      |


## Installation

Install via LuaRocks:

```
luarocks install jsonschema-mocker
```


## Usage

```lua
local jsonschema_mocker = require "jsonschema-mocker"

math.randomseed(os.time())

local mocker = jsonschema_mocker.new()

local res = mocker:mock({
  type = "object",
  properties = {
    age = { type = "integer", minimum = 0 },
    name = { type = "string" },
    activated = { type = "boolean" },
    hobbies = { type = "array", items = { type = "string" }, minItems = 0, maxItems = 5 },
    rank = { enum = { "A", "B", "C", "D" } },
  }
})

--[[ res
{
  activated = false,
  age = 27,
  hobbies = { "v7t8fCape", "OEt7ExyKuUzBentHd", "S6MtSh", "IrowzGG7POFoDBio" },
  name = "DP6CjCN7mlMnAo",
  rank = "C"
}
-- ]]
```

### Advanced usage

```lua
local jsonschema_mocker = require "jsonschema-mocker"
local mocker = jsonschema_mocker.new({
  -- integer mocker options
  integer = {
    minimum = 0,
    maximum = 999,
  },
  
  -- number mocker options
  number = {
    minimum = 0,
    maximum = 999,
  },
  
  -- string mocker options
  string = {
    min_length = 1,
    max_length = 20,
    charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
    formatters = nil,
  },
  
  -- array mocker options
  array = {
    min_items = 0,
    max_items = 0,
  },
  
  -- object mocker optiosn
  object = {
    only_required_properties = false,
  },
  
  -- customize mock result function
  customize = function(res, schema)
    return res
  end
})
```

For more usage samples, refer to the `/samples` directory.

## License

