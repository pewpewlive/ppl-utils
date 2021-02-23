-- Set how large the level will be.
pewpew.set_level_size(500fx, 500fx)

-- Create an entity at position (0,0) that will hold the background mesh.
local background = pewpew.new_customizable_entity(0fx, 0fx)
pewpew.customizable_entity_set_mesh(background, "/dynamic/square500x500_graphic.lua", 0)

-- Create the player's ship.
local player_x = 250fx
local player_y = 100fx
local player_index = 0 -- there is only one player
pewpew.new_player_ship(player_x, player_y, player_index)

-- Create a "baf" enemy.
local baf_x = 250fx
local baf_y = 400fx
local baf_angle = 0fx
local baf_speed = 10fx
local lifetime = -1 -- Use a negative number to indicate that the lifetime is infinite
pewpew.new_baf(baf_x, baf_y, baf_angle, baf_speed, lifetime)

local time = 0

-- A function that will get called every game tick, which is 30 times per seconds.
function level_tick()
  -- Stop the game if the player is dead.
  local conf = pewpew.get_player_configuration(player_index)
  if conf["has_lost"] == true then
    pewpew.stop_game()
  end
end

-- Register the `level_tick` function to be called at every game tick.
pewpew.add_update_callback(level_tick)