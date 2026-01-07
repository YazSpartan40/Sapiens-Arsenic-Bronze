local mjm = mjrequire "common/mjm"
local vec3 = mjm.vec3
local vec3xMat3 = mjm.vec3xMat3
local mat3Identity = mjm.mat3Identity
local mat3Rotate = mjm.mat3Rotate

local locale = mjrequire "common/locale"
local resource = mjrequire "common/resource"
local actionSequence = mjrequire "common/actionSequence"
local skill = mjrequire "common/skill"
local tool = mjrequire "common/tool"
local constructable = mjrequire "common/constructable"
local action = mjrequire "common/action"
local craftAreaGroup = mjrequire "common/craftAreaGroup"

local mod = {
    loadOrder = 2,
}

function mod:onload(craftable)
    local prevLoad = craftable.load
    craftable.load = function(craftable_, gameObject, flora)
        prevLoad(craftable_, gameObject, flora)

        -- Arsenic bronze tool multipliers
        local arsenicSpeedMultiplier = 1.6
        local arsenicDamageMultiplier = 1.6
        local arsenicDurabilityMultiplier = 1.6
        
        -- Smelting sequence: uses crucible tool and kiln area (31 action repeats)
        local actionSequenceRepeatCountSmelting = 31
        local cookingStickRotationOffset = mat3Rotate(mat3Identity, math.pi * 0.25, vec3(0.0,1.0,0.0))
        local cookingStickRotation = mat3Rotate(mat3Identity, -math.pi + math.pi * 0.25, vec3(0.0,1.0,0.0))

        -- INGOT SMELTING (Kiln)
        -- Arsenic Bronze Ingot: smelt from arsenic + tin + copper ore → 3 ingots; requires blacksmithing
        craftable:addCraftable("arsenicBronzeIngot", {
            name = locale:get("craftable_arsenicBronzeIngot"),
            plural = locale:get("craftable_arsenicBronzeIngot_plural"),
            summary = locale:get("craftable_arsenicBronzeIngot_summary"),
            iconGameObjectType = gameObject.typeIndexMap["arsenicBronzeIngot"],
            classification = constructable.classifications.craft.index,
            disabledUntilCraftableResearched = true,
            
            buildSequence = craftable:createStandardBuildSequence(actionSequence.types.smeltMetal.index, tool.types.crucible.index, actionSequenceRepeatCountSmelting),
            inProgressBuildModel = "craftCrucible",
            
            outputObjectInfo = {
                objectTypesArray = {
                    gameObject.typeIndexMap.arsenicBronzeIngot,
                    gameObject.typeIndexMap.arsenicBronzeIngot,
                    gameObject.typeIndexMap.arsenicBronzeIngot,
                }
            },

            skills = {
                required = skill.types.blacksmithing.index,
            },
            requiredResources = {
                {
                    type = resource.types.arsenicOre.index,
                    count = 1,
                },
                {
                    type = resource.types.tinOre.index,
                    count = 1,
                },
                {
                    type = resource.types.copperOre.index,
                    count = 1,
                },
            },
            
            requiredTools = {
                tool.types.crucible.index,
            },

            requiredCraftAreaGroups = {
                craftAreaGroup.types.kiln.index,
            },

            dontPickUpRequiredTool = true,
            
        })

        -- TOOL HEAD SMELTING (Kiln, requires blacksmithing discovery)
        -- Arsenic Axehead: 1 arsenic bronze ingot → 2 axeheads
        craftable:addCraftable("arsenicAxehead", {
            name = locale:get("craftable_arsenicAxehead"),
            plural = locale:get("craftable_arsenicAxehead_plural"),
            summary = locale:get("craftable_arsenicAxehead_summary"),
            iconGameObjectType = gameObject.typeIndexMap["arsenicAxehead"],
            classification = constructable.classifications.craft.index,
            disabledUntilCraftableResearched = true,
            
            buildSequence = craftable:createStandardBuildSequence(actionSequence.types.smeltMetal.index, tool.types.crucible.index, actionSequenceRepeatCountSmelting),
            inProgressBuildModel = "craftCrucible",
            
            outputObjectInfo = {
                objectTypesArray = {
                    gameObject.typeIndexMap.arsenicAxehead,
                    gameObject.typeIndexMap.arsenicAxehead,
                }
            },

            skills = {
                required = skill.types.blacksmithing.index,
            },
            requiredResources = {
                {
                    type = resource.types.arsenicBronzeIngot.index,
                    count = 1,
                    afterAction = {
                        actionTypeIndex = action.types.inspect.index,
                        duration = 1.0,
                        durationWithoutSkill = 10.0,
                    }
                },
            },
            
            requiredTools = {
                tool.types.crucible.index,
            },

            requiredCraftAreaGroups = {
                craftAreaGroup.types.kiln.index,
            },

            dontPickUpRequiredTool = true,
            
        })

        -- Arsenic Knife: 1 arsenic bronze ingot → 2 knives
        craftable:addCraftable("arsenicKnife", {
            name = locale:get("craftable_arsenicKnife"),
            plural = locale:get("craftable_arsenicKnife_plural"),
            summary = locale:get("craftable_arsenicKnife_summary"),
            iconGameObjectType = gameObject.typeIndexMap["arsenicKnife"],
            classification = constructable.classifications.craft.index,
            disabledUntilCraftableResearched = true,
            
            addGameObjectInfo = {
                modelName = "metalKnife",
                resourceTypeIndex = resource.types.arsenicKnife.index,
                toolUsages = {
                    [tool.types.carving.index] = {
                        [tool.propertyTypes.speed.index] = arsenicSpeedMultiplier,
                        [tool.propertyTypes.durability.index] = arsenicDurabilityMultiplier,
                    },
                    [tool.types.butcher.index] = {
                        [tool.propertyTypes.speed.index] = arsenicSpeedMultiplier,
                        [tool.propertyTypes.durability.index] = arsenicDurabilityMultiplier,
                    },
                    [tool.types.weaponKnife.index] = {
                        [tool.propertyTypes.damage.index] = arsenicDamageMultiplier,
                        [tool.propertyTypes.durability.index] = arsenicDurabilityMultiplier,
                    },
                },
            },
            
            buildSequence = craftable:createStandardBuildSequence(actionSequence.types.smeltMetal.index, tool.types.crucible.index, actionSequenceRepeatCountSmelting),
            inProgressBuildModel = "craftCrucible",
            
            outputObjectInfo = {
                objectTypesArray = {
                    gameObject.typeIndexMap.arsenicKnife,
                    gameObject.typeIndexMap.arsenicKnife,
                }
            },

            skills = {
                required = skill.types.blacksmithing.index,
            },
            requiredResources = {
                {
                    type = resource.types.arsenicBronzeIngot.index,
                    count = 1,
                    afterAction = {
                        actionTypeIndex = action.types.inspect.index,
                        duration = 1.0,
                        durationWithoutSkill = 10.0,
                    }
                },
            },
            
            requiredTools = {
                tool.types.crucible.index,
            },

            requiredCraftAreaGroups = {
                craftAreaGroup.types.kiln.index,
            },

            dontPickUpRequiredTool = true,
            
        })

        -- Arsenic Chisel: 1 arsenic bronze ingot → 2 chisels
        craftable:addCraftable("arsenicChisel", {
            name = locale:get("craftable_arsenicChisel"),
            plural = locale:get("craftable_arsenicChisel_plural"),
            summary = locale:get("craftable_arsenicChisel_summary"),
            iconGameObjectType = gameObject.typeIndexMap["arsenicChisel"],
            classification = constructable.classifications.craft.index,
            disabledUntilCraftableResearched = true,
            
            addGameObjectInfo = {
                modelName = "metalChisel",
                resourceTypeIndex = resource.types.arsenicChisel.index,
                toolUsages = {
                    [tool.types.softChiselling.index] = {
                        [tool.propertyTypes.speed.index] = arsenicSpeedMultiplier,
                        [tool.propertyTypes.durability.index] = arsenicDurabilityMultiplier,
                    },
                    [tool.types.hardChiselling.index] = {
                        [tool.propertyTypes.speed.index] = arsenicSpeedMultiplier,
                        [tool.propertyTypes.durability.index] = arsenicDurabilityMultiplier,
                    },
                    [tool.types.carving.index] = {
                        [tool.propertyTypes.speed.index] = arsenicSpeedMultiplier,
                        [tool.propertyTypes.durability.index] = arsenicDurabilityMultiplier,
                    },
                },
            },
            
            buildSequence = craftable:createStandardBuildSequence(actionSequence.types.smeltMetal.index, tool.types.crucible.index, actionSequenceRepeatCountSmelting),
            inProgressBuildModel = "craftCrucible",
            
            outputObjectInfo = {
                objectTypesArray = {
                    gameObject.typeIndexMap.arsenicChisel,
                    gameObject.typeIndexMap.arsenicChisel,
                }
            },

            skills = {
                required = skill.types.blacksmithing.index,
            },
            requiredResources = {
                {
                    type = resource.types.arsenicBronzeIngot.index,
                    count = 1,
                    afterAction = {
                        actionTypeIndex = action.types.inspect.index,
                        duration = 1.0,
                        durationWithoutSkill = 10.0,
                    }
                },
            },
            
            requiredTools = {
                tool.types.crucible.index,
            },

            requiredCraftAreaGroups = {
                craftAreaGroup.types.kiln.index,
            },

            dontPickUpRequiredTool = true,
            
        })

        -- Arsenic Spearhead: 1 arsenic bronze ingot → 2 spearheads
        craftable:addCraftable("arsenicSpearhead", {
            name = locale:get("craftable_arsenicSpearhead"),
            plural = locale:get("craftable_arsenicSpearhead_plural"),
            summary = locale:get("craftable_arsenicSpearhead_summary"),
            iconGameObjectType = gameObject.typeIndexMap["arsenicSpearhead"],
            classification = constructable.classifications.craft.index,
            disabledUntilCraftableResearched = true,
            
            buildSequence = craftable:createStandardBuildSequence(actionSequence.types.smeltMetal.index, tool.types.crucible.index, actionSequenceRepeatCountSmelting),
            inProgressBuildModel = "craftCrucible",
            
            outputObjectInfo = {
                objectTypesArray = {
                    gameObject.typeIndexMap.arsenicSpearhead,
                    gameObject.typeIndexMap.arsenicSpearhead,
                }
            },

            skills = {
                required = skill.types.blacksmithing.index,
            },
            requiredResources = {
                {
                    type = resource.types.arsenicBronzeIngot.index,
                    count = 1,
                    afterAction = {
                        actionTypeIndex = action.types.inspect.index,
                        duration = 1.0,
                        durationWithoutSkill = 10.0,
                    }
                },
            },
            
            requiredTools = {
                tool.types.crucible.index,
            },

            requiredCraftAreaGroups = {
                craftAreaGroup.types.kiln.index,
            },

            dontPickUpRequiredTool = true,
            
        })

        -- Arsenic Hammerhead: 1 arsenic bronze ingot → 2 hammerheads
        craftable:addCraftable("arsenicHammerhead", {
            name = locale:get("craftable_arsenicHammerhead"),
            plural = locale:get("craftable_arsenicHammerhead_plural"),
            summary = locale:get("craftable_arsenicHammerhead_summary"),
            iconGameObjectType = gameObject.typeIndexMap["arsenicHammerhead"],
            classification = constructable.classifications.craft.index,
            disabledUntilCraftableResearched = true,
            
            buildSequence = craftable:createStandardBuildSequence(actionSequence.types.smeltMetal.index, tool.types.crucible.index, actionSequenceRepeatCountSmelting),
            inProgressBuildModel = "craftCrucible",
            
            outputObjectInfo = {
                objectTypesArray = {
                    gameObject.typeIndexMap.arsenicHammerhead,
                    gameObject.typeIndexMap.arsenicHammerhead,
                }
            },

            skills = {
                required = skill.types.blacksmithing.index,
            },
            requiredResources = {
                {
                    type = resource.types.arsenicBronzeIngot.index,
                    count = 1,
                    afterAction = {
                        actionTypeIndex = action.types.inspect.index,
                        duration = 1.0,
                        durationWithoutSkill = 10.0,
                    }
                },
            },
            
            requiredTools = {
                tool.types.crucible.index,
            },

            requiredCraftAreaGroups = {
                craftAreaGroup.types.kiln.index,
            },

            dontPickUpRequiredTool = true,
            
        })

        -- Arsenic Pickaxehead: 1 arsenic bronze ingot → 2 pickaxeheads
        craftable:addCraftable("arsenicPickaxehead", {
            name = locale:get("craftable_arsenicPickaxehead"),
            plural = locale:get("craftable_arsenicPickaxehead_plural"),
            summary = locale:get("craftable_arsenicPickaxehead_summary"),
            iconGameObjectType = gameObject.typeIndexMap["arsenicPickaxehead"],
            classification = constructable.classifications.craft.index,
            disabledUntilCraftableResearched = true,
            
            buildSequence = craftable:createStandardBuildSequence(actionSequence.types.smeltMetal.index, tool.types.crucible.index, actionSequenceRepeatCountSmelting),
            inProgressBuildModel = "craftCrucible",
            
            outputObjectInfo = {
                objectTypesArray = {
                    gameObject.typeIndexMap.arsenicPickaxehead,
                    gameObject.typeIndexMap.arsenicPickaxehead,
                }
            },

            skills = {
                required = skill.types.blacksmithing.index,
            },
            requiredResources = {
                {
                    type = resource.types.arsenicBronzeIngot.index,
                    count = 1,
                    afterAction = {
                        actionTypeIndex = action.types.inspect.index,
                        duration = 1.0,
                        durationWithoutSkill = 10.0,
                    }
                },
            },
            
            requiredTools = {
                tool.types.crucible.index,
            },

            requiredCraftAreaGroups = {
                craftAreaGroup.types.kiln.index,
            },

            dontPickUpRequiredTool = true,
            
        })

        -- TOOL CRAFTING (Crafting Station, requires blacksmithing)
        -- Arsenic Axe: 1 axehead + 1 branch → 1 axe
        craftable:addCraftable("arsenicAxe", {
            name = locale:get("craftable_arsenicAxe"),
            plural = locale:get("craftable_arsenicAxe_plural"),
            summary = locale:get("craftable_arsenicAxe_summary"),
            iconGameObjectType = gameObject.typeIndexMap["arsenicAxe"],
            classification = constructable.classifications.craft.index,
            disabledUntilCraftableResearched = true,
            
            addGameObjectInfo = {
                modelName = "bronzeHatchet",
                resourceTypeIndex = resource.types.arsenicAxe.index,
                preservesConstructionObjects = true,
                
                toolUsages = {
                    [tool.types.treeChop.index] = {
                        [tool.propertyTypes.speed.index] = 2.0 * arsenicSpeedMultiplier,
                        [tool.propertyTypes.durability.index] = arsenicDurabilityMultiplier,
                    },
                },
            },
            
            buildSequence = craftable:createStandardBuildSequence(actionSequence.types.toolAssembly.index, nil),
            inProgressBuildModel = "bronzeAxeBuild",
            
            outputObjectInfo = {
                objectTypesArray = {
                    gameObject.typeIndexMap.arsenicAxe,
                }
            },

            skills = {
                required = skill.types.blacksmithing.index,
            },
            requiredResources = {
                {
                    type = resource.types.arsenicAxehead.index,
                    count = 1,
                },
                {
                    type = resource.types.branch.index,
                    count = 1,
                },
            },
            
            requiredTools = {
            },

            requiredCraftAreaGroups = {
            },
        })

        -- Arsenic Spear: 1 spearhead + 1 branch → 1 spear
        craftable:addCraftable("arsenicSpear", {
            name = locale:get("craftable_arsenicSpear"),
            plural = locale:get("craftable_arsenicSpear_plural"),
            summary = locale:get("craftable_arsenicSpear_summary"),
            iconGameObjectType = gameObject.typeIndexMap["arsenicSpear"],
            classification = constructable.classifications.craft.index,
            disabledUntilCraftableResearched = true,
            
            addGameObjectInfo = {
                modelName = "bronzeSpear",
                resourceTypeIndex = resource.types.arsenicSpear.index,
                preservesConstructionObjects = true,
                
                toolUsages = {
                    [tool.types.weaponSpear.index] = {
                        [tool.propertyTypes.damage.index] = arsenicDamageMultiplier,
                        [tool.propertyTypes.durability.index] = arsenicDurabilityMultiplier,
                    },
                },
            },
            
            buildSequence = craftable:createStandardBuildSequence(actionSequence.types.toolAssembly.index, nil),
            inProgressBuildModel = "bronzeSpearBuild",
            
            outputObjectInfo = {
                objectTypesArray = {
                    gameObject.typeIndexMap.arsenicSpear,
                }
            },

            skills = {
                required = skill.types.blacksmithing.index,
            },
            requiredResources = {
                {
                    type = resource.types.arsenicSpearhead.index,
                    count = 1,
                },
                {
                    type = resource.types.branch.index,
                    count = 1,
                },
            },
            
            requiredTools = {
            },

            requiredCraftAreaGroups = {
            },
        })

        -- Arsenic Hammer: 1 hammerhead + 1 branch → 1 hammer
        craftable:addCraftable("arsenicHammer", {
            name = locale:get("craftable_arsenicHammer"),
            plural = locale:get("craftable_arsenicHammer_plural"),
            summary = locale:get("craftable_arsenicHammer_summary"),
            iconGameObjectType = gameObject.typeIndexMap["arsenicHammer"],
            classification = constructable.classifications.craft.index,
            disabledUntilCraftableResearched = true,
            
            addGameObjectInfo = {
                modelName = "bronzeHammer",
                resourceTypeIndex = resource.types.arsenicHammer.index,
                preservesConstructionObjects = true,
                
                toolUsages = {
                    [tool.types.hammering.index] = {
                        [tool.propertyTypes.speed.index] = arsenicSpeedMultiplier,
                        [tool.propertyTypes.durability.index] = arsenicDurabilityMultiplier,
                    },
                    [tool.types.mine.index] = {
                        [tool.propertyTypes.speed.index] = arsenicSpeedMultiplier,
                        [tool.propertyTypes.durability.index] = arsenicDurabilityMultiplier,
                    },
                },
            },
            
            buildSequence = craftable:createStandardBuildSequence(actionSequence.types.toolAssembly.index, nil),
            inProgressBuildModel = "bronzeHammerBuild",
            
            outputObjectInfo = {
                objectTypesArray = {
                    gameObject.typeIndexMap.arsenicHammer,
                }
            },

            skills = {
                required = skill.types.blacksmithing.index,
            },
            requiredResources = {
                {
                    type = resource.types.arsenicHammerhead.index,
                    count = 1,
                },
                {
                    type = resource.types.branch.index,
                    count = 1,
                },
            },
            
            requiredTools = {
            },

            requiredCraftAreaGroups = {
            },
        })

        -- Arsenic Pickaxe: 1 pickaxehead + 1 branch → 1 pickaxe
        craftable:addCraftable("arsenicPickaxe", {
            name = locale:get("craftable_arsenicPickaxe"),
            plural = locale:get("craftable_arsenicPickaxe_plural"),
            summary = locale:get("craftable_arsenicPickaxe_summary"),
            iconGameObjectType = gameObject.typeIndexMap["arsenicPickaxe"],
            classification = constructable.classifications.craft.index,
            disabledUntilCraftableResearched = true,
            
            addGameObjectInfo = {
                modelName = "bronzePickaxe",
                resourceTypeIndex = resource.types.arsenicPickaxe.index,
                preservesConstructionObjects = true,
                
                toolUsages = {
                    [tool.types.dig.index] = {
                        [tool.propertyTypes.speed.index] = arsenicSpeedMultiplier,
                        [tool.propertyTypes.durability.index] = arsenicDurabilityMultiplier,
                    },
                    [tool.types.mine.index] = {
                        [tool.propertyTypes.speed.index] = arsenicSpeedMultiplier,
                        [tool.propertyTypes.durability.index] = arsenicDurabilityMultiplier,
                    },
                },
            },
            
            buildSequence = craftable:createStandardBuildSequence(actionSequence.types.toolAssembly.index, nil),
            inProgressBuildModel = "bronzePickaxeBuild",
            
            outputObjectInfo = {
                objectTypesArray = {
                    gameObject.typeIndexMap.arsenicPickaxe,
                }
            },

            skills = {
                required = skill.types.blacksmithing.index,
            },
            requiredResources = {
                {
                    type = resource.types.arsenicPickaxehead.index,
                    count = 1,
                },
                {
                    type = resource.types.branch.index,
                    count = 1,
                },
            },
            
            requiredTools = {
            },

            requiredCraftAreaGroups = {
            },
        })

        -- Optional: If Iron Working is present, allow smelting arsenic ore to iron ingot
        if resource.types.ironIngot and gameObject.typeIndexMap.ironIngot then
            craftable:addCraftable("ironIngot_fromArsenic", {
                name = "Smelt Iron Ingot (from Arsenic Ore)",
                plural = "Smelt Iron Ingots (from Arsenic Ore)",
                summary = "Smelt iron ingot using arsenic ore as an alternative source",
                iconGameObjectType = gameObject.typeIndexMap["ironIngot"],
                classification = constructable.classifications.craft.index,
                buildSequence = craftable:createStandardBuildSequence(actionSequence.types.smeltMetal.index, tool.types.crucible.index, actionSequenceRepeatCountSmelting),
                inProgressBuildModel = "craftCrucible",
                outputObjectInfo = {
                    objectTypesArray = {
                        gameObject.typeIndexMap.ironIngot,
                    }
                },
                skills = {
                    required = skill.types.blacksmithing.index,
                },
                requiredResources = {
                    {
                        type = resource.types.arsenicOre.index,
                        count = 2,
                    },
                },
                requiredTools = {
                    tool.types.crucible.index,
                },
                requiredCraftAreaGroups = {
                    craftAreaGroup.types.kiln.index,
                },
                dontPickUpRequiredTool = true,
            })
        end

        mj:log ("Arsenic Bronze: All arsenic craftables registered")
    end
end

return mod
