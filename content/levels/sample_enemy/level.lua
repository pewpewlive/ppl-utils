-- Set how large the level will be.
pewpew.set_level_size(500fx, 500fx)

-- Create an entity at position (0,0) that will hold the background mesh.
local background = pewpew.new_customizable_entity(0fx, 0fx)
pewpew.customizable_entity_set_mesh(background, "/dynamic/square500x500_graphic.lua", 0)

-- Configure player.
pewpew.configure_player(0, {shield = 100})

-- Create the player's ship.
local player_x = 250fx
local player_y = 100fx
local player_index = 0 -- there is only one player
local ship_id = pewpew.new_player_ship(player_x, player_y, player_index)
-- Configure the weapon
local weapon_config = {frequency = pewpew.CannonFrequency.FREQ_10, cannon = pewpew.CannonType.DOUBLE}
pewpew.configure_player_ship_weapon(ship_id, weapon_config)

-- Function that creates an enemy bullet.
-- The bullet is spawned at the position `x`,`y` and goes in the direction
-- specified by `angle`.
function new_enemy_bullet(x, y, angle)
  local id = pewpew.new_customizable_entity(x, y)
  pewpew.customizable_entity_start_spawning(id, 0)
  pewpew.customizable_entity_set_mesh(id, "/dynamic/bullet_graphic.lua", 0)
  pewpew.customizable_entity_set_position_interpolation(id, true)
  pewpew.entity_set_radius(id, 10fx)
  -- Make the bullet move
  local dy, dx = fmath.sincos(angle)
  dx = dx * 4fx
  dy = dy * 4fx
  pewpew.entity_set_update_callback(id, function()
    local x,y = pewpew.entity_get_position(id)
    x = x + dx
    y = y + dy
    pewpew.entity_set_position(id, x, y)
  end)
  -- Make the bullet collide with walls: destroy the bullet on collision.
  pewpew.customizable_entity_configure_wall_collision(id, false, function()
    pewpew.customizable_entity_start_exploding(id, 10)
  end)
  -- Make the bullet collide with player ships: add 3 damage to the ship, and destroy the bullet.
  pewpew.customizable_entity_set_player_collision_callback(id, function(entity_id, player_id, ship_id)
    pewpew.add_damage_to_player_ship(ship_id, 3)
    pewpew.customizable_entity_start_exploding(entity_id, 10)
  end)
end

-- Function that creates a custom enemy at the position `x`,`y`.
-- The enemy explodes if it is hit by a player's weapon.
-- The enemy sends a bullet in a random direction every 10 ticks.
-- The enemy moves up for 10 ticks, then moves down for 10 ticks.
function new_custom_enemy(x, y)
  local id = pewpew.new_customizable_entity(x, y)
  pewpew.customizable_entity_set_mesh(id, "/dynamic/enemy_graphic.lua", 0)
  pewpew.customizable_entity_set_position_interpolation(id, true)
  pewpew.entity_set_radius(id, 40fx)
  -- Explode when it is hit.
  pewpew.customizable_entity_set_weapon_collision_callback(id, function()
    pewpew.customizable_entity_start_exploding(id, 10)
    return true
  end)
  -- Send a bullet every 10 ticks.
  local time = 0
  local dy = 5fx
  pewpew.entity_set_update_callback(id, function()
    time = time + 1
    local x,y = pewpew.entity_get_position(id)
    if time == 10 then
      time = 0
      local angle = fmath.random_fixedpoint(0fx, fmath.tau())
      new_enemy_bullet(x, y, angle)
      -- Change direction.
      dy = -dy
    end
    pewpew.entity_set_position(id, x, y + dy)
  end)
  
end

-- Create a new enemy every 101 tick
local time = 0
function level_tick()
  -- Stop the game if the player is dead.
  local conf = pewpew.get_player_configuration(player_index)
  if conf["has_lost"] == true then
    pewpew.stop_game()
  end
  time = time + 1
  if time % 101 == 5 then
    local x = fmath.random_fixedpoint(100fx, 400fx)
    local y = fmath.random_fixedpoint(100fx, 400fx)
    new_custom_enemy(x, y)
  end
end

pewpew.add_update_callback(level_tick)