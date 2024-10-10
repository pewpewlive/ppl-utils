meshes = {}

function AddCharacters(new_meshes)
  for _,v in ipairs(new_meshes) do
    table.insert(meshes, v)
  end
end

files = {"cyrillic.lua", "greek.lua", "japanese.lua", "latin.lua", "numbers.lua", "symbols.lua"}

for i=1,#files do
  AddCharacters(require("/dynamic/characters/" .. files[i]))
end
