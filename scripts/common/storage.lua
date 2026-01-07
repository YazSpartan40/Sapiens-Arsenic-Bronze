local mjm = mjrequire "common/mjm"
local vec3 = mjm.vec3
local mat3Identity = mjm.mat3Identity
local mat3Rotate = mjm.mat3Rotate

local rng = mjrequire "common/randomNumberGenerator"
local typeMaps = mjrequire "common/typeMaps"
local locale = mjrequire "common/locale"
local resource = mjrequire "common/resource"

local mod = {
    loadOrder = 1,
}

mj:log ("Arsenic Bronze: storage.lua loaded")

function mod:onload(storage)
    
    local gameObjectTypeIndexMap = typeMaps.types.gameObject

    -- Arsenic Ore Storage
    typeMaps:insert("storage", storage.types, {
        key = "arsenicOreStorage",
        name = locale:get("storage_arsenicOreStorage"),
        displayGameObjectTypeIndex = gameObjectTypeIndexMap.arsenicOre,
        resources = {
            resource.types.arsenicOre.index,
        },
        storageBox = {
            size =  vec3(0.4, 0.2, 0.4),
            rotationFunction = function(uniqueID, seed)
                local randomValue = rng:valueForUniqueID(uniqueID, seed)
                local rotation = mat3Rotate(mat3Identity, randomValue * 6.28, vec3(0.0,1.0,0.0))
                return rotation
            end,
        },
        maxCarryCount = 4,
        maxCarryCountLimitedAbility = 2,
        maxCarryCountForRunning = 2,
        carryOffset = vec3(0.0, 0.1, 0.0),
        carryRotation = mat3Identity,
    })
    
    -- Arsenic Bronze Ingot Storage
    typeMaps:insert("storage", storage.types, {
        key = "arsenicBronzeIngotStorage",
        name = locale:get("storage_arsenicBronzeIngotStorage"),
        displayGameObjectTypeIndex = gameObjectTypeIndexMap.arsenicBronzeIngot,
        resources = {
            resource.types.arsenicBronzeIngot.index,
        },
        storageBox = {
            size =  vec3(0.5, 0.15, 0.2),
            rotationFunction = function(uniqueID, seed)
                local randomValue = rng:valueForUniqueID(uniqueID, seed)
                local rotation = mat3Rotate(mat3Identity, randomValue * 0.2 - 0.1, vec3(0.0,1.0,0.0))
                return rotation
            end,
            dontRotateToFitBelowSurface = true,
        },
        maxCarryCount = 1,
        maxCarryCountLimitedAbility = 1,
        maxCarryCountForRunning = 0,
        carryOffset = vec3(-0.02,0.15,0.04),
        carryRotation = mat3Rotate(mat3Rotate(mat3Rotate(mat3Identity, 1.0, vec3(0.0, 0.0, 1.0)), -0.5, vec3(0.0, 1.0, 0.0)), 0.3, vec3(1.0,0.0,0.0)),
    })
    
    -- Arsenic Component Storage (tool heads only)
    typeMaps:insert("storage", storage.types, {
        key = "arsenicComponentStorage",
        name = locale:get("storage_arsenicComponentStorage"),
        displayGameObjectTypeIndex = gameObjectTypeIndexMap.arsenicAxehead,
        resources = {
            resource.types.arsenicAxehead.index,
            resource.types.arsenicKnife.index,
            resource.types.arsenicChisel.index,
            resource.types.arsenicSpearhead.index,
            resource.types.arsenicHammerhead.index,
            resource.types.arsenicPickaxehead.index,
        },
        storageBox = {
            size =  vec3(0.3, 0.15, 0.3),
            rotationFunction = function(uniqueID, seed)
                local randomValue = rng:valueForUniqueID(uniqueID, seed)
                local rotation = mat3Rotate(mat3Identity, randomValue * 6.282, vec3(0.0,1.0,0.0))
                rotation = mat3Rotate(rotation, randomValue * 6.282, vec3(1.0,0.0,0.0))
                return rotation
            end,
        },
        maxCarryCount = 2,
        maxCarryCountLimitedAbility = 1,
        maxCarryCountForRunning = 1,
        carryType = storage.carryTypes.small,
        carryOffset = vec3(0.0,0.01,0.0),
    })
    
    -- Arsenic Tool Storage (finished tools only)
    typeMaps:insert("storage", storage.types, {
        key = "arsenicToolStorage",
        name = locale:get("storage_arsenicToolStorage"),
        displayGameObjectTypeIndex = gameObjectTypeIndexMap.arsenicAxe,
        resources = {
            resource.types.arsenicAxe.index,
            resource.types.arsenicSpear.index,
            resource.types.arsenicHammer.index,
            resource.types.arsenicPickaxe.index,
        },
        storageBox = {
            size =  vec3(0.35, 0.2, 0.35),
            rotationFunction = function(uniqueID, seed)
                local randomValue = rng:valueForUniqueID(uniqueID, seed)
                local rotation = mat3Rotate(mat3Identity, randomValue * 6.282, vec3(0.0,1.0,0.0))
                return rotation
            end,
        },
        maxCarryCount = 1,
        maxCarryCountLimitedAbility = 1,
        maxCarryCountForRunning = 0,
        carryType = storage.carryTypes.standard,
        carryOffset = vec3(0.0,0.0,0.0),
    })
    
    mj:log ("Arsenic Bronze: Storage types registered via typeMaps.")
end

return mod