local package_name = "jsonschema-mocker"
local package_version = "dev"
local rockspec_revision = "1"
local github_account_name = "vm-001"
local github_repo_name = "lua-jsonschema-mocker"
local git_checkout = package_version == "dev" and "master" or ("version_"..package_version)

package = package_name
version = package_version .. "-" .. rockspec_revision

source = {
  url = "git+https://github.com/"..github_account_name.."/"..github_repo_name..".git",
  branch = git_checkout
}

description = {
  summary = "jsonschema module for Lua 5.x",
  detailed = [[
  ]],
  license = "MIT",
  homepage = "https://github.com/"..github_account_name.."/"..github_repo_name,
}

dependencies = {
  "lua >= 5.0, < 5.5"
}

build = {
  type = "builtin",
  modules = {
    ["jsonschema-mocker"] = "src/mocker.lua",
    ["jsonschema-mocker.utils"] = "src/utils.lua",
    ["jsonschema-mocker.options"] = "src/options.lua",
    ["jsonschema-mocker.types.array"] = "src/types/array.lua",
    ["jsonschema-mocker.types.boolean"] = "src/types/boolean.lua",
    ["jsonschema-mocker.types.integer"] = "src/types/integer.lua",
    ["jsonschema-mocker.types.null"] = "src/types/null.lua",
    ["jsonschema-mocker.types.number"] = "src/types/number.lua",
    ["jsonschema-mocker.types.object"] = "src/types/object.lua",
    ["jsonschema-mocker.types.string"] = "src/types/string.lua",
  },
  --copy_directories = { "docs" },
}
