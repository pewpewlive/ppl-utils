local angle_helpers = require("/dynamic/helpers/angle_helpers.lua")
local player_helpers = require("/dynamic/helpers/player_helpers.lua")
local floating_message = require("/dynamic/helpers/floating_message.lua")
local shield_box = require("/dynamic/helpers/boxes/shield_box.lua")
local cannon_box = require("/dynamic/helpers/boxes/cannon_box.lua")

local width = 300fx
local height = 300fx
pewpew.set_level_size(width, height)

local background = pewpew.new_customizable_entity(0fx, 0fx)
pewpew.customizable_entity_set_mesh(background, "/dynamic/graphics.lua", 0)


-- Create players
local weapon_config = {frequency = pewpew.CannonFrequency.FREQ_10, cannon = pewpew.CannonType.DOUBLE}
local ship = player_helpers.new_player_ship(width / 2fx, height / 2fx, 0)
pewpew.configure_player(0, {camera_distance = 50fx, shield = 3})
pewpew.configure_player_ship_weapon(ship, weapon_config)


local function random_position()
  return fmath.random_fixedpoint(10fx, width-10fx), fmath.random_fixedpoint(10fx, height-10fx)
end

local time = 0
pewpew.add_update_callback(
    function()
      time = time + 1
      local modulo = time % 100
      if modulo == 0 then
        local x,y = random_position()
        shield_box.new(x, y, weapon_config)
      end
      if modulo == 66 then
        local x,y = random_position()
        cannon_box.new(x, y, fmath.random_int(0, 4))
      end
      if modulo == 33 then
        local x, y = random_position()
        floating_message.new(x, y - 50fx,  "Hello!", 1fx, 0xffffffff, 0)
        floating_message.new(x, y, "Hello!", 1fx, 0xffffffff, 8)
        floating_message.new(x, y + 50fx, "Hello!", 1fx, 0xffffffff, 16)
      end
    end)
