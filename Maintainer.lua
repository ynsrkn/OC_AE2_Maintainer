-- maintainer.lua: reads config.lua and auto‐crafts below thresholds

local component = require("component")
local ME        = component.me_controller or component.me_interface

-- load your settings
local cfg = require("config")
local sleepInterval = cfg.sleepInterval
local items         = cfg.items

-- main loop
while true do
  for label, params in pairs(items) do
    local threshold, batchSize = params[1], params[2]
    if not threshold then
      goto continue
    end
  

    -- ask AE2 how many are in the network
    local inNet   = ME.getItemsInNetwork({ label = label })
    local current = (inNet[1] and inNet[1].size) or 0

    -- if below threshold, fire off a craft
    if current < threshold then
      local craftables = ME.getCraftables({ label = label })
      if craftables[1] then
        print( ("Attempting to Craft %s x%d (stock=%d < threshold=%d)")
               :format(label, batchSize, current, threshold) )
        craftables[1].request(batchSize)
      else
        print( ("Cannot craft %s: no pattern found"):format(label) )
      end
    end
  end

  os.sleep(sleepInterval)
end