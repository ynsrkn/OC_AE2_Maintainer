local internet = require("internet")
local fs = require("filesystem")

local installDir = "/home"

if not fs.exists(installDir) then
  assert(fs.makeDirectory(installDir), "Failed to create "..installDir)
end

-- base URL of your raw files on GitHub
local repoBase = "https://raw.githubusercontent.com/chrisdk1234/OC_AE2_Maintainer/main/"

-- the files to fetch
local files = {
  "config.lua",
  "maintainer.lua",
  "ae2crafter.lua",
}

for _, name in ipairs(files) do
  local url = repoBase .. name
  io.write("Downloading ", name, " ... ")
  local handle, err = internet.request(url)
  if not handle then
    print("FAILED: "..tostring(err))
  else
    local data = handle:read("*a")
    handle:close()

    local path = installDir .. "/" .. name
    local f, ferr = io.open(path, "wb")
    assert(f, "Could not open "..path..": "..tostring(ferr))
    f:write(data)
    f:close()

    print("OK")
  end
end

print("\nAll done! Your files are in "..installDir)
print("Run:\n  cd "..installDir.."\n  lua maintainer.lua")