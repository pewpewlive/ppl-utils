computed_vertexes = {}
computed_segments = {}
computed_colors = {}

local index1 = 0
local index2 = 1
local index3 = 2
local index4 = 3
for z=-1000, 1000, 50 do
  table.insert(computed_vertexes, {0,0,z})
  table.insert(computed_vertexes, {500,0,z})
  table.insert(computed_vertexes, {500,500,z})
  table.insert(computed_vertexes, {0,500,z})
  table.insert(computed_segments, {index1, index2, index3, index4, index1})
  index1 = index1 + 4
  index2 = index2 + 4
  index3 = index3 + 4
  index4 = index4 + 4

  table.insert(computed_colors, math.random(0x000000ff, 0xffffffff))
  table.insert(computed_colors, math.random(0x000000ff, 0xffffffff))
  table.insert(computed_colors, math.random(0x000000ff, 0xffffffff))
  table.insert(computed_colors, math.random(0x000000ff, 0xffffffff))
end

meshes = {
  {
    vertexes = computed_vertexes,
    segments = computed_segments,
    colors = computed_colors
  }
}

