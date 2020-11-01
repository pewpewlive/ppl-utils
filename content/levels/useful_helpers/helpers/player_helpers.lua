local helper = {}

-- center is a pair of fixed point values.
-- |i| is an integer in the range [0, number_of_players -1]
function helper.get_spawn_position(center, i)
  local horizontal_offset = (-(pewpew.get_number_of_players() - 1) * 30) / 2 + (i * 30)
  return {center[1] + fmath.to_fixedpoint(horizontal_offset), center[2]}
end

helper.player_ships = {}

-- the helper.player_ships variable needs to be containing the handles to all the ships
function helper.add_arrow(target_id, color)
  for i = 1, #helper.player_ships do
    local ship_id = helper.player_ships[i]
    if pewpew.entity_get_is_alive(ship_id) then
      pewpew.add_arrow_to_player_ship(ship_id, target_id, color)
    else
      helper.player_ships[i] = helper.player_ships[#player_ships]
      table.remove(helper.player_ships, #helper.player_ships)
    end
  end
end

function helper.new_player_ship(x, y, i)
  local ship = pewpew.new_player_ship(x, y, i)
  table.insert(helper.player_ships, ship)
  return ship
end

function helper.all_players_have_lost()
  for i = 0, pewpew.get_number_of_players() - 1 do
    if pewpew.get_player_configuration(i).has_lost == false then
        return false
    end
  end
  return true
end

function helper.number_of_dead_players()
  local n = 0
  for i = 0, pewpew.get_number_of_players() - 1 do
    if pewpew.get_player_configuration(i).has_lost == true then
        n = n + 1
    end
  end
  return n
end

function helper.number_of_players_alive()
  local n = 0
  for i = 0, pewpew.get_number_of_players() - 1 do
    if pewpew.get_player_configuration(i).has_lost == false then
      n = n + 1
    end
  end
  return n
end

function helper.all_player_shields()
  local total_shields = 0
  for i = 0, pewpew.get_number_of_players() - 1 do
    total_shields = total_shields + pewpew.get_player_configuration(i).shield
  end
  return total_shields
end

function helper.stop_level_if_players_lost()
  -- only check once every 8 tick
  if pewpew.get_time() % 8 ~= 0 then
    return
  end
  if helper.all_players_have_lost() then
    pewpew.stop_game()
  end
end

function helper.spawn_away_from_players(position_lambda)
  local best_length = -1fx
  local best_x = 0fx
  local best_y = 0fx
  for j = 1, 3 do
    local current_x, current_y = position_lambda()
    local current_length = 9999fx
    for i = 1, #helper.player_ships do
      local ship_id = helper.player_ships[i]
      if pewpew.entity_get_is_alive(ship_id) then
        local x, y = pewpew.entity_get_position(ship_id)
        local dx = current_x - x
        local dy = current_y - y
        if dx < 0fx then
          dx = -dx
        end
        if dy < 0fx then
          dy = -dy
        end
        local manhattan_length = dx + dy
        if manhattan_length < current_length then
            current_length = manhattan_length
        end
      else
        helper.player_ships[i] = helper.player_ships[#helper.player_ships]
        table.remove(helper.player_ships, #helper.player_ships)
      end
    end
    if current_length > best_length then
        if current_length > 150fx then
            return current_x, current_y
        end
        best_x = current_x
        best_y = current_y
        best_length = current_length
    end
  end
  return best_x, best_y
end

return helper
