local function shallow_copy(original)
	local copy = {}
	for key, value in pairs(original) do
		copy[key] = value
	end
	return copy
end

local function add_lines(mesh, extra, vertexes, segments)
  local new_mesh = {}
  new_mesh.vertexes = shallow_copy(mesh.vertexes)
  new_mesh.segments = shallow_copy(mesh.segments)
  new_mesh.extra = extra
  local vertex_count = #new_mesh.vertexes
  for i=1,#vertexes do
    table.insert(new_mesh.vertexes, vertexes[i])
  end
  for i=1,#segments do
    for j=1,#segments[i] do
      segments[i][j] = segments[i][j] + vertex_count
    end
    table.insert(new_mesh.segments, segments[i])
  end
  return new_mesh
end

-- A -> Ą
local function add_ogonek(mesh, extra, position)
  return add_lines(mesh, extra, {position, {position[1] - 3, position[2] - 3}, {position[1], position[2] - 6}}, {{0, 1, 2}})
end

-- a -> à
local function add_grave_accent(mesh, extra, position)
  return add_lines(mesh, extra, {{position[1] + 5, position[2]}, {position[1], position[2] + 5}}, {{0, 1}})
end

-- e -> é
local function add_acute_accent(mesh, extra, position)
  return add_lines(mesh, extra, {position, {position[1] + 5, position[2] + 5}}, {{0, 1}})
end

-- Z -> Ż
local function add_overdot(mesh, extra, position)
  return add_lines(mesh, extra, {position, {position[1], position[2] + 3}}, {{0, 1}})
end

-- Z -> Ž
local function add_caron(mesh, extra, position)
  return add_lines(mesh, extra, {{position[1] - 4, position[2] + 3}, position, {position[1] + 4, position[2] + 3}}, {{0, 1, 2}})
end

-- a -> ä
local function add_trema(mesh, extra, position)
  return add_lines(mesh, extra, {{position[1] - 3, position[2]}, {position[1] - 3, position[2] + 3}, {position[1] + 3, position[2]}, {position[1] + 3, position[2] + 3}}, {{0, 1}, {2, 3}})
end

-- n -> ñ
local function add_tilde(mesh, extra, position)
  -- {0,0}, {4,4}, {7,1}, {11,5}
  return add_lines(mesh, extra, {{position[1], position[2]}, {position[1] + 4, position[2] + 4}, {position[1] + 7, position[2] + 1}, {position[1] + 11, position[2] + 5}}, {{0, 1, 2, 3}})
end

-- e -> ê
local function add_circumflex(mesh, extra, position)
  return add_lines(mesh, extra, {{position[1], position[2]}, {position[1] + 4, position[2] + 4}, {position[1] + 8, position[2] + 0}}, {{0, 1, 2}})
end

-- u -> ū
local function add_macron(mesh, extra, position)
  return add_lines(mesh, extra, {{position[1], position[2]}, {position[1] + 8, position[2]}}, {{0, 1}})
end

-- c -> ç
local function add_cedilla(mesh, extra, position)
  return add_lines(mesh, extra, {{position[1], position[2]}, {position[1], position[2] - 4}, {position[1] - 5, position[2] - 4}}, {{0, 1, 2}})
end

-- s -> ș
local function add_comma(mesh, extra, position)
  return add_lines(mesh, extra, {{position[1], position[2]}, {position[1] - 3, position[2] - 5}}, {{0, 1}})
end

-- a -> ă
local function add_breve(mesh, extra, position)
  return add_lines(mesh, extra, {{position[1] - 4, position[2] + 3}, {position[1] - 2, position[2]}, {position[1] + 2, position[2]}, {position[1] + 4, position[2] + 3}}, {{0, 1, 2, 3}})
end

local mesh_A = {
  vertexes = {{0,-1}, {0,14}, {5,19}, {16,19}, {16,-1}, {0,10}, {16,10}},
  segments = {{0,1,2,3,4}, {5,6}},
  extra = 'AАΑ' -- 2nd 'A' is cyrillic. 3rd 'A' is greek
}

local mesh_C = {
  vertexes = {{15,0}, {6,0}, {0,6}, {0,13}, {6,19}, {15,19}},
  segments = {{0,1,2,3,4,5}},
  extra = 'CС'
}

local mesh_E = {
  vertexes = {{15,0}, {0,0}, {0,19}, {15,19}, {1,10}, {7,10}},
  segments = {{0,1,2,3}, {4,5}},
  extra = 'EЕΕ' -- 2nd 'E' is cyrillic. 3rd 'E' is greek
}

local mesh_G = {
  vertexes = {{10,10}, {16,10}, {16,0}, {5,0}, {0,10}, {5,19}, {16,19}},
  segments = {{0,1,2,3,4,5,6}},
  extra = 'G'
}

local mesh_H = {
  vertexes = {{0,-1}, {0,20}, {0,10}, {15,10}, {15,-1}, {15,20}},
  segments = {{0,1}, {2,3}, {4,5}},
  extra = 'HНΗ' -- 2nd 'H' is cyrillic. 3rd 'H' is greek.
}

local mesh_I = {
  vertexes = {{3,-1}, {3,20}},
  segments = {{0,1}},
  extra = 'IІΙ' -- 2nd 'I' is cyrillic. 3rd 'I' is greek.
}

local mesh_L = {
  vertexes = {{0,20}, {0,0}, {13,0}},
  segments = {{0,1,2}},
  extra = 'L'
}

local mesh_N = {
  vertexes = {{0,-1}, {0,19}, {1,19}, {14,0}, {15,0}, {15,19}},
  segments = {{0,1,2,3,4,5}},
  extra = 'NΝ' -- 2nd 'N' is greek.
}

local mesh_O = {
  vertexes = {{5,19}, {14,19}, {19,10}, {14,0}, {5,0}, {0,10}},
  segments = {{0,1,2,3,4,5,0}},
  extra = 'OОΟ' -- 2nd 'O' is cyrillic. 3rd 'O' is greek.
}

local mesh_S = {
  vertexes = {{0,0}, {10,0}, {15,5}, {15,10}, {0,10}, {0,14}, {5,19}, {15,19}},
  segments = {{0,1,2,3,4,5,6,7}},
  extra = 'S'
}

local mesh_U = {
  vertexes = {{0,20}, {0,4}, {4,0}, {15,0}, {15,20}},
  segments = {{0,1,2,3,4}},
  extra = 'U'
}

local mesh_Z = {
  vertexes = {{0,19}, {15,19}, {0,0}, {15,0}},
  segments = {{0,1,2,3}},
  extra = 'ZΖ' -- 2nd 'Z' is greek
}

local mesh_c = {
  vertexes = {{12,0}, {0,0}, {0,13}, {12,13}},
  segments = {{0,1,2,3}},
  extra = 'cс'
}

local mesh_a = {
  vertexes = {{0,13}, {12,13}, {12,0}, {0,0}, {0,7}, {12,7}},
  segments = {{0,1,2,3,4,5}},
  extra = 'aа'
}

local mesh_e = {
  vertexes = {{13,0}, {0,0}, {0,13}, {12,13}, {12,7}, {0.5,7}},
  segments = {{0,1,2,3,4,5}},
  extra = 'eе'
}

local mesh_g = {
  vertexes = {{0,-5}, {12,-5}, {12,13}, {0,13}, {0,0}, {12,0}},
  segments = {{0,1,2,3,4,5}},
  extra = 'g'
}

local mesh_i = {
  vertexes = {{0,-1}, {0,14}, {0,16}, {0,18}},
  segments = {{0,1}, {2,3}},
  extra = 'iі'
}

local mesh_i_without_dot = {
  vertexes = {{0,-1}, {0,14}},
  segments = {{0,1}},
  extra = 'ı'
}

local mesh_l = {
  vertexes = {{0,19}, {0,0}, {4,0}},
  segments = {{0,1,2}},
  extra = 'l'
}

local mesh_n = {
  vertexes = {{0,-1}, {0,13}, {0,9}, {11,13}, {12,13}, {12,-1}},
  segments = {{0,1}, {2,3,4,5}},
  extra = 'n'
}

local mesh_o = {
  vertexes = {{0,13}, {12,13}, {12,0}, {0,0}},
  segments = {{0,1,2,3,0}},
  extra = 'oо'
}

local mesh_s = {
  vertexes = {{12,13}, {0,13}, {0,7}, {12,7}, {12,0}, {-1,0}},
  segments = {{0,1,2,3,4,5}},
  extra = 's'
}

local mesh_t = {
  vertexes = {{0,19}, {0,-1}, {0,14}, {4,14}},
  segments = {{0,1}, {2,3}},
  extra = 't'
}

local mesh_u = {
  vertexes = {{0,14}, {0,0}, {12,0}, {12,14}},
  segments = {{0,1,2,3}},
  extra = 'u'
}

local mesh_z = {
  vertexes = {{0,13}, {12,13}, {0,0}, {12,0}},
  segments = {{0,1,2,3}},
  extra = 'z'
}

return {
mesh_A,
add_grave_accent(mesh_A, 'À', {7,21}),
add_acute_accent(mesh_A, 'Á', {10,21}),
add_acute_accent(mesh_A, 'Ά', {-1,18}),
add_ogonek(mesh_A, 'Ą', {16,0}),
add_trema(mesh_A, 'Ä', {11,22}),
add_tilde(mesh_A, 'Ã', {5,22}),
{
  vertexes = {{0,0}, {0,19}, {11,19}, {16,14}, {16,0}, {16,10}, {0,10}},
  segments = {{0,1,2,3,4,0}, {5,6}},
  extra = 'BВΒ' -- 2nd 'B' is cyrillic. 3rd 'B' is greek.
},
mesh_C,
add_acute_accent(mesh_C, 'Ć', {10,21}),
add_caron(mesh_C, 'Č', {9,23}),
add_cedilla(mesh_C, 'Ç', {10, -1}),
{
  vertexes = {{0,0}, {0,19}, {9,19}, {15,13}, {15,6}, {9,0}},
  segments = {{0,1,2,3,4,5,0}},
  extra = 'D'
},
{
  vertexes = {{0,0}, {0,19}, {9,19}, {15,13}, {15,6}, {9,0}, {0,10}, {7,10}},
  segments = {{0,1,2,3,4,5,0}, {6,7}},
  extra = 'Đ'
},
mesh_E,
add_acute_accent(mesh_E, 'É', {6,21}),
add_circumflex(mesh_E, 'Ê', {4,21}),
add_grave_accent(mesh_E, 'È', {4,21}),
add_ogonek(mesh_E, 'Ę', {14,0}),
add_acute_accent(mesh_E, 'Έ', {-7,18}),
{
  vertexes = {{0,-1}, {0,19}, {15,19}, {1,10}, {7,10}},
  segments = {{0,1,2}, {3,4}},
  extra = 'F'
},
mesh_G,
add_caron(mesh_G, 'Ğ', {10,22}),
mesh_H,
add_acute_accent(mesh_H, 'Ή', {-7,18}),
mesh_I,
add_acute_accent(mesh_I, 'Í', {2,22}),
add_ogonek(mesh_I, 'Į', {3,0}),
add_circumflex(mesh_I, 'Î', {-1,22}),
{
  vertexes = {{3,-1}, {3,20},  {3,22}, {3,24}},
  segments = {{0,1},{2,3}},
  extra = 'İ'
},
{
  vertexes = {{14,20}, {14,0}, {0,0}},
  segments = {{0,1,2}},
  extra = 'J'
},
{
  vertexes = {{0,20}, {0,-1}, {0,10}, {10,10}, {15,20}, {15,19}, {15,0},{15,-1}},
  segments = {{0,1}, {2,3}, {4,5,3,6,7}},
  extra = 'KКΚ' -- 2nd 'K' is cyrillic. 3rd 'K' is greek.
},
mesh_L,
add_lines(mesh_L, 'Ł', {{-3,8},{6,14}}, {{0, 1}}),
{
  vertexes = {{0,-1}, {0,19},{1,19},{8,11}, {15,19},{16,19}, {16,-1}},
  segments = {{0,1,2,3,4,5,6}},
  extra = 'MМΜ' -- 2nd 'M' is cyrillic. 3rd 'M' is greek.
},
mesh_N,
add_acute_accent(mesh_N, 'Ń', {8,22}),
mesh_O,
add_acute_accent(mesh_O, 'Ó', {8,22}),
add_acute_accent(mesh_O, 'Ό', {-2,18}),
add_trema(mesh_O, 'Ö', {9,22}),
{
  vertexes = {{0,-1}, {0,19}, {10,19}, {16,13}, {11,7}, {0,7}},
  segments = {{0,1,2,3,4,5}},
  extra = 'PРΡ' -- 2nd 'P' is cyrillic. 3rd 'P' is greek.
},
{
  vertexes = {{5,19}, {14,19}, {19,10}, {12,0}, {5,0}, {0,10}, {11,8}, {19,0}},
  segments = {{0,1,2,3,4,5,0}, {6,7}},
  extra = 'Q'
},
{
  vertexes = {{0,-1}, {0,19}, {10,19}, {16,13}, {11,7}, {0,7}, {16,0},{16,-1}},
  segments = {{0,1,2,3,4,5}, {4,6,7}},
  extra = 'R'
},
mesh_S,
add_acute_accent(mesh_S, 'Ś', {8,22}),
add_caron(mesh_S, 'Š', {8,22}),
add_cedilla(mesh_S, 'Ş', {8, -1}),
add_comma(mesh_S, 'Ș', {6, -1}),
{
  vertexes = {{0,19}, {15,19}, {7,-1}, {7,19}},
  segments = {{0,1}, {2,3}},
  extra = 'TТΤ' -- 2nd 'T' is cyrillic. 3rd 'T' is greek.
},
mesh_U,
add_trema(mesh_U, 'Ü', {8, 22}),
add_acute_accent(mesh_U, 'Ú', {7,22}),
add_macron(mesh_U, 'Ū', {4, 22}),
{
  vertexes = {{0,20}, {0,19}, {8,0}, {9,0}, {18,19}, {18, 20}},
  segments = {{0,1,2,3,4,5}},
  extra = 'V'
},
{
  vertexes = {{0,20}, {0,19}, {5,0}, {6,0}, {10,14}, {11,14}, {15,0}, {16,0}, {21,19}, {21,20}},
  segments = {{0,1,2,3,4,5,6,7,8,9}},
  extra = 'W'
},
{
  vertexes = {{0,20}, {0,19}, {17,0}, {17,-1}, {17,20}, {17,19}, {0,0}, {0,-1}},
  segments = {{0,1,2,3}, {4,5,6,7}},
  extra = 'XХΧ' -- 2nd 'X' is cyrillic. 3rd 'X' is greek
},
{
  vertexes = {{0,20}, {0,19}, {9,10}, {18,19}, {18,20}, {9,-1}, {9,10}, },
  segments = {{0,1,2,3,4}, {5,6}},
  extra = 'YΥ' -- 2nd 'Y' is greek.
},
mesh_Z,
add_overdot(mesh_Z, 'Ż', {9,23}),
add_caron(mesh_Z, 'Ž', {9,23}),
add_acute_accent(mesh_Z, 'Ź', {6,23}),
mesh_a,
add_ogonek(mesh_a, 'ą', {12,0}),
add_grave_accent(mesh_a, 'à', {5, 16}),
add_acute_accent(mesh_a, 'á', {5, 16}),
add_circumflex(mesh_a, 'â', {1, 16}),
add_trema(mesh_a, 'ä', {7, 16}),
add_tilde(mesh_a, 'ã', {1, 16}),
add_breve(mesh_a, 'ă', {7, 18}),
{
  vertexes = {{0,19}, {0,0}, {12,0}, {12,13}, {0,13}},
  segments = {{0,1,2,3,4}},
  extra = 'b'
},
mesh_c,
add_acute_accent(mesh_c, 'ć', {5,16}),
add_caron(mesh_c, 'č', {5,16}),
add_cedilla(mesh_c, 'ç', {7, -1}),
{
  vertexes = {{12,19}, {12,0}, {0,0}, {0,13}, {12,13}},
  segments = {{0,1,2,3,4}},
  extra = 'd'
},
{
  vertexes = {{12,24}, {12,0}, {0,0}, {0,13}, {12,13}, {8,20}, {16,20}},
  segments = {{0,1,2,3,4}, {5,6}},
  extra = 'đ'
},
mesh_e,
add_ogonek(mesh_e, 'ę', {12,0}),
add_acute_accent(mesh_e, 'é', {4,16}),
add_grave_accent(mesh_e, 'è', {4,16}),
add_circumflex(mesh_e, 'ê', {2, 16}),
add_trema(mesh_e, 'ë', {6, 16}),
add_overdot(mesh_e, 'ė', {6, 17}),
{
  vertexes = {{0,-1}, {0,19}, {7,19}, {0,13}, {4,13}},
  segments = {{0,1,2}, {3,4}},
  extra = 'f'
},
mesh_g,
add_caron(mesh_g, 'ğ', {6,16}),
{
  vertexes = {{0,-1}, {0,19}, {0,13}, {11,13}, {11,-1}},
  segments = {{0,1}, {2,3,4}},
  extra = 'h'
},
mesh_i,
add_acute_accent(mesh_i, 'í', {-1,16}),
add_grave_accent(mesh_i, 'ì', {-4,16}),
add_ogonek(mesh_i, 'į', {0,0}),
mesh_i_without_dot,
add_circumflex(mesh_i_without_dot, 'î', {-4, 16}),
add_trema(mesh_i_without_dot, 'ї', {0, 16}), -- This is not the regular latin 'i'
{
  vertexes = {{0,-5}, {7,-5}, {7,14}, {7,17}, {7,19}},
  segments = {{0,1,2}, {3,4}},
  extra = 'j'
},
{
  vertexes = {{0,19}, {0,-1}, {0,6}, {11,0}, {11,13}},
  segments = {{0,1}, {2,3}, {2,4}},
  extra = 'k'
},
mesh_l,
add_lines(mesh_l, 'ł', {{-3,7},{4,13}}, {{0, 1}}),
{
  vertexes = {{0,-1}, {0,13}, {0,9}, {6,13}, {8,13}, {8,-1}, {8,9}, {14,13}, {16,13}, {16,-1}},
  segments = {{0,1}, {2,3,4,5}, {6,7,8,9}},
  extra = 'm'
},
mesh_n,
add_acute_accent(mesh_n, 'ń', {6,14}),
add_tilde(mesh_n, 'ñ', {1, 16}),
mesh_o,
add_acute_accent(mesh_o, 'ó', {4,16}),
add_circumflex(mesh_o, 'ô', {2, 16}),
add_trema(mesh_o, 'ö', {6, 16}),
add_tilde(mesh_o, 'õ', {1, 16}),
{
  vertexes = {{0,-6}, {0,13}, {12,13}, {12,0}, {0,0}},
  segments = {{0,1,2,3,4}},
  extra = 'pр'
},
{
  vertexes = {{12,-6}, {12,13}, {0,13}, {0,0}, {12,0}},
  segments = {{0,1,2,3,4}},
  extra = 'q'
},
{
  vertexes = {{0,-1}, {0,13}, {0,9}, {4,13}, {12,13}},
  segments = {{0,1}, {2,3,4}},
  extra = 'r'
},
mesh_s,
add_acute_accent(mesh_s, 'ś', {5,16}),
add_caron(mesh_s, 'š', {5,16}),
add_cedilla(mesh_s, 'ş', {7, -1}),
add_comma(mesh_s, 'ș', {7, -2}),
mesh_t,
add_comma(mesh_t, 'ț', {1, -2}),
mesh_u,
add_ogonek(mesh_u, 'ų', {12,0}),
add_acute_accent(mesh_u, 'ú', {4,16}),
add_circumflex(mesh_u, 'û', {2,16}),
add_grave_accent(mesh_u, 'ù', {4,16}),
add_trema(mesh_u, 'ü', {6, 16}),
add_macron(mesh_u, 'ū', {2, 18}),
{
  vertexes = {{0,14}, {0,13}, {5,0}, {6,0}, {11,13},{11,14}},
  segments = {{0,1,2,3,4,5}},
  extra = 'v'
},
{
  vertexes = {{0,14}, {0,12}, {3,0}, {4,0}, {7,13}, {8,13}, {11,0}, {12,0}, {15,13}, {15,14}},
  segments = {{0,1,2,3,4,5,6,7,8,9}},
  extra = 'w'
},
{
  vertexes = {{0,13}, {12,0}, {0,0}, {12,13}},
  segments = {{0,1}, {2,3}},
  extra = 'xх'
},
{
  vertexes = {{0,14}, {0,2}, {12,2}, {12,14}, {12,-5}, {0,-5}},
  segments = {{0,1,2}, {3,4,5}},
  extra = 'yу'
},
mesh_z,
add_overdot(mesh_z, 'ż', {7,17}),
add_caron(mesh_z, 'ž', {7,17}),
add_acute_accent(mesh_z, 'ź', {5,17}),
{
  vertexes = {{0,-2},{0,16},{3,20},{9,20},{11,17},{11,16},{8,12},{8,11},{12,8},{12,2},{9,-1},{6,-1}},
  segments = {{0,1,2,3,4,5,6,7,8,9,10,11}},
  extra = 'ß'
},
}