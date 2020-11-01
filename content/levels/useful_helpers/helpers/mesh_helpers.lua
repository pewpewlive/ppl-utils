local helper = {}

--- Creates a new empty mesh.
function helper.new_mesh()
  local mesh = {}
  mesh.vertexes = {}
  mesh.segments = {}
  mesh.colors = {}
  return mesh
end

--- Adds a line to a mesh.
-- @params mesh table: a properly formated mesh. Possibly created with `new_mesh`.
-- @params vertex table: a list of either 2D or 3D vertexes. The coordinates of the vertexes are floats.
-- @params colors table: a list of colors. There should be as many colors as there are vertexes.
-- @params close_loop boolean: whether the line should be a closed loop, with the first vertex being linked with the last vertex.
function helper.add_line_to_mesh(mesh, vertexes, colors, close_loop)
  local vertex_count = #mesh.vertexes
  local color_count = #mesh.colors
  local segment_count = #mesh.segments
  local number_of_new_segments = #vertexes - 1
  local segments = {}

  for i = 1, #vertexes do
    table.insert(mesh.vertexes, vertexes[i])
    table.insert(mesh.colors, colors[i])
  end

  table.insert(segments, vertex_count)
  for i = 1, number_of_new_segments do
    table.insert(segments, vertex_count + i)
  end
  if close_loop then
    table.insert(segments, vertex_count)
  end
  table.insert(mesh.segments, segments)
end

--- Adds distincts segments to a mesh.
-- @params vertexes table: An array or vertexes. The vertexes {a,b,c,d} will draw 2 distinct segments: {a,b} and {c,d}
-- @params colors table: a list of colors. There should be as many colors as there are vertexes.
function helper.add_segments_to_mesh(mesh, vertexes, colors)
  vertex_count = #mesh.vertexes
  new_vertex_count = #vertexes
  if new_vertex_count % 2 ~= 0 then
    pewpew.print("Error: array's size should be even.")
    return
  end

  for i = 1, new_vertex_count do
    table.insert(mesh.vertexes, vertexes[i])
    table.insert(mesh.colors, colors[i])
  end

  for i = 0, new_vertex_count - 1, 2 do
    table.insert(mesh.segments, {vertex_count + i, vertex_count + i + 1})
  end
end

function helper.add_computed_segments_to_mesh(mesh, number_of_points, compute_vertex_and_color, looping)
  local vertex_count = #mesh.vertexes
  local color_count = #mesh.colors
  local segment_count = #mesh.segments

  local vertex_index = vertex_count + 1
  for i = 1, number_of_points do
    local vertex, color = compute_vertex_and_color(i)
    mesh.vertexes[vertex_index] = vertex
    mesh.colors[vertex_index] = color
    vertex_index = vertex_index + 1
  end

  local segments = {}
  for i = 1, number_of_points do
    table.insert(segments, vertex_count + i - 1)
  end
  if looping then
    table.insert(segments, vertex_count)
  end 
  table.insert(mesh.segments, segments)
end

function helper.add_horizontal_regular_polygon_to_mesh(mesh, center, radius, number_of_points, color, angle_offset)
  local compute = function(i)
    local angle = (i - 1) * 2 * math.pi / number_of_points
    local sin_angle, cos_angle = math.sincos(angle + angle_offset)
    return {center[1] + cos_angle * radius, center[2] + sin_angle * radius, center[3]}, color
  end
  helper.add_computed_segments_to_mesh(mesh, number_of_points, compute, true)
end

function helper.add_cube_to_mesh(mesh, center, side_length, color)
  local half = side_length / 2
  local x = center[1]
  local y = center[2]
  local z = center[3]

  local a = {x - half, y - half, z - half}
  local b = {x - half, y + half, z - half}
  local c = {x + half, y + half, z - half}
  local d = {x + half, y - half, z - half}
  local e = {x - half, y - half, z + half}
  local f = {x - half, y + half, z + half}
  local g = {x + half, y + half, z + half}
  local h = {x + half, y - half, z + half}

  helper.add_line_to_mesh(mesh, {a, b, c, d}, {color, color, color, color}, true)
  helper.add_line_to_mesh(mesh, {e, f, g, h}, {color, color, color, color}, true)
 
  helper.add_line_to_mesh(mesh, {a, e}, {color, color})
  helper.add_line_to_mesh(mesh, {b, f}, {color, color})
  helper.add_line_to_mesh(mesh, {c, g}, {color, color})
  helper.add_line_to_mesh(mesh, {d, h}, {color, color})
end

function helper.add_vertical_cylinder_to_mesh(mesh, bottom_center, height, radius, number_of_points, color)
  local bottom_center = {bottom_center[1], bottom_center[2] , bottom_center[3]}
  local top_center = {bottom_center[1], bottom_center[2] , bottom_center[3] + height}

  local index_of_first_vertex = #mesh.vertexes
  helper.add_horizontal_regular_polygon_to_mesh(mesh, bottom_center, radius, number_of_points, color, 0)
  helper.add_horizontal_regular_polygon_to_mesh(mesh, top_center, radius, number_of_points, color, 0)

  -- Add the segments linking the 2 regular polygons
  for i=1,number_of_points do
    table.insert(mesh.segments, {index_of_first_vertex, index_of_first_vertex + number_of_points})
    index_of_first_vertex = index_of_first_vertex + 1
  end
end

return helper

