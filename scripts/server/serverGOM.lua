-- Iron Working server-side patch: ensure Iron Working skill gets its objectSets created
-- Patches serverGOM.init to add object sets for skills added post-framework init

local mod = {
    loadOrder = 1,
}

function mod:onload(serverGOM)
    mj:log("Iron Working: Patching serverGOM to ensure Iron Working skill object sets are created")
    
    local prevInit = serverGOM.init
    serverGOM.init = function(self)
        prevInit(self)
        
        -- After vanilla init, check for any skills that don't have object sets yet
        local skill = mjrequire "common/skill"
        
        if skill and skill.types and skill.types.ironWorking then
            mj:log("Iron Working: Creating object sets for Iron Working skill post-init")
            
            local ironWorkingSkill = skill.types.ironWorking
            
            -- Create planObjectSet for iron working if it doesn't exist
            if not ironWorkingSkill.planObjectSetIndex then
                local planObjectSetKey = "planObjectsBySkill_" .. ironWorkingSkill.key
                local planObjectSetIndex = self:createObjectSet(planObjectSetKey)
                ironWorkingSkill.planObjectSetIndex = planObjectSetIndex
                self.objectSets[planObjectSetKey] = planObjectSetIndex
                mj:log("Iron Working: Created planObjectSet for Iron Working: index", planObjectSetIndex)
            end
            
            -- Create sapienSet for iron working if it doesn't exist
            if not ironWorkingSkill.sapienSetIndex then
                local sapienSetKey = "sapiensBySkill_" .. ironWorkingSkill.key
                local sapienSetIndex = self:createObjectSet(sapienSetKey)
                ironWorkingSkill.sapienSetIndex = sapienSetIndex
                self.objectSets[sapienSetKey] = sapienSetIndex
                mj:log("Iron Working: Created sapienSet for Iron Working: index", sapienSetIndex)
            end
        else
            mj:warn("Iron Working: Iron Working skill not available during serverGOM init patch")
        end
    end
end

return mod
