local gfx = require("dynamic/other/tutorial/graphics_helpers.lua")

function make_level_mesh()
  local mesh = gfx.new_mesh()
  local color = gfx.make_color(255, 255, 255, 255)
  gfx.add_line_to_mesh(mesh, {{0, 0}, {400, 0}, {400, 400}, {0, 400}}, {color, color, color, color}, true)

  local w = 4

  local color = gfx.make_color(255, 255, 255, 40)
  for x = 0, 8 do
    for y = 0, 8 do
      if (x + y) % 2 == 0 then
        gfx.add_line_to_mesh(mesh, {{x * 50 - w, y * 50, 0}, {x * 50 + w, y * 50, 0}}, {color, color})
        gfx.add_line_to_mesh(mesh, {{x * 50, y * 50 - w, 0}, {x * 50, y * 50 + w, 0}}, {color, color})
      end
    end
  end
  return mesh
end

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

meshes = {make_level_mesh(), make_cage_mesh()}