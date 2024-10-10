local id = pewpew.new_customizable_entity(0fx, 0fx)
local mesh_index = 0
pewpew.entity_set_update_callback(id, function()
  -- We have 120 frames out of 121 total frames. The last frame is equal to the first one and is unused.
  -- The index of the 120th frame is 119. (Although we are using lua, mesh and sound indexes start from 0 in PewPew Lib API.)
  -- Loop when we have exceeded past the last frame.
  if mesh_index > 119 then
    mesh_index = 0
  end
  pewpew.customizable_entity_set_flipping_meshes(id, "/dynamic/graphics.lua", mesh_index, mesh_index + 1)
  mesh_index = mesh_index + 2
end)
