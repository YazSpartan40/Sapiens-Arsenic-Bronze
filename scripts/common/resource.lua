local typeMaps = mjrequire "common/typeMaps"
local locale = mjrequire "common/locale"

local mod = {
    loadOrder = 1,
}
mj:log ("Arsenic Bronze: resource.lua loaded")
function mod:onload(resource)
    
    local gameObjectTypeIndexMap = typeMaps.types.gameObject

    -- Arsenic Ore
    typeMaps:insert("resource", resource.types, {
        key = "arsenicOre",
        name = locale:get("resource_arsenicOre"),
        plural = locale:get("resource_arsenicOre_plural"),
        displayGameObjectTypeIndex = gameObjectTypeIndexMap.arsenicOre,
        impactCausesMajorInjury = true,
        tradeBatchSize = 5,
        tradeValue = 10,
    })
    
    -- Arsenic Bronze Ingot
    typeMaps:insert("resource", resource.types, {
        key = "arsenicBronzeIngot",
        name = locale:get("resource_arsenicBronzeIngot"),
        plural = locale:get("resource_arsenicBronzeIngot_plural"),
        displayGameObjectTypeIndex = gameObjectTypeIndexMap.arsenicBronzeIngot,
        tradeBatchSize = 10,
        tradeValue = 30,
    })
    
    -- Arsenic Tool Heads (kiln production)
    typeMaps:insert("resource", resource.types, {
        key = "arsenicAxehead",
        name = locale:get("resource_arsenicAxehead"),
        plural = locale:get("resource_arsenicAxehead_plural"),
        displayGameObjectTypeIndex = gameObjectTypeIndexMap.arsenicAxehead,
        tradeBatchSize = 5,
        tradeValue = 30,
    })

    typeMaps:insert("resource", resource.types, {
        key = "arsenicKnife",
        name = locale:get("resource_arsenicKnife"),
        plural = locale:get("resource_arsenicKnife_plural"),
        displayGameObjectTypeIndex = gameObjectTypeIndexMap.arsenicKnife,
        tradeBatchSize = 5,
        tradeValue = 25,
    })

    typeMaps:insert("resource", resource.types, {
        key = "arsenicChisel",
        name = locale:get("resource_arsenicChisel"),
        plural = locale:get("resource_arsenicChisel_plural"),
        displayGameObjectTypeIndex = gameObjectTypeIndexMap.arsenicChisel,
        tradeBatchSize = 5,
        tradeValue = 25,
    })

    typeMaps:insert("resource", resource.types, {
        key = "arsenicSpearhead",
        name = locale:get("resource_arsenicSpearhead"),
        plural = locale:get("resource_arsenicSpearhead_plural"),
        displayGameObjectTypeIndex = gameObjectTypeIndexMap.arsenicSpearhead,
        tradeBatchSize = 5,
        tradeValue = 30,
    })

    typeMaps:insert("resource", resource.types, {
        key = "arsenicHammerhead",
        name = locale:get("resource_arsenicHammerhead"),
        plural = locale:get("resource_arsenicHammerhead_plural"),
        displayGameObjectTypeIndex = gameObjectTypeIndexMap.arsenicHammerhead,
        tradeBatchSize = 5,
        tradeValue = 30,
    })

    typeMaps:insert("resource", resource.types, {
        key = "arsenicPickaxehead",
        name = locale:get("resource_arsenicPickaxehead"),
        plural = locale:get("resource_arsenicPickaxehead_plural"),
        displayGameObjectTypeIndex = gameObjectTypeIndexMap.arsenicPickaxehead,
        tradeBatchSize = 5,
        tradeValue = 30,
    })

    -- Arsenic Tools (crafted from heads + branch)
    typeMaps:insert("resource", resource.types, {
        key = "arsenicAxe",
        name = locale:get("resource_arsenicAxe"),
        plural = locale:get("resource_arsenicAxe_plural"),
        displayGameObjectTypeIndex = gameObjectTypeIndexMap.arsenicAxe,
        tradeBatchSize = 5,
        tradeValue = 50,
    })

    typeMaps:insert("resource", resource.types, {
        key = "arsenicSpear",
        name = locale:get("resource_arsenicSpear"),
        plural = locale:get("resource_arsenicSpear_plural"),
        displayGameObjectTypeIndex = gameObjectTypeIndexMap.arsenicSpear,
        tradeBatchSize = 5,
        tradeValue = 50,
    })

    typeMaps:insert("resource", resource.types, {
        key = "arsenicHammer",
        name = locale:get("resource_arsenicHammer"),
        plural = locale:get("resource_arsenicHammer_plural"),
        displayGameObjectTypeIndex = gameObjectTypeIndexMap.arsenicHammer,
        tradeBatchSize = 5,
        tradeValue = 50,
    })

    typeMaps:insert("resource", resource.types, {
        key = "arsenicPickaxe",
        name = locale:get("resource_arsenicPickaxe"),
        plural = locale:get("resource_arsenicPickaxe_plural"),
        displayGameObjectTypeIndex = gameObjectTypeIndexMap.arsenicPickaxe,
        tradeBatchSize = 5,
        tradeValue = 50,
    })

    mj:log ("Arsenic Bronze: Resource types registered via typeMaps.")
end

return mod