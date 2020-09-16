local gfx = require("dynamic/other/tutorial/graphics_helpers.lua")

meshes = {gfx.new_mesh(), gfx.new_mesh()}

gfx.add_cube_to_mesh(meshes[1], {0, 0, 15}, 30, 0x00ff00ff)
gfx.add_cube_to_mesh(meshes[2], {0, 0, 0}, 12, 0x00ff00ff)