-- list_craftables.lua

local component = require("component")
local ME = component.me_interface or component.me_controller
if not ME then
    error("Missing AE2 ME interface or controller component!")
end


local crafts = ME.getCraftables()

local function writeConfig(crafts)
    local file, err = io.open("config.lua", "w")
    if not file then
        error("Failed to open config.lua: " .. err)
    end
    file:write("return {\n")
    local seen = {}
    for _, pattern in ipairs(crafts) do
        local stack = pattern.getItemStack()
        local label = stack.label
        if not seen[label] then
            seen[label] = true
            file:write(string.format("    [\"%s\"] = { threshold = nil, batchSize = nil },\n", label))
        end
    end
    file:write("}\n")
    file:close()
    print("config.lua created/updated.")
end

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

print("\nWould you like to create/update config.lua with these craft entries? (y/n)")
local answer = io.read()
if answer:lower() == "y" then
    writeConfig(crafts)
else
    print("Skipping config file generation.")
end