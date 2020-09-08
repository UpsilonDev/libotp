-- Time-based One-time Password (RFC 6238) implementation
-- Part of the libotp library for ComputerCraft
-- https://github.com/UpsilonDev/libotp

local oath = require("libotp.oath.common")

local totp = {}

function totp.generate(s,d,l)
  local c = math.floor((os.epoch("utc")/1000)/(d or 30))
  return oath.generate(c,s,l)
end

return totp