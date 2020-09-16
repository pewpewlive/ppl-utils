local gfx = require("dynamic/other/tutorial/graphics_helpers.lua")

function make_cage_mesh()
  local mesh = gfx.new_mesh()
  local color = 0x40ffffff
  for i = 200 - 20, 200 + 20, 5 do
    gfx.add_line_to_mesh(mesh, {{i, 200 - 20, -50}, {i, 200 - 20, 50}}, {color, color})
    gfx.add_line_to_mesh(mesh, {{i, 200 + 20, -50}, {i, 200 + 20, 50}}, {color, color})
    gfx.add_line_to_mesh(mesh, {{200 - 20, i, -50}, {200 - 20, i, 50}}, {color, color})
    gfx.add_line_to_mesh(mesh, {{200 + 20, i, -50}, {200 + 20, i, 50}}, {color, color})
  end
  return mesh
end

meshes = {make_cage_mesh()}