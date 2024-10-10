
-- Horizontally rotating triangle
local horizontal = pewpew.new_customizable_entity(100fx, -100fx)
pewpew.customizable_entity_set_mesh(horizontal, "/dynamic/triangle_graphic.lua", 0)
pewpew.entity_set_update_callback(horizontal, function(entity_id)
  -- Rotate by 0.800fx along the X axis, 30 times per seconds.
  pewpew.customizable_entity_add_rotation_to_mesh(entity_id, 0.800fx, 1fx, 0fx, 0fx)
end)

-- Vertically rotating triangle
local vertical = pewpew.new_customizable_entity(-100fx, 100fx)
pewpew.customizable_entity_set_mesh(vertical, "/dynamic/triangle_graphic.lua", 0)
-- Set the initial rotation to 90 degrees along the Z axis.
pewpew.customizable_entity_set_mesh_angle(vertical, fmath.tau() / 4fx, 0fx, 0fx, 1fx)
pewpew.entity_set_update_callback(vertical, function(entity_id)
  -- Rotate by 0.500fx along the Y axis, 30 times per seconds.
  pewpew.customizable_entity_add_rotation_to_mesh(entity_id, 0.500fx, 0fx, 1fx, 0fx)
end)

--- Variable rotation
local x_angle = 0fx
local z_angle = 0fx
local variable = pewpew.new_customizable_entity(100fx, 100fx)
pewpew.customizable_entity_set_mesh(variable, "/dynamic/triangle_graphic.lua", 0)
pewpew.entity_set_update_callback(variable, function(entity_id)
  -- Set the rotation along the X axis.
  pewpew.customizable_entity_set_mesh_angle(entity_id, x_angle, 1fx, 0fx, 0fx)
  -- Add an additional rotation along the Z axis.
  pewpew.customizable_entity_add_rotation_to_mesh(entity_id, z_angle, 0fx, 0fx, 1fx)
  x_angle = x_angle + 0.2000fx
  z_angle = z_angle + 0.100fx
end)