-- Time-based One-time Password (RFC 6238) implementation
-- Part of the libotp library for ComputerCraft
-- https://github.com/UpsilonDev/libotp

local base = require("libotp.utils.base")
local sha1 = require("libotp.crypto.sha1")
local oath = require("libotp.oath.common")

local totp = {}

-- note: this doesn't work, yet
function totp.generate(s,o,l)
  local c = math.floor((os.epoch("utc")/1000)/(o or 30))
  local otp = oath.truncate(
    sha1.hmac(
      oath.counter(c),
      base.to_base32(s)
    )
  )
  return oath.process(otp,(l or 6))
end

return totp