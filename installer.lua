-- installer.lua
-- Usage: lua installer.lua

local ok, internet = pcall(require, "internet")
if not ok then
  io.stderr:write("Error: OpenComputers Internet library not available.\n")
  return
end

local fs = require("filesystem")
local installDir = "/home/ae2-maintainer"

-- 1) Make sure the target folder exists
if not fs.exists(installDir) then
  if not fs.makeDirectory(installDir) then
    io.stderr:write("Error: could not create ", installDir, "\n")
    return
  end
end

-- 2) Which files to pull
local repoBase = "https://raw.githubusercontent.com/chrisdk1234/OC_AE2_Maintainer/main/"
local files = { "config.lua", "maintainer.lua", "ae2crafter.lua" }

-- 3) Download loop
for _, name in ipairs(files) do
  local url = repoBase .. name
  io.write("Downloading ", name, " ... ")
  local ok, handleOrErr = pcall(internet.request, url)
  if not ok or not handleOrErr then
    print("FAILED")
    io.stderr:write("  → HTTP error: ", tostring(handleOrErr), "\n")
  else
    local data = handleOrErr:read("*a")
    handleOrErr:close()

    local path = installDir .. "/" .. name
    local f, ferr = io.open(path, "wb")
    if not f then
      print("FAILED")
      io.stderr:write("  → File error: ", tostring(ferr), "\n")
    else
      f:write(data)
      f:close()
      print("OK")
    end
  end
end

print("\nAll done! Your scripts are in ", installDir)
print("Run:\n  cd ", installDir, "\n  lua maintainer.lua")
