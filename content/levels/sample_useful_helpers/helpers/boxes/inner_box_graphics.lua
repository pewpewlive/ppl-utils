local helpers = require("/dynamic/helpers/mesh_helpers.lua")

function create_shield_inner_mesh()
  local mesh = {}
  local a = 3
  local b = 10
  local c = 0xffff00ff
  mesh.vertexes = {
    {b, -a}, {b, a}, {a, a}, {a, b}, {-a, b}, {-a, a}, {-b, a}, {-b, -a}, {-a, -a}, {-a, -b},
    {a, -b}, {a, -a},
  }
  mesh.segments = {{0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 0}}
  mesh.colors = c
  return mesh
end

function create_hemisphere_mesh()
  local mesh = helpers.new_mesh()
  local number_of_points = 10
  local radius = 10
  local compute = function(i)
    local angle = (i - 1) * math.pi / number_of_points
    return {math.cos(angle) * radius, -5 + math.sin(angle) * radius}, 0xffff00ff
  end
  helpers.add_computed_segments_to_mesh(mesh, number_of_points, compute, false)
  return mesh
end

meshes = {
  -- The + in the ShieldBox
  create_shield_inner_mesh(), -- The ✚ in the health box
  {
    -- The + bullet in the shoot box
    vertexes = {{-8, 0}, {8, 0}, {0, -8}, {0 ,8}, {0,0,-8}, {0,0,8}},
    segments = {{0, 1}, {2,3}, {4,5}},
    colors = 0x11ffeeff
  },
  {
    -- The ◇ bullet in the shoot box
    vertexes = {{8, 0}, {0, 6}, {-8, 0}, {0, -6}, {0, 0, 6}},
    segments = {{0, 1, 2, 3, 0}, {0, 4, 2}},
    colors = 0xff4040ff
  },
  create_hemisphere_mesh(), -- The hemisphere icon for shoot box
  {
    -- three horizontal lines in the shoot box
    vertexes = {{-10, -6}, {10, -6}, {-10, 6}, {10, 6}, {-10, 0}, {10, 0}},
    segments = {{0, 1}, {2, 3}, {4, 5}},
    colors = 0x9030ffff
  },
}

