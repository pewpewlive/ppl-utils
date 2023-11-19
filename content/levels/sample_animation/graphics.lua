meshes = {}

for angle_offset = 0, math.pi * 2, math.pi * 2 / 120 do -- Our animation will have 120 frames (60 interpolated frames). We want the hexagons to make a full rotation each 60 frames (2 seconds).
  -- Tables for our mesh vertexes, segments
  local computed_vertexes, computed_segments = {}, {}

  local radius = 96       -- Outer hexagon
  local small_radius = 48 -- Inner hexagon

  local i = 0
  for angle = 0, math.pi * 2, math.pi * 2 / 6 do                              -- We want to go from angle 0 to 2π, skipping by 2π / 6, making a hexagon
    local y, x = math.sincos(angle - angle_offset)                            -- y and x positions on the unit circle
    local y2, x2 = math.sincos(angle + angle_offset)                          -- y and x positions on the unit circle for inner hexagon

    table.insert(computed_vertexes, { x * radius, y * radius })               -- Vertex for the outer hexagon
    table.insert(computed_vertexes, { x2 * small_radius, y2 * small_radius }) -- Vertex for the inner hexagon

    table.insert(computed_segments, { i, i + 1 })                             -- Line joining the corresponding vertices of the inner and outer hexagons
    table.insert(computed_segments, { i, i + 2 })                             -- Line joining the vertex of the outer hexagon to its next one
    table.insert(computed_segments, { i + 1, i + 3 })                         -- Line joining the vertex of the inner hexagon to its next one

    i = i + 2
  end

  table.remove(computed_segments, #computed_segments) -- Removal of the last segment as there is no vertex at index i + 3 during the last iteration
  table.remove(computed_segments, #computed_segments) -- No vertex at index i + 2 during the last iteration
  table.remove(computed_segments, #computed_segments) -- A line is already present joining the vertices

  table.insert(meshes, {
    vertexes = computed_vertexes,
    segments = computed_segments,
  })
end
