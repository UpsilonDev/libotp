-- Yubico ModHex implementation in pure Lua
-- Part of the libotp library for ComputerCraft
-- https://github.com/UpsilonDev/libotp

local mod,hex = "cbdefghijklnrtuv","0123456789abcdef"
local modhex = {}

function modhex.isModhex(s,st)
  -- Unless explictly disabled, "strict mode" is in effect at all times.
  -- This prevents a catastrophic failure when users assume that the function
  -- always validate the modhex alphabet, but in reality it's only checking
  -- to see if the input length is even or not. Only "extended strict mode"
  -- is not enabled by default, since most of the time it's safe to assume
  -- that most users will pass QWERTY-formatted strings.
  if not st then
    local ctr = 0
    for i in s:gmatch("[cbdefghijklnrtuv]") do
      ctr = ctr+1
    end
    if not (ctr == #s) then return false end
  end

  if not (#s % 2 == 0) then return false end
  return true
end
function modhex.encode(s)
  return (s:gsub(".",function(i)
    local c = hex:find(i)
    return mod:sub(c,c)
  end))
end
function modhex.decode(s)
  return (s:gsub(".",function(i)
    local c = mod:find(i)
    return hex:sub(c,c)
  end))
end
function modhex.encodeString(s)
  return modhex.encode(s:gsub(".",function(i)
    return string.format("%x",string.byte(i))
  end))
end
function modhex.decodeString(s)
  return (modhex.decode(s):gsub("..",function(i)
    return string.char(tonumber(i,16))
  end))
end
function modhex.encodeDecimal(s)
  return modhex.encode(string.format("%x",tonumber(s)))
end
function modhex.decodeDecimal(s)
  return tonumber(modhex.decode(s),16)
end

return modhex
