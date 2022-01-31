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

-- α -> ά
local function add_acute_accent(mesh, extra, position)
  return add_lines(mesh, extra, {position, {position[1] + 5, position[2] + 5}}, {{0, 1}})
end

local mesh_alpha = {
  vertexes = {{0,10}, {3, 13}, {10,13}, {13,10}, {13,3}, {10,0}, {3,0}, {0,3}, {16,-1},{16,14}},
  segments = {{0,1,2,3,4,5,6,7,0},{4,8},{3,9}},
  extra = 'α'
}

local mesh_epsilon = {
  vertexes = {{12,11}, {9,13}, {3, 13}, {0,10}, {2,6.5}, {0,3}, {3,0}, {9,0}, {12,2}, {5,6.5}},
  segments = {{0,1,2,3,4,5,6,7,8},{4,9}},
  extra = 'ε'
}

local mesh_eta = {
  vertexes = {{0,14},{0,0}, {0,4},{1,7},{3,10},{5,13},{10,13},{13,10},{13,-6},{14,-7}},
  segments = {{0,1},{2,3,4,5,6,7,8,9}},
  extra = 'η'
}

local mesh_omega = {
  vertexes = {{0,10}, {2,0}, {11,0}, {13,10}, {6.5,6.5}, {6.5, 2}, {4.5,0},{8.5,0}, {0,2}, {13,2}, {3,13},  {10,13}},
  segments = {{10,0,8,1,6,5,7,2,9,3,11},{4,5}},
  extra = 'ω'
}

local mesh_omicron = {
  vertexes = {{0,10}, {3, 13}, {10,13}, {13,10}, {13,3}, {10,0}, {3,0}, {0,3}},
  segments = {{0,1,2,3,4,5,6,7,0}},
  extra = 'ο'
}

local mesh_iota = {
  vertexes = {{0,13},{0,2},{3,0}},
  segments = {{0,1,2}},
  extra = 'ι'
}

local mesh_upsilon = {
  vertexes = {{0,13},{0,3},{3,0},{10,0},{13,3},{13,13}},
  segments = {{0,1,2,3,4,5}},
  extra = 'υ'
}

return {
  mesh_alpha,
  add_acute_accent(mesh_alpha, 'ά', {6,17}),
  {
    vertexes = {{-1,-10},{0,-7},{0,16},{3,20},{7,20},{10,17},{10,14},{8,11},{11,8},{11,4},{8,1},{5,1},{2,4}},
    segments = {{0,1,2,3,4,5,6,7,8,9,10,11,12}},
    extra = 'β'
  },
  {
    vertexes = {{13,13}, {6.5,2}, {6.5,-7}, {0,13}},
    segments = {{0,1,3},{1,2}},
    extra = 'γ'
  },
  {
    vertexes = {{0,10}, {3, 13}, {10,13}, {13,10}, {13,3}, {10,0}, {3,0}, {0,3},  {0,24}, {13,24}},
    segments = {{0,1,2,3,4,5,6,7,0},{3,8},{8,9}},
    extra = 'δ'
  },
  mesh_epsilon,
  add_acute_accent(mesh_epsilon, 'έ', {5,16}),
  {
    vertexes = {{2,24}, {13,24},{11,22},{6,13},{6,11.5},{6,8.5},{6,7},{7.5,5},{9.5,4},{11,3.5},{13,3},{13,0}},
    segments = {{0,1,2,3,4,5,6,7,8,9,10,11}},
    extra = 'ζ'
  },
  mesh_eta,
  add_acute_accent(mesh_eta, 'ή', {5,16}),
  {
    vertexes = {{0,16}, {3, 20}, {9,20}, {12,16}, {12,4}, {9,0}, {3,0}, {0,4},  {0,10},{12,10}},
    segments = {{0,1,2,3,4,5,6,7,0},{8,9}},
    extra = 'θ' -- lower case Theta
  },
  mesh_iota,
  add_acute_accent(mesh_iota, 'ί', {0,16}),
  {
    vertexes = {{0,13},{0,0}, {0,6.5},{6.5,6.5}, {13,13},{13,0}},
    segments = {{0,1},{2,3},{3,4},{3,5}},
    extra = 'κ'
  },
  {
    vertexes = {{0,18},{3,20},{7,20},{10,18},{13,-1},  {11,10.5},{7,9.5},{4,7},{2,-1}},
    segments = {{0,1,2,3,4},{5,6,7,8}},
    extra = 'λ'
  },
  {
    vertexes = {{0,13},{0,-8}, {0,4},{4,0},{9,0},{13,3,},{13,13},{15,-1}},
    segments = {{0,1},{0,2,3,4,5,6},{5,7}},
    extra = 'μ'
  },
  {
    vertexes = {{6.5,0}, {0,13},{13,13}},
    segments = {{0,1},{0,2}},
    extra = 'ν'
  },
  {
    vertexes = {{0,20},{14,20},{6,20},{4,17},{4,13},{6,10},{11,10}, {4,8},{4,2},{6,0},{11,0},  {13,-2},{13,-4},{9,-6}},
    segments = {{0,1},{2,3,4,5,6},{5,7,8,9,10,11,12,13}},
    extra = 'ξ'
  },
  mesh_omicron,
  add_acute_accent(mesh_omicron, 'ό', {5,16}),
  {
    vertexes = {{1,0},{1,13},{12,13},{12,2}, {-1,13}, {14,13}, {14,0}},
    segments = {{0,1,2,3},{1,4},{2,5},{3,6}},
    extra = 'π'
  },
  {
    vertexes = {{0,10}, {3, 13}, {10,13}, {13,10}, {13,3}, {10,0}, {3,0}, {0,3},  {0,-8}},
    segments = {{0,1,2,3,4,5,6,7,0}, {7,8}},
    extra = 'ρ'
  },
  {
    vertexes = {{0,10}, {3, 13}, {10,13}, {13,10}, {13,3}, {10,0}, {3,0}, {0,3}, {15,13}},
    segments = {{0,1,2,3,4,5,6,7,0},{2,8}},
    extra = 'σ'
  },
  {
    vertexes = {{13,10},{10,13},{3,13},{0,10},{0,3},{3,0},{10,0},{12,-2},{12,-4},{10,-6}},
    segments = {{0,1,2,3,4,5,6,7,8,9}},
    extra = 'ς'
  },
  {
    vertexes = {{0,13},{13,13}, {5,13},{5,3},{7,0},{13,0}},
    segments = {{0,1},{2,3,4,5}},
    extra = 'τ'
  },

  mesh_upsilon,
  add_acute_accent(mesh_upsilon, 'ύ', {6,16}),
  {
    vertexes = {{3,13},{0,10},{0,3},{3,0},{10,0},{13,3},{13,10},{10,13},{6.5,10},{6.5,-8}}, --{{0,10}, {3, 13}, {10,13}, {13,10}, {13,3}, {10,0}, {3,0}, {0,3}},
    segments = {{0,1,2,3,4,5,6,7,8,9}},
    extra = 'φ'
  },
  {
    vertexes = {{0,13}, {13,-7}, {0,-7}, {13,13}},
    segments = {{0,1}, {2,3}},
    extra = 'χ'
  },
  {
    vertexes = {{0,10},{0,3},{3,0},{10,0},{13,3},{13,10}, {6.5,-8}, {6.5,13}},
    segments = {{0,1,2,3,4,5},{6,7}},
    extra = 'ψ'
  },
  mesh_omega,
  add_acute_accent(mesh_omega, 'ώ', {6,16}),
  {
    vertexes = {{2,0},{2,19},{15,19},{0,0},{4,0},{0,19},{15,17}},
    segments = {{0,1,2,6},{3,4},{1,5}},
    extra = 'Γ'
  },
  {
    vertexes = {{2,0},{17,0},{9,19}},
    segments = {{0,1,2,0}},
    extra = 'Δ'
  },
  {
    vertexes = {{2,0},{17,0},{9,19}--[[dashes]],{0,0},{4,0},{19,0},{15,0},{5,19}},
    segments = {{0,2,1},{3,4},{5,6}},
    extra = 'Λ'
  },
  {
    vertexes = {{17,0},{0,0},{9,9.5},{0,19},{17,19},--[[dashes]]{17,17},{17,2}},
    segments = {{6,0,1,2,3,4,5}},
    extra = 'Σ'
  },
  {
    vertexes = {{9.5,-2},{9.5,21},  {6,3},{2,6},{2,13},{6,16},{13,16},{17,13},{17,6},{13,3}, {}},
    segments = {{0,1},{2,3,4,5,6,7,8,9,2}},
    extra = 'Φ'
  },
  {
    vertexes = {{9.5,0},{9.5,6},{2,19},{9.5,19},{17,19},{2,10},{9.5,10},{17,10},--[[dashes]]{12,0},{7,0},{12,19},{7,19},{0,19},{4,19},{15,19},{19,19}},
    segments = {{0,3},{2,5,1},{3,6,1},{4,7,1},{8,9},{10,11},{12,13},{14,15}},
    extra = 'Ψ'
  },
  {
    vertexes = {{2,0},{2,19},{17,19},{17,0},--[[dashes]]{0,19},{19,19},{0,0},{19,0},{4,0},{15,0}},
    segments = {{0,1,2,3},{4,5},{8,6},{9,7}},
    extra = 'Π'
  },
  {
    vertexes = {{4,19},{13,19},{17,15},{17,4},{13,0},{4,0},{0,4},{0,15}, {2,9.5},{15,9.5}},
    segments = {{0,1,2,3,4,5,6,7,0}, {8,9}},
    extra = 'ϴ' -- upper case Theta
  },
  {
    vertexes = {{2,0},{17,0},{2,19},{17,19},{4,9.5},{14,9.5},{2,2},{17,2},{2,17},{17,17}},
    segments = {{6,0,1,7},{8,2,3,9},{4,5}},
    extra = 'Ξ'
  },
  {
    vertexes = {{0,0},{6,0},{6,4},{3,4},{0,7},{0,16},{3,19},{16,19},{19,16},{19,7},{16,4},{13,4},{13,0},{19,0}},
    segments = {{0,1,2,3,4,5,6,7,8,9,10,11,12,13}},
    extra = 'Ω'
  }
}
