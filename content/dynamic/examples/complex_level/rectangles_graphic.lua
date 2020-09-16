computed_vertexes = {}
computed_segments = {}
computed_colors = {}

function get_random_color()
  local color_set = {0xff0000ff, 0x00ffffff}
  return color_set[math.random(1, #color_set)]
end

local width = 600
local height = 500

local index1 = 0
local index2 = 1
local index3 = 2
local index4 = 3
for z=-200, 200, 50 do
  table.insert(computed_vertexes, {0,0,z})
  table.insert(computed_vertexes, {width,0,z})
  table.insert(computed_vertexes, {width,height,z})
  table.insert(computed_vertexes, {0,height,z})
  table.insert(computed_segments, {index1, index2, index3, index4, index1})
  index1 = index1 + 4
  index2 = index2 + 4
  index3 = index3 + 4
  index4 = index4 + 4

  table.insert(computed_colors, get_random_color())
  table.insert(computed_colors, get_random_color())
  table.insert(computed_colors, get_random_color())
  table.insert(computed_colors, get_random_color())
end

meshes = {
  {
    vertexes = computed_vertexes,
    segments = computed_segments,
    colors = computed_colors
  }
}

