local type = type
local table_insert = table.insert
local pairs = pairs


--- merge table src into table dst with override flag
--- indicates whether to override the existing keys.
local function table_merge(dst, src, override)
  local stack = {}
  local node_dst, node_src = dst, src

  while (true) do
    for k, v in pairs(node_src) do
      if (type(v) == "table" and type(node_dst[k]) == "table") then
        table_insert(stack, { node_dst[k], node_src[k] })
      elseif override == true or node_dst[k] == nil then
        node_dst[k] = v
      end
    end
    local stack_n = #stack
    if (stack_n > 0) then
      local t = stack[stack_n]
      node_dst, node_src = t[1], t[2]
      stack[stack_n] = nil
    else
      break
    end
  end

  return dst
end


local function table_deepcopy(t)
  if type(t) ~= "table" then
    return t
  end

  local res = {}
  local mt = getmetatable(t)
  for k, v in pairs(t) do
    k = table_deepcopy(k)
    v = table_deepcopy(v)
    res[k] = v
  end
  setmetatable(res, mt)
  return res
end


return {
  table_merge = table_merge,
  table_deepcopy = table_deepcopy,
}
