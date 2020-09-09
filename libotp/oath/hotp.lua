-- HMAC-based One-time Password (RFC 4226) implementation
-- Part of the libotp library for ComputerCraft
-- https://github.com/UpsilonDev/libotp

local oath = require("libotp.oath.common")
local gen = oath.generate

local hotp = {}

function hotp.generate(c,s,l)
  return gen(c,s,l)
end
function hotp.check(otp,c,s,l,o)
  local p,of = {},(o or 1)
  if of >= 1 then
    local st = c - of
    p[gen(st,s,l)] = true
    for i=1,of+1 do
      p[gen(st+i,s,l)] = true
    end
    if p[otp] then return true end
  else
    if otp == gen(c,s,l) then return true end
  end
  return false
end

return hotp