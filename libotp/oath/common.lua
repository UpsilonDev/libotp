-- Common functions for HOTP & TOTP
-- Part of the libotp library for ComputerCraft
-- https://github.com/UpsilonDev/libotp

local common = {}

-- Taken from Anav's SHA libraries
local band = bit32 and bit32.band or bit.band
local bor = bit32 and bit32.bor or bit.bor
local ls = bit32 and bit32.lshift or bit.blshift

function common.truncate(HS)
  local O = band(HS[20],0xf)
  return bor(
    ls(band(HS[O+1],0x7f),24),
    ls(HS[O+2],16),
    ls(HS[O+3],8),
    HS[O+4]
  )
end
function common.counter(C)
  -- Very naive 8-bit counter that somehow works
  local t = {0,0,0,0,0,0,0}
  table.insert(t,C)
  return t
end

return common