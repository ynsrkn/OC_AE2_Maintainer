-- list_craftables.lua

local component = require("component")
local ME = component.me_controller or error("ME interface not found")

local crafts = ME.getCraftables()

print("---- Available Craftables ----")
local seen = {}
for _, pattern in ipairs(crafts) do
  local stack = pattern.getItemStack()
  local label = stack.label
  if not seen[label] then
    seen[label] = true
    print(label, "(per craft:", stack.size, ")")
  end
end
print("---- end ----")