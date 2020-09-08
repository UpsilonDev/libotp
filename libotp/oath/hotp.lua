-- HMAC-based One-time Password (RFC 4226) implementation
-- Part of the libotp library for ComputerCraft
-- https://github.com/UpsilonDev/libotp

local oath = require("libotp.oath.common")

local hotp = {}

function hotp.generate(c,s,l)
  return oath.generate(c,s,l)
end

return hotp