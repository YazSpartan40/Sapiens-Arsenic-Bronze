local mod = {
    loadOrder = 1,
}

mj:log ("Arsenic Bronze: model.lua loaded")

function mod:onload(model)
    local prevLoadRemaps = model.loadRemaps or function() end
    model.loadRemaps = function(model_)
        -- Arsenic Bronze remaps
        -- Ingot: use base ingot geometry, tint to arsenic bronze
        model.remapModels.ingot = model.remapModels.ingot or {}
        model.remapModels.ingot.arsenicBronzeIngot = { metal = "arsenicBronze" }

        -- Ore: use base ore geometry with arsenic ore material
        model.remapModels.ore = model.remapModels.ore or {}
        model.remapModels.ore.arsenicOre = { ore = "arsenicOre" }

        -- Metal heads and small tools: tint metal to arsenic bronze
        model.remapModels.metalAxeHead = model.remapModels.metalAxeHead or {}
        model.remapModels.metalAxeHead.arsenicAxeHead = { metal = "arsenicBronze" }

        model.remapModels.metalPickaxeHead = model.remapModels.metalPickaxeHead or {}
        model.remapModels.metalPickaxeHead.arsenicPickaxeHead = { metal = "arsenicBronze" }

        model.remapModels.metalSpearHead = model.remapModels.metalSpearHead or {}
        model.remapModels.metalSpearHead.arsenicSpearHead = { metal = "arsenicBronze" }

        model.remapModels.metalHammerHead = model.remapModels.metalHammerHead or {}
        model.remapModels.metalHammerHead.arsenicHammerHead = { metal = "arsenicBronze" }

        model.remapModels.metalKnife = model.remapModels.metalKnife or {}
        model.remapModels.metalKnife.arsenicKnife = { metal = "arsenicBronze" }

        model.remapModels.metalChisel = model.remapModels.metalChisel or {}
        model.remapModels.metalChisel.arsenicChisel = { metal = "arsenicBronze" }

        -- Finished tools: reuse bronze geometry, tint metal to arsenic bronze for arsenic variants
        model.remapModels.bronzeHatchet = model.remapModels.bronzeHatchet or {}
        model.remapModels.bronzeHatchet.arsenicHatchet = { metal = "arsenicBronze" }

        model.remapModels.bronzePickaxe = model.remapModels.bronzePickaxe or {}
        model.remapModels.bronzePickaxe.arsenicPickaxe = { metal = "arsenicBronze" }

        model.remapModels.bronzeSpear = model.remapModels.bronzeSpear or {}
        model.remapModels.bronzeSpear.arsenicSpear = { metal = "arsenicBronze" }

        model.remapModels.bronzeHammer = model.remapModels.bronzeHammer or {}
        model.remapModels.bronzeHammer.arsenicHammer = { metal = "arsenicBronze" }

        prevLoadRemaps(model_)
        mj:log ("Arsenic Bronze: Model remaps registered.")
    end
end

return mod