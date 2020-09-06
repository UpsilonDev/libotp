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
  local r,i = {0,0,0,0,0,0,0,0},8
  while i > 1 and C > 0 do
    r[i] = C % 0x100
    C = math.floor(C/0x100)
    i = i - 1
  end
  return r
end
function common.process(O,L)
  local fms = "%0"..L.."d"
  return string.format(fms,O % 10^L)
end

return common