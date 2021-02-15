
local box = {}

--- Creates and returns a new box.
-- @param x fixedpoint: The x location of the center of the box.
-- @param y fixedpoint: The y location of the center of the box.
-- @param outer_mesh_info table: Contains the path to the main mesh of the box, and its index.
-- @param inner_mesh_info table: Contains the path to the inner mesh of the box that spins, and its index.
-- @param collision_callback function: The callback called when the ship of a player takes the box. Receives in argument the player's index and the ship's EntityId.
-- @param expiration int: The duration in game ticks of the bonus. If nil, the bonus lasts forever.
function box.new(x, y, outer_mesh_info, inner_mesh_info, collision_callback, expiration)
  if expiration == nil then
    expiration = -1
  end

  -- Create the main entity: it responds to collisions, holds the outer_mesh.
  local id = pewpew.new_customizable_entity(x, y)
  pewpew.customizable_entity_start_spawning(id, 15)
  pewpew.customizable_entity_set_mesh(id, outer_mesh_info[1], outer_mesh_info[2])
  pewpew.entity_set_radius(id, 20fx)

  -- Create the secondary entity. It holds the inner_mesh and rotates.
  local inner_mesh_id = pewpew.new_customizable_entity(x, y)
  pewpew.customizable_entity_set_mesh(inner_mesh_id, inner_mesh_info[1], inner_mesh_info[2])
  pewpew.customizable_entity_set_mesh_z(inner_mesh_id, 10fx)
  local inner_mesh_angle = 0fx

  local function collision_callback_wrapper(entity_id, player_id, ship_id)
    -- Remove the update callback to stop the rotation of the inner_mesh.
    pewpew.entity_set_update_callback(id, nil)
    -- Start the explosion
    pewpew.customizable_entity_start_exploding(inner_mesh_id, 40)
    pewpew.customizable_entity_start_exploding(id, 30)
    -- Notify about the collision
    if collision_callback ~= nil then
      collision_callback(player_id, ship_id)
      collision_callback = nil
    end
  end
  pewpew.customizable_entity_set_player_collision_callback(id, collision_callback_wrapper)

  local function update_callback()
    inner_mesh_angle = inner_mesh_angle + 0.409fx
    pewpew.customizable_entity_set_mesh_angle(inner_mesh_id, inner_mesh_angle, 1fx, 0.2047fx, 0.1365fx)
    if expiration > 0 then
      expiration = expiration - 1
      if expiration < 180 then -- start to fade out the bonus
        local alpha = (expiration * 255) // 180
        local color = 0xffffff00 + alpha
        pewpew.customizable_entity_set_mesh_color(id, color)
        pewpew.customizable_entity_set_mesh_color(inner_mesh_id, color)
        if expiration == 0 then
          -- because of a bug in PewPew 0.0.83 and earlier, you must not destroy
          -- the entity immediately because of the arrow pointing to it.
          -- pewpew.entity_destroy(id)
          pewpew.customizable_entity_start_exploding(id, 1)
          pewpew.entity_destroy(inner_mesh_id)
        end
      end
    end
  end
  pewpew.entity_set_update_callback(id, update_callback)
  return id
end

return box
