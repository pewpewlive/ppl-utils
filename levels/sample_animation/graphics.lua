meshes = {}

local inner_radius = 48 -- Inner hexagon
local outer_radius = 96 -- Outer hexagon

for frame = 0, 119 do
  local computed_vertexes, computed_segments = {}, {}

  local inner_segment = {} -- Inner hexagon
  local outer_segment = {} -- Outer hexagon

  local angle_offset = math.tau * frame / 120

  local vertex_index = 0
  for i = 0, 5 do -- We want to go from angle 0 to 2π, skipping by 2π / 6, making a hexagon
    local angle = math.tau * i / 6

    local y1, x1 = math.sincos(angle + angle_offset)                          -- y and x positions on the unit circle
    table.insert(computed_vertexes, { x1 * inner_radius, y1 * inner_radius }) -- Vertex for the inner hexagon

    local y2, x2 = math.sincos(angle - angle_offset)
    table.insert(computed_vertexes, { x2 * outer_radius, y2 * outer_radius }) -- Vertex for the outer hexagon

    table.insert(inner_segment, vertex_index)                                 -- Adding the vertex to the segment forming the inner hexagon
    table.insert(outer_segment, vertex_index + 1)                             -- Adding the vertex to the segment forming the outer hexagon
    table.insert(computed_segments, { vertex_index, vertex_index + 1 })       -- Line joining the corresponding vertexes of the inner and outer hexagons

    vertex_index = vertex_index + 2
  end

  table.insert(inner_segment, 0) -- The first vertex of the inner hexagon has the index of 0
  table.insert(outer_segment, 1) -- The first vertex of the outer hexagon has the index of 1, as it was generated after that of the inner hexagon

  table.insert(computed_segments, inner_segment)
  table.insert(computed_segments, outer_segment)

  table.insert(meshes, {
    vertexes = computed_vertexes,
    segments = computed_segments
  })
end
