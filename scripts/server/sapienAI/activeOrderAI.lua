
local action = mjrequire "common/action"
local resource = mjrequire "common/resource"
local statusEffect = mjrequire "common/statusEffect"
local notification = mjrequire "common/notification"
local plan = mjrequire "common/plan"
local rng = mjrequire "common/randomNumberGenerator"
local sapienConstants = mjrequire "common/sapienConstants"

local mod = {
    loadOrder = 1,
}

function mod:onload(activeOrderAI)
    mj:log("Arsenic Bronze: Shadowing smeltMetal completionFunction")
    
    -- 1. Save the original completion handler
    local super_smeltMetalCompletion = activeOrderAI.updateInfos[action.types.smeltMetal.index].completionFunction

    -- 2. Create our new completion function with arsenic poisoning
    local function arsenicBronzeSmeltMetalCompletionFunction(allowCompletion, sapien, orderObject, orderState, actionState, constructableType, requiredLearnComplete)
        
        -- PRE-HOOK: Log what's being processed
        if constructableType then
            mj:log("Arsenic Bronze: Completion for: " .. constructableType.key)
        end

        -- 3. Call the SUPER - runs vanilla game logic (burns, item creation, etc.)
        super_smeltMetalCompletion(allowCompletion, sapien, orderObject, orderState, actionState, constructableType, requiredLearnComplete)

        -- POST-HOOK: Add arsenic poisoning ONLY for arsenic bronze ingots
        if allowCompletion and constructableType and constructableType.key == "arsenicBronzeIngot" then
            mj:log("Arsenic Bronze: Arsenic bronze ingot smelted! Checking for poisoning...")
            
            -- Require server modules here (they're initialized by vanilla activeOrderAI:init)
            local serverStatusEffects = mjrequire "server/serverStatusEffects"
            local serverGOM = mjrequire "server/serverGOM"
            local planManager = mjrequire "server/planManager"
            
            -- Apply arsenic poisoning with 40% chance
            local arsenicPoisoningChance = 0.40
            local randomChance = rng:randomInteger(math.floor(1.0 / arsenicPoisoningChance))
            
            mj:log("Arsenic Bronze: Random chance = " .. randomChance .. " (need < 1 for poisoning)")
            
            if randomChance < 1 and 
               (not statusEffect:hasEffect(sapien.sharedState, statusEffect.types.minorFoodPoisoning.index)) and
               (not statusEffect:hasEffect(sapien.sharedState, statusEffect.types.majorFoodPoisoning.index)) and
               (not statusEffect:hasEffect(sapien.sharedState, statusEffect.types.criticalFoodPoisoning.index)) then
                
                -- Apply minor arsenic poisoning
                serverStatusEffects:setTimedEffect(sapien.sharedState, statusEffect.types.minorFoodPoisoning.index, sapienConstants.foodPoisoningDuration)
                
                -- Send notification
                serverGOM:sendNotificationForObject(sapien, notification.types.minorFoodPoisoning.index, {
                    eatenResourceTypeIndex = resource.types.arsenicBronzeIngot.index,
                    contaminationResourceTypeIndex = resource.types.arsenicOre.index,
                }, sapien.sharedState.tribeID)
                
                -- Add treatment plan
                planManager:addStandardPlan(sapien.sharedState.tribeID, plan.types.treatFoodPoisoning.index, sapien.uniqueID, nil, nil, nil, nil, nil, nil)
                
                mj:log("Arsenic Bronze: " .. sapien.sharedState.name .. " POISONED by arsenic fumes!")
            else
                mj:log("Arsenic Bronze: No poisoning (randomChance=" .. randomChance .. " or already poisoned)")
            end
        end
    end

    -- 3. Replace the smeltMetal completion function
    activeOrderAI.updateInfos[action.types.smeltMetal.index].completionFunction = arsenicBronzeSmeltMetalCompletionFunction
    
    mj:log("Arsenic Bronze: Arsenic poisoning shadow registered for smeltMetal action")
end

return mod

