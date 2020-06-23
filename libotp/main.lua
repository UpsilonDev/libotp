-- Main library, serves as a link to other files via require()
-- Part of the libotp library for ComputerCraft
-- https://github.com/UpsilonDev/libotp

local libotp = {
  ["lu"] = {}
}

-- Core functions
libotp.yubiotp = require("libotp.yubiotp.main")

-- Helper functions
libotp.modhex = require("libotp.yubiotp.modhex")
libotp.rand = require("libotp.utils.rand")

-- Selected lookup tables 
local lookup = require("libotp.utils.lookup")
libotp.lu.err = lookup.err.yubiotp
libotp.lu.fbits = lookup.mode.fbits

return libotp
