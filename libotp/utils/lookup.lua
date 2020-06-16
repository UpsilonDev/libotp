-- Lookup tables for errors and other data
-- Part of the libotp library for ComputerCraft
-- https://github.com/UpsilonDev/libotp

local lookup = {
  ["err"] = {},
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
  ["BAD_OTP"] = -10,
  ["REPLAYED_OTP"] = -11,
  ["BAD_SIGNATURE"] = -12,
  ["MISSING_PARAMETER"] = -13,
  ["NO_SUCH_CLIENT"] = -14,
  ["OPERATION_NOT_ALLOWED"] = -15,
  ["BACKEND_ERROR"] = -16,
  ["NOT_ENOUGH_ANSWERS"] = -17,
  ["REPLAYED_REQUEST"] = -18
}

-- libotp error messages
lookup.err.libotp = {
    [0] = "OK",
   [-1] = "HTTP error (generic)",
   [-2] = "Non-200 HTTP status",
   [-3] = "Invalid OTP: length",
   [-4] = "Invalid OTP: modhex",
   [-5] = "Invalid OTP: CRC",
   [-6] = "OTP mismatch from response",
   [-7] = "Nonce mismatch from response",
   [-8] = "Signature mismatch",
   [-9] = "Fatal exception",
  [-10] = "YubiCloud: Bad OTP",
  [-11] = "YubiCloud: Replayed OTP",
  [-12] = "YubiCloud: Bad signature",
  [-13] = "YubiCloud: Missing parameter",
  [-14] = "YubiCloud: No such client",
  [-15] = "YubiCloud: Operation not allowed",
  [-16] = "YubiCloud: Backend error",
  [-17] = "YubiCloud: Not enough answers",
  [-18] = "YubiCloud: Replayed request",
  [-20] = "Unknown YubiCloud error"
}

return lookup
