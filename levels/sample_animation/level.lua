local id = pewpew.new_customizable_entity(0fx, 0fx)
pewpew.customizable_entity_start_spawning(id, 0)

local tick = 0
pewpew.entity_set_update_callback(id, function()
  -- We have 120 frames.
  -- The index of the 120th frame is 119. (Although we are using Lua, mesh and sound indexes start from 0 in PewPew Live API.)
  -- Loop when we have exceeded past the last frame by using the modulo operator % in Lua.
  pewpew.customizable_entity_set_flipping_meshes(id, "/dynamic/graphics.lua", (tick * 2) % 120, (tick * 2 + 1) % 120)

  tick = tick + 1
end)
