-- Set how large the level will be.
local width = 600fx
local height = 500fx
pewpew.set_level_size(width, height)

-- Create an entity at position (0,0) that will hold the background mesh.
local background = pewpew.new_customizable_entity(0fx, 0fx)
pewpew.customizable_entity_set_mesh(background, "/dynamic/rectangles_graphic.lua", 0)

local dots_background = pewpew.new_customizable_entity(0fx, 0fx)
pewpew.customizable_entity_set_mesh(dots_background, "/dynamic/random_dots.lua", 0)

-- Configure the player, with 2 shields.
pewpew.configure_player(0, {shield = 2})

-- Show "Good day to create" in the HUD
pewpew.configure_player_hud(0, {top_left_line = "Good day to create"})

-- Create the player's ship at the center of the map.
local ship_id = pewpew.new_player_ship(width / 2fx, height / 2fx, 0)
-- Configure the permanent weapon of the player's ship.
pewpew.configure_player_ship_weapon(ship_id, { frequency = pewpew.CannonFrequency.FREQ_6, cannon = pewpew.CannonType.DOUBLE})

local time = 0
-- A function that will get called every game tick, which is 30 times per seconds.
function level_tick()
  time = time + 1
  pewpew.increase_score_of_player(0, 1)

  -- Stop the game if the player is dead.
  local conf = pewpew.get_player_configuration(0)
  if conf["has_lost"] == true then
    pewpew.stop_game()
  end

  -- Every 30 tick, create a new enemy.
  if time % 30 == 0 then
    local x = fmath.random_fixedpoint(0fx, width)
    local y = fmath.random_fixedpoint(0fx, height)

    local choice = fmath.random_int(0, 100)
    
    -- Create a new BAF
    if choice < 50 then
      local angle = fmath.from_fraction(-1, 4) * fmath.tau()
      local baf_speed = fmath.random_fixedpoint(5fx, 10fx)
      pewpew.new_baf(x, y, angle, baf_speed, -1)
      -- Also create a small blue explosion
      pewpew.create_explosion(x, y, 0xff0000ff, 0.2047fx, 50)
    elseif choice < 80 then
    -- Create a new Mothership
      local angle = fmath.random_fixedpoint(0fx, fmath.tau())
      pewpew.new_mothership(x, y, pewpew.MothershipType.SEVEN_CORNERS, angle)
    elseif choice < 90 then
      local angle = fmath.random_fixedpoint(0fx, fmath.tau())
      local acceleration = fmath.random_fixedpoint(0.2000fx, 1fx)
      pewpew.new_inertiac(x, y, acceleration, angle)
    end
  end


end

-- Register the `level_tick` function to be called at every game tick.
pewpew.add_update_callback(level_tick)