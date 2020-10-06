local width = 500fx
local height = 500fx
pewpew.set_level_size(width, height)

local time = 0

local background = pewpew.new_customizable_entity(0fx, 0fx)
pewpew.customizable_entity_set_mesh(background, "/dynamic/square500x500_graphic.lua", 0)

pewpew.new_player_ship(250fx, 250fx, 0)

function level_tick()
  if time % 30 == 0 then
    local x = 100fx
    local y = 100fx
    pewpew.play_sound("/dynamic/sounds.lua", 0, x, y)
    pewpew.create_explosion(x, y, 0xff0000ff, 1fx, 50)
  end
  if time % 30 == 15 then
    local x = 400fx
    local y = 400fx
    pewpew.play_sound("/dynamic/sounds.lua", 1, x, y)
    pewpew.create_explosion(x, y, 0x00ffffff, 1fx, 50)
  end
  time = time + 1
end

-- Register the `level_tick` function to be called at every game tick.
pewpew.add_update_callback(level_tick)