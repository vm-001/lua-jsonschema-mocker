local DEFAULT_OPTIONS = {
  integer = {
    minimum = 0,
    maximum = 999,
  },
  number = {
    minimum = 0,
    maximum = 999,
  },
  string = {
    min_length = 1,
    max_length = 20,
    charset = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890",
    formatters = nil,
  },
  array = {
    min_items = 0,
    max_items = 0,
  },
  object = {
    only_required_properties = false,
  },
  customize = function(res, schema)
    return res
  end
}

return DEFAULT_OPTIONS
