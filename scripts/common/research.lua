local resource = mjrequire "common/resource"
local skill = mjrequire "common/skill"

local mod = { loadOrder = 2 }

function mod:onload(research)
    mj:log("Arsenic Bronze: Preparing Arsenic Bronze research registration (safe load)")

    local prevLoad = research.load
    research.load = function(research_, gameObject, constructable, flora)
        prevLoad(research_, gameObject, constructable, flora)

        mj:log("Arsenic Bronze: Arsenic Bronze craftables gated by blacksmithing skill")
        
        -- Arsenic Bronze uses existing blacksmithing skill from vanilla
        -- No custom research needed; blacksmithing discovery unlocks all arsenic bronze craftables

        mj:log("Iron Working: Iron Working research registered with index:", ironWorkingIndex)
        -- Arsenic Bronze uses existing blacksmithing skill from vanilla
        -- No custom research needed; blacksmithing discovery unlocks all arsenic bronze craftables
    end
end

return mod
