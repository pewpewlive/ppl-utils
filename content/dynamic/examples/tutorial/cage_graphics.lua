local gfx = require("dynamic/examples/tutorial/graphics_helpers.lua")

function make_cage_mesh()
  local mesh = gfx.new_mesh()
  local color = 0x40ffffff
  for i = - 20, 20, 5 do
    gfx.add_line_to_mesh(mesh, {{i, -20, -50}, {i, -20, 50}}, {color, color})
    gfx.add_line_to_mesh(mesh, {{i, 20, -50}, {i, 20, 50}}, {color, color})
    gfx.add_line_to_mesh(mesh, {{-20, i, -50}, {-20, i, 50}}, {color, color})
    gfx.add_line_to_mesh(mesh, {{20, i, -50}, {20, i, 50}}, {color, color})
  end
  return mesh
end

meshes = {make_cage_mesh()}