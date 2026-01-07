local mjm = mjrequire "common/mjm"
local vec3 = mjm.vec3

local resource = mjrequire "common/resource"
local locale = mjrequire "common/locale"

local mod = {
    loadOrder = 1,
}

mj:log ("Arsenic Bronze: gameObject.lua loaded")

function mod:onload(gameObject)
    
    gameObject:addGameObjectsFromTable({
        -- Arsenic Ore and Arsenic Bronze Ingot
        arsenicOre = {
            name = locale:get("object_arsenicOre"),
            plural = locale:get("object_arsenicOre_plural"),
            modelName = "arsenicOre",
            scale = 1.0,
            hasPhysics = true,
            resourceTypeIndex = resource.types.arsenicOre.index,
            markerPositions = {
                { 
                    worldOffset = vec3(0.0, mj:mToP(0.2), 0.0)
                }
            },
            mass = 2.0,
            category = "resources",
        },
        arsenicBronzeIngot = {
            name = locale:get("object_arsenicBronzeIngot"),
            plural = locale:get("object_arsenicBronzeIngot_plural"),
            modelName = "arsenicBronzeIngot",
            scale = 1.0,
            hasPhysics = true,
            resourceTypeIndex = resource.types.arsenicBronzeIngot.index,
            markerPositions = {
                { 
                    worldOffset = vec3(0.0, mj:mToP(0.2), 0.0)
                }
            },
            mass = 2.0,
            category = "resources",
        },
        -- Arsenic Tool Heads (kiln production)
        arsenicAxehead = {
            name = locale:get("object_arsenicAxehead"),
            plural = locale:get("object_arsenicAxehead_plural"),
            modelName = "arsenicAxeHead",
            scale = 1.0,
            hasPhysics = true,
            resourceTypeIndex = resource.types.arsenicAxehead.index,
            markerPositions = {
                { 
                    worldOffset = vec3(0.0, mj:mToP(0.1), 0.0)
                }
            },
            mass = 1.0,
            category = "resources",
        },
        arsenicKnife = {
            name = locale:get("object_arsenicKnife"),
            plural = locale:get("object_arsenicKnife_plural"),
            modelName = "metalKnife",
            scale = 1.0,
            hasPhysics = true,
            resourceTypeIndex = resource.types.arsenicKnife.index,
            markerPositions = {
                { 
                    worldOffset = vec3(0.0, mj:mToP(0.1), 0.0)
                }
            },
            mass = 0.8,
            category = "resources",
        },
        arsenicChisel = {
            name = locale:get("object_arsenicChisel"),
            plural = locale:get("object_arsenicChisel_plural"),
            modelName = "metalChisel",
            scale = 1.0,
            hasPhysics = true,
            resourceTypeIndex = resource.types.arsenicChisel.index,
            markerPositions = {
                { 
                    worldOffset = vec3(0.0, mj:mToP(0.1), 0.0)
                }
            },
            mass = 0.8,
            category = "resources",
        },
        arsenicSpearhead = {
            name = locale:get("object_arsenicSpearhead"),
            plural = locale:get("object_arsenicSpearhead_plural"),
            modelName = "arsenicSpearHead",
            scale = 1.0,
            hasPhysics = true,
            resourceTypeIndex = resource.types.arsenicSpearhead.index,
            markerPositions = {
                { 
                    worldOffset = vec3(0.0, mj:mToP(0.1), 0.0)
                }
            },
            mass = 1.0,
            category = "resources",
        },
        arsenicHammerhead = {
            name = locale:get("object_arsenicHammerhead"),
            plural = locale:get("object_arsenicHammerhead_plural"),
            modelName = "arsenicHammerHead",
            scale = 1.0,
            hasPhysics = true,
            resourceTypeIndex = resource.types.arsenicHammerhead.index,
            markerPositions = {
                { 
                    worldOffset = vec3(0.0, mj:mToP(0.1), 0.0)
                }
            },
            mass = 1.2,
            category = "resources",
        },
        arsenicPickaxehead = {
            name = locale:get("object_arsenicPickaxehead"),
            plural = locale:get("object_arsenicPickaxehead_plural"),
            modelName = "arsenicPickaxeHead",
            scale = 1.0,
            hasPhysics = true,
            resourceTypeIndex = resource.types.arsenicPickaxehead.index,
            markerPositions = {
                { 
                    worldOffset = vec3(0.0, mj:mToP(0.1), 0.0)
                }
            },
            mass = 1.2,
            category = "resources",
        },
        -- Arsenic Tools (crafted from heads + branch)
        arsenicAxe = {
            name = locale:get("object_arsenicAxe"),
            plural = locale:get("object_arsenicAxe_plural"),
            modelName = "arsenicHatchet",
            scale = 1.0,
            hasPhysics = true,
            resourceTypeIndex = resource.types.arsenicAxe.index,
            markerPositions = {
                { 
                    worldOffset = vec3(0.0, mj:mToP(0.2), 0.0)
                }
            },
            mass = 1.5,
            category = "resources",
        },
        arsenicSpear = {
            name = locale:get("object_arsenicSpear"),
            plural = locale:get("object_arsenicSpear_plural"),
            modelName = "arsenicSpear",
            scale = 1.0,
            hasPhysics = true,
            resourceTypeIndex = resource.types.arsenicSpear.index,
            markerPositions = {
                { 
                    worldOffset = vec3(0.0, mj:mToP(0.3), 0.0)
                }
            },
            mass = 1.6,
            category = "resources",
        },
        arsenicHammer = {
            name = locale:get("object_arsenicHammer"),
            plural = locale:get("object_arsenicHammer_plural"),
            modelName = "arsenicHammer",
            scale = 1.0,
            hasPhysics = true,
            resourceTypeIndex = resource.types.arsenicHammer.index,
            markerPositions = {
                { 
                    worldOffset = vec3(0.0, mj:mToP(0.2), 0.0)
                }
            },
            mass = 1.8,
            category = "resources",
        },
        arsenicPickaxe = {
            name = locale:get("object_arsenicPickaxe"),
            plural = locale:get("object_arsenicPickaxe_plural"),
            modelName = "arsenicPickaxe",
            scale = 1.0,
            hasPhysics = true,
            resourceTypeIndex = resource.types.arsenicPickaxe.index,
            markerPositions = {
                { 
                    worldOffset = vec3(0.0, mj:mToP(0.2), 0.0)
                }
            },
            mass = 1.8,
            category = "resources",
        },
    })
end

return mod