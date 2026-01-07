-- SilverMod: Add silver ore terrain types following copper/tin patterns
local typeMaps = mjrequire "common/typeMaps"
local material = mjrequire "common/material"
local pathFinding = mjrequire "common/pathFinding"
local locale = mjrequire "common/locale"

local mod = { loadOrder = 1 }

local function createStandardOutputs(objectKeyName, countOrNil)
    local result = {}
    local count = countOrNil or 1
    for i = 1, count do
        table.insert(result, {
            objectKeyName = objectKeyName,
            allowsOutputWhenVertexHasBeenFilled = true,
        })
    end
    return result
end

function mod:onload(terrainTypes)
    mj:log("SilverMod: Registering silver ore terrain entries")

    local pathNodeDifficulties = pathFinding.pathNodeDifficulties

    -- Base terrain type (mirrors copper/tin fields)
    typeMaps:insert("terrainBase", terrainTypes.baseTypes, {
        key = "silverOre",
        name = locale:get("terrain_silverOre"),
        material = material.types.terrain_silverOre.index,
        digOutputs = createStandardOutputs("silverOre", 3),
        fillObjectTypeKey = "silverOre",
        pathDifficultyIndex = pathNodeDifficulties.dirtRock.index,
        requiresMining = true,
        -- allow worldgen to spawn silver (matching copper/tin behavior)
        disableSpawn = false,
    })

    -- Terrain variation entry
    typeMaps:insert("terrainVariations", terrainTypes.variations, {
        key = "silverOre",
        name = locale:get("terrainVariations_silverOre"),
    })

    mj:log("SilverMod: Silver ore terrain entries registered")
end

return mod

