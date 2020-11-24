meshes = {
}

local colors = {0xff0000ff, 0x00ff00ff, 0x0000ffff, 0xffff00ff}

for i=0,100 do
  local mesh_template = {
    vertexes = {{0,0,0}, {500,0,0}, {500,500,0}, {0,500,0}},
    colors = {0xffffffff, 0xffffffff, 0xffffffff, 0xffffffff},
    segments = {{0,1,2,3,0}}
  }

  -- Modify the mesh!
  local index = math.random(1,#colors)
  local random_color = colors[index]
  -- Change the color of the 1st vertex
  mesh_template.colors[1] = random_color
  -- Change the `z` index of the 1st vertex
  mesh_template.vertexes[1][3] = i * 10

  table.insert(meshes, mesh_template)
end
