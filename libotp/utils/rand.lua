-- Random functions (literally)
-- Part of the libotp library for ComputerCraft
-- https://github.com/UpsilonDev/libotp

local csprng = require("libotp.crypto.csprng")

local rand = {}

function rand.getRandomString(l)
  -- Who needs a iterator buffer when you can use rep and gsub
  csprng.seed_from_mt(os.epoch("utc"))
  csprng.generate_isaac()
  return (tostring(l):rep(l):gsub(".",function(i)
    local r = {{48,57},{65,90},{97,122}} -- Alphanumeric range
    return string.char(csprng.randomRange(unpack(r[csprng.randomRange(1,3)])))
  end))
end

-- Convenience wrapper for randomRange
function rand.randomRange(min,max)
  csprng.seed_from_mt(os.epoch("utc"))
  csprng.generate_isaac()
  return csprng.randomRange(min,max)
end

return rand
