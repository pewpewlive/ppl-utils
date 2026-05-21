-- Set how large the level will be
pewpew.set_level_size(1000fx, 1000fx)

-- Create an entity at (0, 0) that will hold the background mesh
local background_id = pewpew.new_customizable_entity(0fx, 0fx)
pewpew.customizable_entity_set_mesh(background_id, "/dynamic/background_graphics.lua", 0)

-- Create and configure the player's ship
local player_index = 0  -- There is only one player
local ship_id = pewpew.new_player_ship(250fx, 100fx, player_index)

local weapon_config = {
  frequency = pewpew.CannonFrequency.FREQ_10,
  cannon = pewpew.CannonType.DOUBLE
}
pewpew.configure_player_ship_weapon(ship_id, weapon_config)

-- The table in which the BAFs' data are stored
local bafs_entity_data = {}

function baf_update_callback(entity_id)
  if pewpew.entity_get_is_started_to_be_destroyed(entity_id) then
    -- Free the memory
    bafs_entity_data[entity_id] = nil

    -- Remove all callbacks
    pewpew.entity_set_update_callback(entity_id, nil)
    pewpew.customizable_entity_configure_wall_collision(entity_id, true, nil)
    pewpew.customizable_entity_set_weapon_collision_callback(entity_id, nil)
    pewpew.customizable_entity_set_player_collision_callback(entity_id, nil)

    return  -- Exit out of the function immediately
  end

  local entity_data = bafs_entity_data[entity_id]

  local ex, ey = pewpew.entity_get_position(entity_id)

  ex = ex + entity_data[1]

  pewpew.entity_set_position(entity_id, ex, ey)

  pewpew.customizable_entity_add_rotation_to_mesh(entity_id, 0.1000fx, 1fx, 0fx, 0fx)
end

function baf_entity_wall_collision_callback(entity_id)
  local entity_data = bafs_entity_data[entity_id]

  entity_data[1] = -entity_data[1]
end

function baf_entity_weapon_collision_callback(entity_id, player_index, weapon_type, x, y)
  local entity_data = bafs_entity_data[entity_id]

  entity_data[2] = entity_data[2] - 1

  if entity_data[2] <= 0 then
    pewpew.customizable_entity_start_exploding(entity_id, 10)
  end

  return true
end

function baf_entity_player_collision_callback(entity_id, player_index, ship_entity_id)
  pewpew.customizable_entity_start_exploding(entity_id, 20)
end

function new_baf(x, y)
  local entity_id = pewpew.new_customizable_entity(x, y)

  pewpew.customizable_entity_set_mesh(entity_id, "/dynamic/baf_graphics.lua", 0)
  pewpew.customizable_entity_set_mesh_angle(entity_id, fmath.random_fixedpoint(0fx, fmath.tau()), 1fx, 0fx, 0fx)
  pewpew.customizable_entity_set_position_interpolation(entity_id, true)
  pewpew.customizable_entity_set_angle_interpolation(entity_id, true)
  pewpew.entity_set_radius(entity_id, 20fx)

  -- Ensure that the entity will not be rendered when not visible
  pewpew.customizable_entity_set_visibility_radius(entity_id, 20fx)

  bafs_entity_data[entity_id] = {
    5fx,  -- x-velocity
    3,    -- Health
  }

  pewpew.entity_set_update_callback(entity_id, baf_update_callback)
  pewpew.customizable_entity_configure_wall_collision(entity_id, true, baf_entity_wall_collision_callback)
  pewpew.customizable_entity_set_weapon_collision_callback(entity_id, baf_entity_weapon_collision_callback)
  pewpew.customizable_entity_set_player_collision_callback(entity_id, baf_entity_player_collision_callback)

  return entity_id
end

for i = 1, 1200 do
  local x = fmath.random_fixedpoint(100fx, 900fx)
  local y = fmath.random_fixedpoint(100fx, 900fx)

  new_baf(x, y)
end
