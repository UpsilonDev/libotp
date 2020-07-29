-- HTTP request handler for YubiCloud
-- Part of the libotp library for ComputerCraft
-- https://github.com/UpsilonDev/libotp

local rand = require("libotp.utils.rand")
local lookup = require("libotp.utils.lookup")
local tblutil = require("libotp.utils.tables")
local base = require("libotp.utils.base")
local sha1 = require("libotp.crypto.sha1")

local request = {}

local function splitResponse(r)
  local resp = {}
  for k,v in r:gmatch("(%w+)=([%w%p_]+)") do
    resp[k] = v
  end
  return resp
end
local function buildParam(pli,tbl)
  local str,cnt,len = "",0,#pli
  for _,k in ipairs(pli) do
    str = str .. string.format("%s=%s",k,tbl[k])
    cnt = cnt + 1
    if not (cnt == len) then
      str = str .. "&"
    end
  end
  return str
end
local function buildURL(ep,pa)
  return string.format("https://%s/wsapi/2.0/verify?%s",ep,pa)
end
local function signRequest(data,key)
  return base.to_base64(base.from_hex(
    sha1.hmac(data,base.from_base64(key)):toHex()
  ))
end
local function validateRequest(data,rsig,key)
  if not (signRequest(data,key) == rsig) then
    return false
  end
  return true
end

function request.send(otp,id,key,par,vrs)
  -- Assemble payload
  local pli,payload = {},{}
  tblutil.addToIndex({
    ["otp"] = otp,
    ["nonce"] = rand.getRandomString(16),
    ["id"] = id,
    ["timestamp"] = "1"
  },pli,payload)
  table.sort(pli)

  -- Sign request if key was given
  if key then
    tblutil.addToIndex({
      ["h"] = signRequest(buildParam(pli,payload),key)
    },pli,payload)
  end

  local d = {}
  if not par then
    -- Send single request
    local h = http.get(
      buildURL(
        lookup.yubicloud[rand.randomRange(#lookup.yubicloud)],
        buildParam(pli,payload)
      ),
      lookup.headers
    )

    if not h then return false,-1 end
    d = splitResponse(h.readAll())
    if not (h.getResponseCode() == 200) then h.close() return false,-2,d end
    h.close()
  else
    -- Send multiple requests
    local url = {}
    local ep = {unpack(lookup.yubicloud)}
    local pa = buildParam(pli,payload)
    for k,v in pairs(tblutil.shuffle(ep)) do
      local u = buildURL(v,pa)
      url[u] = true
      http.request(u,_,lookup.headers)
    end

    local success,failure,trip = {},{},false
    local timer = os.startTimer(5)
    -- Catch requests and wait if loop timeouts
    repeat
      local e = {os.pullEvent()}
      if (e[1] == "http_success") and (url[e[2]]) then
        table.insert(success,{
          ["url"] = e[2],
          ["handle"] = e[3]
        })
      elseif (e[1] == "http_failure") and (url[e[2]]) then
        table.insert(failure,{
          ["url"] = e[2],
          ["error"] = e[3]
        })
      elseif (e[1] == "timer") and (e[2] == timer) then
        trip = true
      end
    until (#success == 5 or trip)

    -- Use first response and discard the rest according to Yubico specs
    -- TODO: Handle (multiple) HTTP errors gracefully and pass them on
    if not (#success >= 1) then return false,-1 end
    d = splitResponse(success[1]["handle"].readAll())
    for _,v in pairs(success) do v["handle"].close() end
  end

  -- Validate response signature
  if vrs and key then
    local p,i,t = tblutil.copy(d),{},{}
    p["h"] = nil
    tblutil.addToIndex(p,i,t)
    table.sort(i)
    return true,d,payload,validateRequest(buildParam(i,t),d["h"],key)
  else
    return true,d,payload
  end
end

return request