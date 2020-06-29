-- Lookup tables for errors and other data
-- Part of the libotp library for ComputerCraft
-- https://github.com/UpsilonDev/libotp

local lookup = {
  ["err"] = {},
  ["mode"] = {},
  ["headers"] = {},
  ["yubicloud"] = {}
}

-- YubiCloud endpoints
lookup.yubicloud = {
  "api.yubico.com",
  "api2.yubico.com",
  "api3.yubico.com",
  "api4.yubico.com",
  "api5.yubico.com"
}

-- YubiCloud error messages
lookup.err.yubicloud = {
  ["BAD_OTP"] = -20,
  ["REPLAYED_OTP"] = -21,
  ["BAD_SIGNATURE"] = -22,
  ["MISSING_PARAMETER"] = -23,
  ["NO_SUCH_CLIENT"] = -24,
  ["OPERATION_NOT_ALLOWED"] = -25,
  ["BACKEND_ERROR"] = -26,
  ["NOT_ENOUGH_ANSWERS"] = -27,
  ["REPLAYED_REQUEST"] = -28
}

-- YubiOTP error messages
lookup.err.yubiotp = {
    [0] = "OK",
   [-1] = "No response",
   [-2] = "Non-200 HTTP status",
   [-3] = "URL not in whitelist",
   [-4] = "Multiple responses missing",
   [-5] = "Invalid OTP length",
   [-6] = "Invalid OTP modhex",
   [-7] = "OTP CRC mismatch",
   [-8] = "OTP mismatch from response",
   [-9] = "Nonce mismatch from response",
  [-10] = "Fatal exception",
  [-11] = "Response signature mismatch",
  [-12] = "Invalid hexamode given",
  [-20] = "YubiCloud: Bad OTP",
  [-21] = "YubiCloud: Replayed OTP",
  [-22] = "YubiCloud: Bad signature",
  [-23] = "YubiCloud: Missing parameter",
  [-24] = "YubiCloud: No such client",
  [-25] = "YubiCloud: Operation not allowed",
  [-26] = "YubiCloud: Backend error",
  [-27] = "YubiCloud: Not enough answers",
  [-28] = "YubiCloud: Replayed request",
  [-30] = "Unknown YubiCloud error"
}

-- Default hexamode bit for YubiOTP
lookup.mode.yubiotp = {
  false, -- Strict mode
  false, -- Enhanced strict mode
  false, -- Check YubiCloud signature
  false, -- Sign validation request
  false, -- Check CRC in OTP
  false, -- Parallel HTTP requests
  false, -- Reserved
  false  -- Reserved
}

-- HTTP headers for YubiCloud requests
lookup.headers = {
  ["User-Agent"] = "libotp/alpha (+https://git.io/JJem7)",
  ["X-Clacks-Overhead"] = "GNU Terry Pratchett"
}

return lookup
