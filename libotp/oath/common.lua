-- Common functions for HOTP & TOTP
-- Part of the libotp library for ComputerCraft
-- https://github.com/UpsilonDev/libotp

local common = {}

local base = require("libotp.utils.base")
local sha1 = require("libotp.crypto.sha1")

-- Taken from Anav's SHA libraries
local band = bit32 and bit32.band or bit.band
local bor = bit32 and bit32.bor or bit.bor
local ls = bit32 and bit32.lshift or bit.blshift

local function truncate(HS)
  local O = band(HS[20], 0xf)
  return bor(
    ls(band(HS[O + 1], 0x7f), 24),
    ls(HS[O + 2], 16),
    ls(HS[O + 3], 8),
    HS[O + 4]
  )
end
local function counter(C)
  local r, i = {0, 0, 0, 0, 0, 0, 0, 0}, 8
  while i > 1 and C > 0 do
    r[i] = C % 0x100
    C = math.floor(C / 0x100)
    i = i - 1
  end
  return r
end
function common.generate(c, s, l)
  local le = l or 6
  local otp = truncate(
    sha1.hmac(
      counter(c),
      base.from_base32(s)
    )
  )
  local fms = "%0" .. le .. "d"
  return string.format(fms, otp % 10 ^ le)
end

return common