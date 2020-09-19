

function f1(angle)
  return 100 * (1.0 - math.cos(angle) * math.sin(3 * angle))
end

function f2(angle)
  return 200 * (math.cos(angle) + math.sin(4 * angle))
end

function mesh_from_polar_function(f)
  computed_vertexes = {}

  local index = 0
  local line = {}
  for angle = 0, math.pi * 2, 0.05 do
    local radius = f(angle)
    local x = math.cos(angle) * radius
    local y = math.sin(angle) * radius
    table.insert(computed_vertexes, {x, y})
    table.insert(line, index)
    index = index + 1
  end

  -- Close the loop
  table.insert(line, 0)

  return  {
    vertexes = computed_vertexes,
    segments = {line},
  }
end



meshes = {
  mesh_from_polar_function(f1),
  mesh_from_polar_function(f2),
}

