local mjm = mjrequire "common/mjm"
local vec3 = mjm.vec3
local mix = mjm.mix


local mod = {
    loadOrder = 1,
}

function mod:onload(material)
    
    -- Arsenic ore: dark teal-gray; distinct from tin/copper
    local arsenicOreColor = vec3(0.16, 0.28, 0.26) * 1.1 + vec3(0.05, 0.05, 0.05)
    mj:insertIndexed(material.types, material.mat("arsenicOre", arsenicOreColor, 0.9))
    material.types.arsenicOre.metal = 0.0
    
    -- Terrain arsenic ore: blended with rock for terrain nodes
    local rockColor = vec3(0.5, 0.5, 0.5)
    local terrainArsenicOreColor = mix(vec3(0.20, 0.30, 0.28), rockColor, 0.7)
    mj:insertIndexed(material.types, material.mat("terrain_arsenicOre", terrainArsenicOreColor, 1.0))

    -- Arsenic bronze metal: tarnished greenish-bronze, darker and more saturated than regular bronze
    local arsenicBronzeColor = vec3(0.25, 0.32, 0.18)
    mj:insertIndexed(material.types, material.mat("arsenicBronze", arsenicBronzeColor, 0.10, 1.0))

    mj:log ("Arsenic Bronze: Material types (arsenicOre/terrain_arsenicOre/arsenicBronze) registered.")
end

return mod