computed_vertexes = {}
computed_segments = {}

function polar_func(angle)
  return 100 * (1.0 - math.cos(angle) * math.sin(3 * angle))
end

function polar_to_cartesian(angle, radius)
  return math.cos(angle) * radius, math.sin(angle) * radius
end

local index = 0
local line = {}
for angle=0, 6.2831, 0.1 do
  local radius = polar_func(angle)
  local x,y = polar_to_cartesian(angle, radius)
  table.insert(computed_vertexes, {x, y})
  table.insert(line, index)
  index = index + 1
end

-- Close the loop
table.insert(line, 0)

meshes = {
  {
    vertexes = computed_vertexes,
    segments = {line},
  }
}

