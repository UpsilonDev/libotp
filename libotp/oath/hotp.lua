-- HMAC-based One-time Password (RFC 4226) implementation
-- Part of the libotp library for ComputerCraft
-- https://github.com/UpsilonDev/libotp

local base = require("libotp.utils.base")
local sha1 = require("libotp.crypto.sha1")
local oath = require("libotp.oath.common")

local hotp = {}

function hotp.generate(c,s)
  local otp = oath.truncate(
    sha1.hmac(
      oath.counter(c),
      base.from_base32(s)
    )
  )
  return otp % 10^6
end

return hotp