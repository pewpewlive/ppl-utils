-- Set how large the level will be.
pewpew.set_level_size(500, 500)

-- Create an entity that will hold the background mesh.
local background = pewpew.new_customizable_entity(0, 0)
pewpew.customizable_entity_set_mesh(background, "/dynamic/square500x500_graphic.lua")

-- Create the player's ship.
pewpew.new_player_ship(250, 250, 0)
