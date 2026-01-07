-- Native mod framework: patch objectSpawner.getObjectSpawners without Hammerstone dependency

local mod = {}

function mod:onload(objectSpawner)
    mj:log("Arsenic Bronze: Patching objectSpawner to add arsenic ore spawner")
    
    local prevGetObjectSpawners = objectSpawner.getObjectSpawners
    
    function objectSpawner:getObjectSpawners()
        -- Call the original function to get base spawners
        local objectSpawners = prevGetObjectSpawners(self)
        
        -- Require gameObject inside the function so types are populated
        local gameObject = mjrequire "common/gameObject"
        
        -- Verify gameObject types exist before using them
        if not gameObject or not gameObject.types then
            mj:warn("Iron Working: gameObject.types not available in objectSpawner")
            return objectSpawners
        end
        
        -- Add arsenicOre spawner for natural terrain generation
        if gameObject.types.arsenicOre then
            table.insert(objectSpawners, {
                objectTypeIndex = gameObject.types.arsenicOre.index,
                addLevel = 2,
                requiredTags = {},
                disallowedTags = {},
                frequency = 4.0,
                minAltitude = 0.0,
                maxAltitude = nil
            })
            mj:log("Arsenic Bronze: Added arsenicOre spawner")
        end
        
        mj:log("Arsenic Bronze: Added arsenicOre spawner to world object generation")
        
        return objectSpawners
    end
end

return mod

