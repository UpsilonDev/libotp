-- YubiCloud signature generation and validation
-- Part of the libotp library for ComputerCraft
-- https://github.com/UpsilonDev/libotp

local base = require("libotp.utils.base")
local sha1 = require("libotp.crypto.sha1")

local signature = {}

function signature.sign(data,key)
  return base.to_base64(base.from_hex(
    sha1.hmac(data,base.from_base64(key)):toHex()
  ))
end
function signature.validate(data,rsig,key)
  if not (signature.sign(data,key) == rsig) then
    return false
  end
  return true
end

return signature