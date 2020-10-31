-- Ghosts!
-- Part of the libotp library for ComputerCraft
-- https://github.com/UpsilonDev/libotp

local ghosts = {}

local treats = {"KitKat", "Snickers", "Milky Way", "M&M's", "Twix", "Skittles", "Butterfingers", "Hersheys", "Reese's"}

local function isHalloween()
  if os.date("%m%d") == "1031" then
    return true
  end
  return false
end

function ghosts.candy()
  return treats[math.random(#treats)]
end

function ghosts.isBestGirl(girl)
  if girl:lower() == "megumin" then
    return true
  end
  return false
end

ghosts.isHalloween = isHalloween
ghosts.doGhostsExist = isHalloween
ghosts.areGhostsReal = isHalloween

return ghosts