local box = require("/dynamic/helpers/boxes/box_template.lua")
local floating_message = require("/dynamic/helpers/floating_message.lua")
local player_helpers = require("/dynamic/helpers/player_helpers.lua")

local shield_box = {}

function shield_box.new(x, y, resurrection_weapon_config)
  local b = box.new(x, y, {"/dynamic/helpers/boxes/box_graphics.lua", 0}, {"/dynamic/helpers/boxes/inner_box_graphics.lua", 0}, function(player_id, ship_id)
    pewpew.play_sound("/dynamic/helpers/boxes/shield_pickup_sound.lua", 0, x, y)
    pewpew.create_explosion(x, y, 0xffff00ff, 0.4000fx, 40)

    if pewpew.get_number_of_players() > 1 then -- try to resurrect
      local players_that_lost = {}
      for i = 0, pewpew.get_number_of_players() - 1 do
        if i ~= player_id then
          local conf = pewpew.get_player_configuration(i)
          if conf.has_lost == true then
              players_that_lost[#players_that_lost + 1] = i
          end
        end
      end
      if #players_that_lost > 0 then -- pick one player to resurrect
        local index = fmath.random_int(1, #players_that_lost)
        local player_id = players_that_lost[index]
        local ship = player_helpers.new_player_ship(position[1], position[2], 0)
        pewpew.configure_player_ship_weapon(ship, resurrection_weapon_config)
        pewpew.configure_player(player_id, {has_lost = false})
        pewpew.make_player_ship_transparent(ship, 120)
        local new_message = floating_message.new(x, y, "reinstantiation", 2fx, 0xffff00ff, 3)
        new_message.dz = 10
        new_message.dalpha = 3
        return
      end
    end
    local conf = pewpew.get_player_configuration(player_id)
    pewpew.configure_player(player_id, {shield = conf.shield + 1})
    -- local new_message = floating_message.new(x, y, "Shield +1", 1.5, 0xffff00ff, 3)
  end, 400)
end

return shield_box