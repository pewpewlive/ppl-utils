local gfx = require("/dynamic/graphics_helpers.lua")
local constants = require("/dynamic/constants.lua")

local w = fmath.to_int(constants.level_width)
local h = fmath.to_int(constants.level_height)

function make_level_mesh()
  local mesh = gfx.new_mesh()
  local color = gfx.make_color(255, 255, 255, 255)
  gfx.add_line_to_mesh(mesh, {{0, 0}, {w, 0}, {w, h}, {0, h}}, {color, color, color, color}, true)

  local radius = 4

  local color = gfx.make_color(255, 255, 255, 40)
  for x = 0, w / 50 do
    for y = 0, h / 50 do
      if (x + y) % 2 == 0 then
        gfx.add_line_to_mesh(mesh, {{x * 50 - radius, y * 50, 0}, {x * 50 + radius, y * 50, 0}}, {color, color})
        gfx.add_line_to_mesh(mesh, {{x * 50, y * 50 - radius, 0}, {x * 50, y * 50 + radius, 0}}, {color, color})
      end
    end
  end
  return mesh
end

meshes = {make_level_mesh()}