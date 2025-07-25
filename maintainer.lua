local component = require("component")
require("filesystem")

-- ensure controller or interface is present
local ctrlAddr = component.list("me_controller")()
local intfAddr = component.list("me_interface")()
local addr     = ctrlAddr or intfAddr
               or error("No AE2 ME controller or interface found")
local ME = component.proxy(addr)

-- load your settings
local cfg = require("config")
local sleepInterval = cfg.sleepInterval
local items         = cfg.items
local shuffle       = cfg.shuffle

-- craftParser: takes a item with label in a batch of size batchSize
local function craftParser(labelx, batchSizex)
  local craft = ME.getCraftables({label = labelx})
  if craft[1] then
    print( ("Attempting to Craft %s x%d"):format(labelx, batchSizex) )
    craft[1].request(batchSizex)
  else
    print( ("Cannot craft %s: no pattern found"):format(labelx) )
  end
end


local function shuffleList(list)
  for i = #list, 2, -1 do
    local j = math.random(i)
    list[i], list[j] = list[j], list[i]
  end
end
  
print("Maintainer script started exit with Ctrl+Alt+C")
print("........................................................")
-- main loop
while true do
  if shuffle then
    print("shuffle = true, shuffling items")
    shuffleList(items)
  end

  
  for _, entry in  ipairs(items) do
    local label, threshold, batchSize = entry[1], entry[2], entry[3]
    if not batchSize or batchSize == 0 then
      print(("Skipping %s: no batch size specified"):format(label))
      goto continue
    end
    if not threshold or threshold == 0 then
      print(("no threshold specified for %s, infinite craft"):format(label))
      craftParser(label, batchSize)
      goto continue
    end

    -- ask AE2 how many are in the network
    local inNet   = ME.getItemsInNetwork({ label = label })
    local current = (inNet[1] and inNet[1].size) or 0

    if current > threshold then
      goto continue
    else
      craftParser(label, batchSize)
    end
    os.sleep(0.1)  -- small delay to avoid flooding the network
    ::continue:: -- avoid flooding the network
    
  end

  os.sleep(sleepInterval)
  print(("Slept for %d seconds, checking again..."):format(sleepInterval))
  print ("______________________________________________________")
end