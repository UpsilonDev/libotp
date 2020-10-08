-- Main library, serves as a link to other files via require()
-- Part of the libotp library for ComputerCraft
-- https://github.com/UpsilonDev/libotp

local libotp = {
  ["err"] = {},
}

libotp.VERSION = "1.0.0"

-- Core functions
libotp.yubiotp = require("libotp.yubiotp.main")
libotp.hotp = require("libotp.oath.hotp")
libotp.totp = require("libotp.oath.totp")

-- Helper functions
libotp.rand = require("libotp.utils.rand")
libotp.modhex = require("libotp.yubiotp.modhex")

-- Selected lookup tables
local lookup = require("libotp.utils.lookup")
libotp.err.yubiotp = lookup.err.yubiotp

return libotp
