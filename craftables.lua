-- craftables.lua

local component = require("component")
local fs        = require("filesystem")

-------------------------------------------------------------------------------
-- 1) Locate ME component
-------------------------------------------------------------------------------
local ctrlAddr = component.list("me_controller")()
local intfAddr = component.list("me_interface")()
local addr     = ctrlAddr or intfAddr
               or error("No AE2 ME controller or interface found")
local ME = component.proxy(addr)

-- Pick the right method
local craftsFetcher
if     ME.getCraftables     then craftsFetcher = ME.getCraftables
elseif ME.getAvailableItems then craftsFetcher = ME.getAvailableItems
else   error("ME proxy has no getCraftables/getAvailableItems") end

-------------------------------------------------------------------------------
-- 2) Config-generation settings
-------------------------------------------------------------------------------
local cfg_path         = "./config.lua"
local defaultThreshold = 512
local defaultBatchSize = 64

local function generateConfig()
  local crafts = craftsFetcher()
  local seen   = {}
  local out    = assert(io.open(cfg_path, "w"))

  -- Boilerplate header
  out:write([[
-- config.lua  (auto-generated)
-- Adjust sleepInterval, thresholds, batchSizes below.

return {
  sleepInterval = 60,
  items = {
]])

  -- Dump one entry per unique label
  for _, pattern in ipairs(crafts) do
    local label = pattern.getItemStack().label
    if not seen[label] then
      seen[label] = true
      out:write(string.format(
        "    [\"%s\"] = {%d, %d},\n",
        label:gsub('"','\\"'),
        defaultThreshold,
        defaultBatchSize
      ))
    end
  end

  -- Footer
  out:write([[
  },
}
]])
  out:close()

  -- Count how many we wrote
  local count = 0
  for _ in pairs(seen) do count = count + 1 end
  print(("✔ Wrote %d items to %s"):format(count, cfg_path))
end

-- Print available crafts
local crafts = craftsFetcher()
print("Available crafts:")
for _, pattern in ipairs(crafts) do
  local label = pattern.getItemStack().label
  print("- " .. label)
end
print(("::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::"))

-- 3) Prompt the user & maybe generate
io.write("Generate and REFRESH config.lua? [y/N] ")
local ans = io.read():lower():sub(1,1)
if ans == "y" then
  generateConfig()
end