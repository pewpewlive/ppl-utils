-- Set how large the level will be.
pewpew.set_level_size(500fx, 500fx)

-- Create an entity at position (0,0) that will hold the background mesh.
local background = pewpew.new_customizable_entity(0fx, 0fx)
pewpew.customizable_entity_set_mesh(background, "/dynamic/graphics.lua", 0)

-- Create the walls.
pewpew.add_wall(100fx, 200fx, 400fx, 200fx)
pewpew.add_wall(200fx, 100fx, 400fx, 300fx)

-- Create the player's ship.
local player_x = 250fx
local player_y = 250fx
local player_index = 0 -- there is only one player
pewpew.new_player_ship(player_x, player_y, player_index)