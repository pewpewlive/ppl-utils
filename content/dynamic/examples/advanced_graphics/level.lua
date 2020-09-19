pewpew.set_level_size(500fx, 500fx)

local background1 = pewpew.new_customizable_entity(0fx, 0fx)
pewpew.customizable_entity_set_mesh(background1, "/dynamic/examples/advanced_graphics/polar_graphic.lua", 0)

local background2 = pewpew.new_customizable_entity(200fx, 200fx)
pewpew.customizable_entity_set_mesh(background2, "/dynamic/examples/advanced_graphics/polar_graphic.lua", 1)


pewpew.new_player_ship(100fx, 100fx, 0)