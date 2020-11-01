local helper = require("/dynamic/helpers/mesh_helpers.lua")

meshes = {{
  vertexes = {{0,0}, {0,300}, {300,300}, {300,0}},
  segments = {{0,1,2,3,0}},
  colors = {0xff0000ff, 0xff0000ff, 0xff0000ff, 0xff0000ff}
}}

helper.add_vertical_cylinder_to_mesh(meshes[1], {150,150,-200}, 400, 400, 100, 0xff0000ff)
