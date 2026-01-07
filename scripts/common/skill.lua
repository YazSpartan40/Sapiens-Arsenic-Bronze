local typeMaps = mjrequire "common/typeMaps"
local locale = mjrequire "common/locale"

local mod = { loadOrder = 1 }

function mod:onload(skill)
    -- Add Iron Working skill type
    typeMaps:insert("skill", skill.types, {
        key = "ironWorking",
        name = locale:get("skill_ironWorking"),
        description = locale:get("skill_ironWorking_description"),
        icon = "icon_craft",
    })
end

return mod
