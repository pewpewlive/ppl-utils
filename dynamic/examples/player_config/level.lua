-- Set how large the level will be.
pewpew.set_level_size(500, 500)

-- Create an entity that will hold the background mesh.
local background = pewpew.new_customizable_entity(0, 0)
pewpew.customizable_entity_set_mesh(background, "/dynamic/example/square500x500_graphic.lua")

-- Configure the player.
local player_config = {
  shield = 2,
  cameraDistance = 200,
}
pewpew.configure_player(0, player_config)

-- Create the ship, and configure the weapon.
local weapon_config = {
  frequency_type = 2,
  cannon_type = pewpew.cannonType.TIC_TOC
}
local ship = pewpew.new_player_ship(250, 250, 0)
pewpew.configure_player_ship_weapon(ship, weapon_config)
