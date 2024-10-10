local boxes = require("/dynamic/box_template.lua")
local constants = require("/dynamic/constants.lua")

function clamp(v, min, max)
  if v < min then
    return min
  elseif v > max then
    return max
  end
  return v
end

local box_outer_mesh_info = {"/dynamic/box_graphics.lua", 0}
local box_inner_mesh_info = {"/dynamic/box_graphics.lua", 1}

local w = constants.level_width
local h = constants.level_height
local margin = 50fx
pewpew.set_level_size(w, h)

local id = pewpew.new_customizable_entity(0fx, 0fx)
pewpew.customizable_entity_set_mesh(id, "/dynamic/level_graphics.lua", 0)

ship = pewpew.new_player_ship(w / 2fx, h / 2fx, 0)
local camera_distance = -15fx
pewpew.configure_player(0, {camera_distance = camera_distance, shield = 9999})

local time = 0
local mode_shoot = false
local mode_shoot_time = 0
local tutorial_finished = false
local completed_time = 0
local message_id
pewpew.configure_player(0, {shoot_joystick_color = 0, move_joystick_color = 0})

function level_tick()
  time = time + 1

  if time > 40 and time < 105 then
       if time % 10 < 5 then
           pewpew.configure_player(0, {move_joystick_color = 0xff000080})
       else
           pewpew.configure_player(0, {move_joystick_color = 0})
       end
   end

   if time > 100 and time < 130 then
       camera_distance = camera_distance + 1fx
       pewpew.configure_player(0, {camera_distance = camera_distance})
   end

   if time == 120 then
       local positions = {{margin, margin}, {w - margin, margin}, {margin, h - margin}, {w - margin, h - margin}}
       box_caught = 0
       for i = 1, 4 do
           local x = positions[i][1]
           local y = positions[i][2]
           local box = boxes.new(x, y, box_outer_mesh_info, box_inner_mesh_info,
             function()
               box_caught = box_caught + 1
               if box_caught == 4 then
                 local final_box = boxes.new(w / 2fx, h / 2fx, box_outer_mesh_info, box_inner_mesh_info,
                   function()
                     mode_shoot = true
                     mode_shoot_time = 0
                     local cage = pewpew.new_customizable_entity(w / 2fx, h / 2fx)
                     pewpew.customizable_entity_set_mesh(cage, "/dynamic/cage_graphics.lua", 0)
                     pewpew.configure_player_ship_weapon(ship, {frequency = 4, cannon = pewpew.CannonType.DOUBLE})
                     local up_angle = fmath.tau() * fmath.from_fraction(1, 4)
                     local down_angle = fmath.tau() * fmath.from_fraction(3, 4)
                     local left_angle = fmath.tau() * fmath.from_fraction(1, 2)
                     for x = margin, w - margin, 100fx do
                       pewpew.new_baf(x, h - margin, 0fx, 10fx, -1)
                       pewpew.new_baf(x, margin, left_angle, 10fx, -1)
                     end
                     for y = margin, h - margin, 100fx do
                       pewpew.new_baf(margin, y, down_angle, 10fx, -1)
                       pewpew.new_baf(w - margin, y, up_angle, 10fx, -1)
                     end
                   end)
                   pewpew.add_arrow_to_player_ship(ship, final_box.handle, 0x00ff00ff)
                 end
             end
           )
           pewpew.add_arrow_to_player_ship(ship, box.handle, 0x00ff00ff)
       end
   end

   if mode_shoot == true or tutorial_finished == true then
       mode_shoot_time = mode_shoot_time + 1
       if mode_shoot_time > 10 and mode_shoot_time < 85 then
           if time % 10 < 5 then
               pewpew.configure_player(0, {shoot_joystick_color = 0xff000080})
           else
               pewpew.configure_player(0, {shoot_joystick_color = 0})
           end
       end
       local x,y = pewpew.entity_get_position(ship)
       x = clamp(x, (w / 2fx) - 20fx, (w / 2fx) + 20fx)
       y = clamp(y, (h / 2fx) - 20fx, (h / 2fx) + 20fx)
       pewpew.entity_set_position(ship, x, y)
       local index = 1
       if pewpew.get_entity_count(pewpew.EntityType.BAF) == 0 then
           mode_shoot = false
           tutorial_finished = true
           message_id = pewpew.new_customizable_entity(w / 2fx, h / 4fx)
           pewpew.customizable_entity_set_string(message_id, "Tutorial: #00000000Completed.")
       end
   end
   if tutorial_finished == true then
       completed_time = completed_time + 1
       if completed_time == 30 then
           pewpew.customizable_entity_set_string(message_id, "Tutorial: #00ff00ffCompleted.")
       end
       if completed_time > 25 then
           camera_distance = camera_distance + 5fx
           pewpew.configure_player(0, {camera_distance = camera_distance})
       end
       if completed_time > 150 then
           pewpew.stop_game()
       end
   end
end

pewpew.add_update_callback(level_tick)
