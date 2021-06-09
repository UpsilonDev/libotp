-- Yubico OTP implementation
-- Part of the libotp library for ComputerCraft
-- https://github.com/UpsilonDev/libotp

local mode = require("libotp.utils.mode")
local lookup = require("libotp.utils.lookup")
local modhex = require("libotp.yubiotp.modhex")
local request = require("libotp.yubiotp.request")

local yubiotp = {}

function yubiotp.validate(otp, id, key, opt)
  -- Hexamode handling
  local o = {}
  if opt then
    o = mode.getMode(opt, 2)
    if not o then return false, -12 end
  else
    o = lookup.mode.yubiotp
  end

  -- Input validation
  if not otp then return false, -13 end
  if not id then return false, -13 end
  if not o[4] then key = nil end
  --if o[1] then
  --  local cs,cc = yubiotp.isValidOTP(otp,o[2],o[5])
  --  if not cs then return false,cc end
  --end

  -- Do the mario
  local r, resp, resq, vrs = request.send(otp, id, key, o[6], o[3])

  if r then
    local err = lookup.err.yubicloud

    if resp.status == "OK" then
      -- Basic request validation
      if not (resp.otp == resq.otp) then
        return false, -8, resp
      elseif not (resp.nonce == resq.nonce) then
        return false, -9, resp
      end

      -- Signature validation
      if o[3] and key then
        if not vrs then return false, -11, resp end
      end

      return true, 0, resp
    else
      return false, err[resp.status] or -30, resp
    end
  else
    -- Pass on the error
    return false, resp, resq
  end

  return false, -10 -- This should never happen
end
function yubiotp.isValidOTP(s)
  -- TODO: Implement CRC checksum validation
  if not (#s == 44) then
    return false, -3
  elseif not modhex.isModhex(s) then
    return false, -4
  end
  return true
end
function yubiotp.getYubikeyID(t)
  local s, r = pcall(function()
    return modhex.decodeDecimal(t:sub(1, 12))
  end)
  if s then return r else return 0 end
end

return yubiotp
