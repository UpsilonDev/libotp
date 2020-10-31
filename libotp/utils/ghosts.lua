-- Ghosts!
-- Part of the libotp library for ComputerCraft
-- https://github.com/UpsilonDev/libotp

local ghosts = {}

function ghosts.isHalloween()
  if os.date("%m%d") == "1031" then
    return true
  end
  return false
end

return ghosts