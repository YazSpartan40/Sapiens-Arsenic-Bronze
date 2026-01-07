-- SilverMod: biome no-op (matches vanilla; no weights injected)
local mod = { loadOrder = 1 }

function mod:onload(biome)
	return biome
end

return mod
