local helpers = require("/dynamic/helpers/mesh_helpers.lua")

function create_box(color)
  local mesh = helpers.new_mesh()
  helpers.add_vertical_cylinder_to_mesh(mesh, {0,0,0}, 40, 22, 7, color)
  return mesh
end

meshes = {
  create_box(0xffff00ff), -- Yellow box (used by the Shield box)
  create_box(0xffffffff), -- White box (used by the Shoot box)
}

