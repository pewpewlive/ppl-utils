-- Set how large the level will be.
pewpew.set_level_size(1000fx, 1000fx)

local bafs = {}

function baf_update(entity_id)
  local data = bafs[entity_id]
  local x, y = pewpew.entity_get_position(entity_id)
  x = x + data[1]
  pewpew.customizable_entity_set_mesh_angle(entity_id, data[3], 1fx, 0fx, 0fx)
  data[3] = data[3] + 0.1000fx

  pewpew.entity_set_position(entity_id, x, y)
  if pewpew.entity_get_is_started_to_be_destroyed(entity_id) == true then
    bafs[entity_id] = nil
    pewpew.customizable_entity_set_player_collision_callback(entity_id, nil)
    pewpew.customizable_entity_set_weapon_collision_callback(entity_id, nil)
    pewpew.entity_set_update_callback(entity_id, nil)
    pewpew.customizable_entity_configure_wall_collision(entity_id, true, nil)
  end
end

function baf_collide_with_ship(entity_id, player_index, ship_entity_id)
  pewpew.customizable_entity_start_exploding(entity_id, 20)
end

function baf_collide_with_wall(entity_id)
  local data = bafs[entity_id]
  data[1] = -data[1]
end

function baf_weapon_collision(entity_id, weapon_description)
  local data = bafs[entity_id]
  if data[2] == 0 then
    pewpew.customizable_entity_start_exploding(entity_id, 10)
  else
    data[2] = data[2] - 1
  end
  return true
end

for i=0,1200 do
  local id = pewpew.new_customizable_entity(fmath.random_fixedpoint(100fx, 900fx), fmath.random_fixedpoint(100fx, 900fx))
  -- Format: {dx, life, angle}
  bafs[id] = {5fx, 3, fmath.random_fixedpoint(0fx, fmath.tau())}

  pewpew.customizable_entity_set_mesh(id, "/dynamic/baf_graphic.lua", 0)
  pewpew.customizable_entity_set_position_interpolation(id, true)
  pewpew.entity_set_radius(id, 20fx)

  -- Makes sure the entity won't be drawn when not visible.
  pewpew.customizable_entity_set_visibility_radius(id, 20fx)

  pewpew.customizable_entity_set_weapon_collision_callback(id, baf_weapon_collision)
  pewpew.entity_set_update_callback(id, baf_update)
  pewpew.customizable_entity_set_player_collision_callback(id, baf_collide_with_ship)
  pewpew.customizable_entity_configure_wall_collision(id, true, baf_collide_with_wall)
end

-- Create an entity at position (0,0) that will hold the background mesh.
local background = pewpew.new_customizable_entity(0fx, 0fx)
pewpew.customizable_entity_set_mesh(background, "/dynamic/background_graphic.lua", 0)

-- Create and configure the player's ship.
local player_x = 250fx
local player_y = 100fx
local player_index = 0 -- there is only one player
local ship_id = pewpew.new_player_ship(player_x, player_y, player_index)
local weapon_config = {frequency = pewpew.CannonFrequency.FREQ_10, cannon = pewpew.CannonType.DOUBLE}
pewpew.configure_player_ship_weapon(ship_id, weapon_config)
