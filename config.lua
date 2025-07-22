-- config.lua
-- Edit this to taste

return {
  -- how many seconds between full scans
  sleepInterval = 60,

  -- items to maintain: 
  --   key   = AE2 label
  --   value = { threshold, batchSize }
  items = {
    ["Iron Ingot"]   = { 32, 8 },
    -- add more entries here
  },
}