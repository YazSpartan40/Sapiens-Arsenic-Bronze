local constructable = mjrequire "common/constructable"
local gameObject = mjrequire "common/gameObject"

local mod = {
    loadOrder = 1,
}

mj:log("SilverMod: inspectCraftPanel.lua loaded")

function mod:onload(inspectCraftPanel)
    -- Add silverIngot and silverNecklace to the kiln craft menu
    if inspectCraftPanel.itemLists and inspectCraftPanel.itemLists[gameObject.typeIndexMap.brickKiln] then
        table.insert(inspectCraftPanel.itemLists[gameObject.typeIndexMap.brickKiln], constructable.types.silverIngot.index)
        table.insert(inspectCraftPanel.itemLists[gameObject.typeIndexMap.brickKiln], constructable.types.silverNecklace.index)
        mj:log("SilverMod: Added silverIngot and silverNecklace to kiln craft menu")
    end
end

return mod
