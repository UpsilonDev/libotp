-- Yubico OTP implementation
-- Part of the libotp library for ComputerCraft
-- https://github.com/UpsilonDev/libotp

local modhex = require("libotp.yubiotp.modhex")
local lookup = require("libotp.utils.lookup")
local rand = require("libotp.utils.rand")

local yubiotp = {}

local function splitResponse(r)
  local resp = {}
  for k,v in r:gmatch("(%w+)=([%w%p_]+)") do
    resp[k] = v
  end
  return resp
end
local function yubicloud(id,otp,nonce)
  -- Construct HTTP request and do the mario
  local endpoint = lookup.yubicloud
  local err = lookup.err.yubicloud

  local fmt = "https://%s/wsapi/2.0/verify?otp=%s&nonce=%s&id=%s&timestamp=1"
  local h = http.get(string.format(
    fmt,endpoint[math.random(#endpoint)],
    otp,nonce,id
  ))
  if not h then return false,-1 end
  if not (h.getResponseCode() == 200) then h.close() return false,-2 end
  local d = splitResponse(h.readAll())
  h.close()

  -- Basic request validation
  if not d.otp == otp then
    return false,-6,d
  elseif not d.nonce == nonce then
    return false,-7,d
  end

  -- Check YubiCloud status response
  if d.status == "OK" then
    return true,0,d
  else
    return false,(err[d.status] or -20),d
  end

  return false,-9 -- This should never happen
end
function yubiotp.validate(otp,id)
  local cs,cc = yubiotp.isValidOTP(otp)
  if not cs then return false,cc end

  local nonce = rand.getRandomString(16)
  local res,ec,rep = yubicloud(id,otp,nonce)

  if res then
    return true,0,rep
  else
    return false,ec,rep
  end
end
function yubiotp.isValidOTP(s)
  -- TODO: Implement CRC checksum validation
  if not (#s == 44) then
    return false,-3
  elseif not modhex.isModhex(s) then
    return false,-4
  end
  return true
end
function yubiotp.getYubikeyID(t)
  return modhex.decodeDecimal(t:sub(1,12))
end

return yubiotp