-- Time-based One-time Password (RFC 6238) implementation
-- Part of the libotp library for ComputerCraft
-- https://github.com/UpsilonDev/libotp

local oath = require("libotp.oath.common")
local gen = oath.generate

local totp = {}

function totp.generate(s,d,l)
  local e = math.floor((os.epoch("utc")/1000)/(d or 30))
  return gen(e,s,l)
end
function totp.check(otp,s,d,l,o)
  local p,of = {},(o or 1)
  local e = math.floor((os.epoch("utc")/1000)/(d or 30))
  if of >= 1 then
    local st = e - of
    p[gen(st,s,l)] = true
    for i=1,of+1 do
      p[gen(st+i,s,l)] = true
    end
    if p[otp] then return true end
  else
    if otp == gen(e,s,l) then return true end
  end
  return false
end

return totp