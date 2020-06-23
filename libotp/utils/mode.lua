-- Hexadecimal modes, similar to chmod octals permissions
-- Part of the libotp library for ComputerCraft
-- https://github.com/UpsilonDev/libotp

local lookup = require("libotp.utils.lookup")
local mode = {}

-- Decodes hexadecimal and returns a boolean table
-- TODO: Pad zeros instead of appending binary straight to the buffer
function mode.getMode(s,l)
  local tbl = {}
  if s:len() == l then
    for i in s:lower():gmatch("[0-9a-f]") do
      for b in lookup.mode.bin[i]:gmatch("[10]") do
        if b == "1" then table.insert(tbl,true) else table.insert(tbl,false) end
      end
    end
    return tbl
  else
    return false
  end
end

return mode
