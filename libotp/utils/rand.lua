-- Random functions (literally)
-- Part of the libotp library for ComputerCraft
-- https://github.com/UpsilonDev/libotp

local base = require("libotp.utils.base")
local csprng = require("libotp.crypto.csprng")

local rand = {}

local function randStr(l,r)
  -- Who needs a iterator buffer when you can use rep and gsub
  csprng.seed_from_mt(os.epoch("utc"))
  csprng.generate_isaac()
  return (tostring(l):rep(l):gsub(".",function(i)
    return string.char(csprng.randomRange(unpack(r[csprng.randomRange(1,#r)])))
  end))
end

function rand.getRandomString(l)
  local r = {{48,57},{65,90},{97,122}} -- Alphanumeric range
  return randStr(l,r)
end

-- Convenience wrapper for randomRange
function rand.randomRange(min,max)
  csprng.seed_from_mt(os.epoch("utc"))
  csprng.generate_isaac()
  return csprng.randomRange(min,max)
end

-- Generate random OATH TOTP/HOTP seed
function rand.getRandomSeed()
  local r = {{33,47},{48,57},{58,64},{65,90},{91,96},{97,122}}
  return base.to_base32(randStr(10,r))
end

return rand
