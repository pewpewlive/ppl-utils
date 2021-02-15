
local box = {}

local Box = {}

--- Creates and returns a new box.
-- @param x fixedpoint: The x location of the center of the box.
-- @param y fixedpoint: The y location of the center of the box.
-- @param outer_mesh_info table: Contains the path to the main mesh of the box, and its index.
-- @param inner_mesh_info table: Contains the path to the inner mesh of the box that spins, and its index.
-- @param callback function: The callback called when the ship of a player takes the box. Receives in argument the player's index and the ship's EntityId.
function box.new(x, y, outer_mesh_info, inner_mesh_info, callback)
  local self = {}
  setmetatable(self, { __index = Box })

  -- Create the main entity: it responds to collisions, holds the outer_mesh.
  self.handle = pewpew.new_customizable_entity(x, y)
  pewpew.customizable_entity_start_spawning(self.handle, 15)
  pewpew.customizable_entity_set_mesh(self.handle, outer_mesh_info[1], outer_mesh_info[2])
  pewpew.entity_set_radius(self.handle, 20fx)

  -- Create the secondary entity. It holds the inner_mesh and rotates.
  self.inner_mesh_handle = pewpew.new_customizable_entity(x, y)
  pewpew.customizable_entity_set_mesh(self.inner_mesh_handle, inner_mesh_info[1], inner_mesh_info[2])
  pewpew.customizable_entity_set_mesh_z(self.inner_mesh_handle, 10fx)
  self.inner_mesh_angle = 0fx


  local function collision_callback(entity_id, player_id, ship_id)
    -- Remove the update callback to stop the rotation of the inner_mesh.
    pewpew.entity_set_update_callback(entity_id, nil)
    -- Start the explosion
    pewpew.customizable_entity_start_exploding(self.inner_mesh_handle, 40)
    pewpew.customizable_entity_start_exploding(entity_id, 30)
    -- Notify about the collision
    if callback ~= nil then
      callback(player_id, ship_id)
      callback = nil
    end
  end

  pewpew.customizable_entity_set_player_collision_callback(self.handle, collision_callback)

  local function update_callback()
    self.inner_mesh_angle = self.inner_mesh_angle + 0.409fx
    pewpew.customizable_entity_set_mesh_angle(self.inner_mesh_handle, self.inner_mesh_angle, 1fx, 0.2047fx, 0.1365fx)
  end

  pewpew.entity_set_update_callback(self.handle, update_callback)

  return self
end

return box
