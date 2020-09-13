pewpew.set_level_size(500fx, 500fx)

local rectangle_background = pewpew.new_customizable_entity(0fx, 0fx)
pewpew.customizable_entity_set_mesh(rectangle_background, "/dynamic/examples/complex_graphics/rectangles_graphic.lua", 0)

local polar_function_background = pewpew.new_customizable_entity(0fx, 0fx)
pewpew.customizable_entity_set_mesh(polar_function_background, "/dynamic/examples/complex_graphics/polar_graphic.lua", 0)

pewpew.new_player_ship(100fx, 100fx, 0)