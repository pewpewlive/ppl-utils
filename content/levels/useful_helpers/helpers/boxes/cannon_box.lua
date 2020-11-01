local box = require("/dynamic/helpers/boxes/box_template.lua")
local floating_message = require("/dynamic/helpers/floating_message.lua")
local player_helpers = require("/dynamic/helpers/player_helpers.lua")


local cannon_box = {}

function cannon_box.new(x, y, type)

  local duration = 100

  local frequency
  local cannon_type
  local frame
  local explosion_color
  local msg

  if type == 0 then
    frequency = pewpew.CannonFrequency.FREQ_15
    cannon_type = pewpew.CannonType.TRIPLE
    frame = 1
    explosion_color = 0x00ffffff
    msg = "Triple"
  elseif type == 1 then
    frequency = pewpew.CannonFrequency.FREQ_30
    cannon_type = pewpew.CannonType.DOUBLE_SWIPE
    frame = 2
    explosion_color = 0xff8080ff
    msg = "Double swipe"
  elseif type == 2 then
    frequency = pewpew.CannonFrequency.FREQ_3
    cannon_type = pewpew.CannonType.HEMISPHERE
    frame = 3
    explosion_color = 0xffff00ff
    msg = "Hemisphere"
  elseif type == 3 then
    frequency = pewpew.CannonFrequency.FREQ_15
    cannon_type = pewpew.CannonType.SINGLE
    frame = 4
    explosion_color = 0x8020ffff
    msg = "AK-286"
  elseif type == 4 then
    frequency = pewpew.CannonFrequency.FREQ_15
    cannon_type = pewpew.CannonType.DOUBLE
    frame = 1
    explosion_color = 0xff0000ff
    msg = "Double"
  else
    return
  end

  pewpew.play_sound("/dynamic/helpers/boxes/bonus_spawn.lua", 0, x, y)

  local b = box.new(x, y, {"/dynamic/helpers/boxes/box_graphics.lua", 1}, {"/dynamic/helpers/boxes/inner_box_graphics.lua", frame},
    function(player_id, entity_id)
      pewpew.configure_player_ship_weapon(
          entity_id, {frequency = frequency, cannon = cannon_type, duration = duration})
      pewpew.play_sound("/dynamic/helpers/boxes/cannon_pickup_sound.lua", 0, x, y)
      pewpew.create_explosion(x, y, 0xffffffff, 1fx, 20)
      pewpew.create_explosion(x, y, explosion_color, 0.4000fx, 20)
      floating_message.new(x, y, msg, 1.2048fx, explosion_color, 4)
    end, 400)
  player_helpers.add_arrow(b, 0xffffffff)

  return b
end

return cannon_box