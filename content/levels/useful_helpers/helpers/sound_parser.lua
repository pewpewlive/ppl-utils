function split(str, pat)
   local t = {}  -- NOTE: use {n = 0} in Lua-5.0
   local fpat = "(.-)" .. pat
   local last_end = 1
   local s, e, cap = str:find(fpat, 1)
   while s do
      if s ~= 1 or cap ~= "" then
         table.insert(t,cap)
      end
      last_end = e+1
      s, e, cap = str:find(fpat, last_end)
   end
   if last_end <= #str then
      cap = str:sub(last_end)
      table.insert(t, cap)
   end
   return t
end

function parseSound(link)
  local parts = split(link, '%%22')
  local sound = {}

  for i = 2, #parts,2 do
    local value = parts[i + 1]:sub(4, -4)
    if parts[i] == 'waveform' then
      value = parts[i + 2]
    end
    if parts[i] == 'amplification' then
      value = value / 100.0
    end
    if value == "true" then
      value = true
    end
    if value == "false" then
      value = false
    end
    sound[parts[i]] = value
  end
  return sound
end

function EditedSound(sound, new_kvs)
    local sound_copy = {}
    for k,v in pairs(sound) do
      sound_copy[k] = v
    end
    for k,v in pairs(new_kvs) do
      sound_copy[k] = v
    end
    return sound_copy
  end
