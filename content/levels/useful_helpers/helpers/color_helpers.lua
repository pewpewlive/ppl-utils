local helper = {}

--- Returns a integer encoding a color.
-- @params r,g,b,a (integers in the [0,255] range): the red, green, blue, and alpha components of the color.
function helper.make_color(r, g, b, a)
  local color = r * 256 + g
  color = color * 256 + b
  color = color * 256 + a
  return color
end

-- Returns an integer encoding a color
-- @params color: an existing 32 bit color.
-- @params new_alpha: the alpha value of the new color.
function helper.make_color_with_alpha(color, new_alpha)
  local alpha = color % 256
  color = color - alpha + new_alpha
  return color
end

-- Returns the color as a string that can be used to colorize text.
function helper.color_to_string(color)
  local s = string.format("%x", color)
  while string.len(s) < 8 do
    s = "0" .. s
  end
  return "#" .. s
end

return helper

