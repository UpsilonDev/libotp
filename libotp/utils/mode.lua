-- Hexadecimal modes, similar to chmod octals permissions
-- Part of the libotp library for ComputerCraft
-- https://github.com/UpsilonDev/libotp

local base = require("libotp.utils.base")
local mode = {}

-- Decodes hexadecimal and returns a boolean table
function mode.getMode(s,l)
  local tbl = {}
  if (#s == l) and (#s % 2 == 0) then
    if not s:lower():gmatch("[0-9a-f]") then
      return false
    end
    for b in base.to_bit(base.from_hex(s)):gmatch("%d") do
      if b == "1" then table.insert(tbl,true) else table.insert(tbl,false) end
    end
    return tbl
  else
    return false
  end
end

return mode
