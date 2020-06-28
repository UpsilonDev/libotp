-- Table utilities
-- Part of the libotp library for ComputerCraft
-- https://github.com/UpsilonDev/libotp

local csprng = require("libotp.crypto.csprng")

local tblutil = {}

-- Fisher-Yates shuffling
function tblutil.shuffle(t)
  csprng.seed_from_mt(os.epoch("utc"))
  csprng.generate_isaac()
  for i = #t,2,-1 do
    local j = csprng.randomRange(i)
    t[i], t[j] = t[j], t[i]
  end
  return t
end
-- Ultra simple table copy
function tblutil.copy(t)
  return {unpack(t)}
end
-- Convenience function for sortable K/V pairs
function tblutil.addToIndex(kvp,i,t)
  for k,v in pairs(kvp) do
    table.insert(i,k)
    t[k] = v
  end
end
return tblutil