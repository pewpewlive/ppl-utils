local color_helper = require("/dynamic/helpers/color_helpers.lua")

local floating_message = {}

function floating_message.new(x, y, text, scale, color, d_alpha)
  local id = pewpew.new_customizable_entity(x, y)
  local z = 0fx
  local alpha = 255
  pewpew.customizable_entity_set_mesh_scale(id, scale)


  pewpew.entity_set_update_callback(id, function()
    z = z + 20fx
    local color = color_helper.make_color_with_alpha(color, alpha)
    local color_s = color_helper.color_to_string(color)
    pewpew.customizable_entity_set_string(id, color_s .. text)
    pewpew.customizable_entity_set_mesh_z(id, z)
    alpha = alpha - d_alpha
    if alpha <= 0 then
      pewpew.entity_destroy(id)
    end
  end)
  return id
end

return floating_message