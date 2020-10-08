-- Hexadecimal modes, similar to chmod octals permissions
-- Part of the libotp library for ComputerCraft
-- https://github.com/UpsilonDev/libotp

local base = require("libotp.utils.base")
local mode = {}

local function checkAlphabet(str, pat)
  local ctr = 0
  for _ in str:gmatch(pat) do
    ctr = ctr + 1
  end
  if not (ctr == #str) then return false, ctr end
  return true, ctr
end

-- Decodes hexadecimal and returns a boolean table
function mode.getMode(s, l)
  -- Input validation
  if not (type(s) == "string") then return false end
  if not (#s == l) then return false end
  if not (#s % 2 == 0) then return false end
  if not checkAlphabet(s:lower(), "[0-9a-f]") then return false end

  -- Conversion
  local tbl = {}
  for b in base.to_bit(base.from_hex(s)):gmatch("%d") do
    if b == "1" then table.insert(tbl, true) else table.insert(tbl, false) end
  end
  return tbl
end

return mode
