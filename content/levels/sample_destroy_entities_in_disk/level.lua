
pewpew.set_level_size(500fx, 500fx)
local background = pewpew.new_customizable_entity(0fx, 0fx)
pewpew.customizable_entity_set_mesh(background, "/dynamic/square500x500_graphic.lua", 0)

local ship_id = pewpew.new_player_ship(250fx, 250fx, 0)

local time = 0

function level_tick()
  -- pewpew.print("level tick")
  time = time + 1
  for i=1,3 do
    pewpew.new_baf(fmath.random_fixedpoint(0fx, 500fx), fmath.random_fixedpoint(0fx, 500fx), fmath.random_fixedpoint(0fx, 100fx), 1fx,-1)
  end
  if time % 120 == 0 then
    local e = pewpew.get_entities_colliding_with_disk(250fx, 250fx, 150fx)
    for i=1,#e do
      pewpew.entity_react_to_weapon(e[i], {type = pewpew.WeaponType.ATOMIZE_EXPLOSION, x = 250fx, y = 250fx, player_index = 0})
    end
  end
end

pewpew.add_update_callback(level_tick)