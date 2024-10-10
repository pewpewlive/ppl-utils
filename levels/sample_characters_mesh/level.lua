
function add_character_mesh(x, y, index)
  local e = pewpew.new_customizable_entity(x, y)
  pewpew.customizable_entity_set_mesh(e, "/dynamic/characters/characters.lua", index)
  pewpew.customizable_entity_set_mesh_scale(e, 80fx / 100fx)
end

local index = 0
for y = 10, -10, -1 do
  for x = -10, 10 do
    add_character_mesh(fmath.to_fixedpoint(x) * 30fx, fmath.to_fixedpoint(y) * 25fx, index)
    index = index + 1
  end
end

pewpew.configure_player(0, {move_joystick_color = 0x00000000, shoot_joystick_color = 0x00000000})
