-- Set how large the level will be.
pewpew.set_level_size(500fx, 500fx)

-- Create an entity at position (0,0) that will hold the background mesh.
local background = pewpew.new_customizable_entity(0fx, 0fx)

-- Animate the background.
local frame = 0
pewpew.add_update_callback(function()
  frame = frame + 1
  if frame == 50 then
    frame = 0
  end
  pewpew.customizable_entity_set_mesh(background, "/dynamic/square500x500_graphic.lua", frame)
end)

-- Create the player's ship.
local player_x = 250fx
local player_y = 100fx
local player_index = 0 -- there is only one player
pewpew.new_player_ship(player_x, player_y, player_index)
