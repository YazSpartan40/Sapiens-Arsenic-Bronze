# Iron Working Mod - Damage & Durability Implementation

## Summary of Changes

This document outlines the enhancements made to the Iron Working mod to add proper tool damage/durability properties and reorganize storage for better gameplay organization.

---

## 1. Tool Property Multipliers

### Multiplier Values (50% Better than Bronze)

```lua
-- Bronze Baseline (Vanilla)
- bronzeSpeedMultiplier = 1.4
- bronzeDamageMultiplier = 1.4
- bronzeDurabilityMultiplier = 4.0

-- Iron Working (New)
- ironSpeedMultiplier = 1.5
- ironDamageMultiplier = 1.5
- ironDurabilityMultiplier = 6.0
```

**Performance Advantage:**
- Speed: +7.1% faster than bronze (1.5 / 1.4)
- Damage: +7.1% more powerful than bronze (1.5 / 1.4)
- Durability: +50% longer-lasting than bronze (6.0 / 4.0)

### File: `scripts/common/craftable.lua`

**Location:** Lines 25-27

The multipliers are defined once at module load and reused for all iron tool recipes.

---

## 2. Iron Tool Properties

### Iron Axe
- **Model:** bronzeAxe
- **Tool Types:**
  - `treeChop`: Speed = 3.0 (2.0 × 1.5), Durability = 6.0
  - `resource`: Speed = 1.5, Durability = 6.0

### Iron Spear
- **Model:** bronzeSpear
- **Tool Type:**
  - `weaponSpear`: Damage = 3.0 (2.0 × 1.5), Durability = 6.0

### Iron Hammer
- **Model:** bronzeHammer
- **Tool Types:**
  - `hammering`: Speed = 1.5, Durability = 6.0
  - `mine`: Speed = 1.5, Durability = 6.0

### Iron Pickaxe
- **Model:** bronzePickaxe
- **Tool Types:**
  - `dig`: Speed = 3.0 (2.0 × 1.5), Durability = 6.0
  - `mine`: Speed = 1.5, Durability = 6.0

---

## 3. Storage Reorganization

### Previous Structure (1 Combined Storage)
```
ironToolStorage (ALL 10 resources)
├── 6 tool heads (components)
└── 4 finished tools
```

### New Structure (3 Separate Storages)

#### Iron Ore Storage
- **Contents:** Iron Ore only
- **Max Carry:** 4 pieces
- **Display Icon:** Iron Ore
- **Purpose:** Raw material storage

#### Iron Ingot Storage
- **Contents:** Iron Ingot only
- **Max Carry:** 1 piece
- **Display Icon:** Iron Ingot
- **Purpose:** Intermediate material storage

#### Iron Component Storage (NEW)
- **Contents:** Tool heads only (6 types)
  - Iron Axehead
  - Iron Knife
  - Iron Chisel
  - Iron Spearhead
  - Iron Hammerhead
  - Iron Pickaxehead
- **Max Carry:** 2 pieces
- **Display Icon:** Iron Axehead
- **Purpose:** Organize forged components before assembly

#### Iron Tool Storage (UPDATED)
- **Contents:** Finished tools only (4 types)
  - Iron Axe
  - Iron Spear
  - Iron Hammer
  - Iron Pickaxe
- **Max Carry:** 1 piece (max 2 with full ability)
- **Display Icon:** Iron Axe
- **Purpose:** Store completed, usable tools

### Benefits of Separation

1. **Organization:** Players can distinguish between components and finished tools
2. **Workflow Clarity:** Separates "still crafting" phase from "ready to use" phase
3. **Storage Efficiency:** Optimized box sizes for each material type
4. **Gameplay Flow:** Better progression visualization from ore → ingot → component → tool

---

## 4. Localization Updates

### File: `localizations/en_us/localizations.lua`

**Added:**
```lua
storage_ironComponentStorage = "Iron Component Storage"
```

**Unchanged:**
- `storage_ironOreStorage` = "Iron Ore Storage"
- `storage_ironIngotStorage` = "Iron Ingot Storage"
- `storage_ironToolStorage` = "Iron Tool Storage"

All 4 storage types now have proper localization strings.

---

## 5. Implementation Details

### Crafting Assembly Changes

All 4 iron tool assembly recipes now include `addGameObjectInfo` with:

```lua
addGameObjectInfo = {
    modelName = "bronze[ToolType]",  -- Uses bronze model as placeholder
    resourceTypeIndex = resource.types.iron[ToolType].index,
    preservesConstructionObjects = true,
    
    toolUsages = {
        [tool.types.[action].index] = {
            [tool.propertyTypes.speed.index] = <speedValue>,
            [tool.propertyTypes.damage.index] = <damageValue>,  -- Spear only
            [tool.propertyTypes.durability.index] = ironDurabilityMultiplier,
        },
        -- ... additional tool types as needed
    },
}
```

### Storage Type Registration

Storage types are registered via `typeMaps:insert()` with proper:
- Localization keys
- Resource type arrays (separated by use)
- Storage box configurations
- Carry mechanics optimized for item type

---

## 6. Progression Overview

### Material Flow

```
Iron Ore (mining)
    ↓ [Blacksmithing Skill]
Iron Ingot (smelting, kiln)
    ├→ Iron Component Storage
    │   ↓ [Iron Working Skill]
    │   Tool Heads (forging, kiln)
    │   ↓ [Assembly]
Iron Tool Storage (crafting table)
    └→ Finished Tools (ready to use)
```

### Storage Usage Timeline

| Stage | Primary Storage | Purpose |
|-------|-----------------|---------|
| Mining | Iron Ore Storage | Collect raw materials |
| Smelting | Iron Ingot Storage | Hold intermediate ingots |
| Forging | Iron Component Storage | Organize forged heads before assembly |
| Assembly | Iron Tool Storage | Store finished, usable tools |

---

## 7. Vanilla Pattern Compliance

All implementations follow vanilla Sapiens patterns:

✅ Multiplier system matches bronze tool structure
✅ Tool property assignment mirrors vanilla craftables
✅ Storage configuration follows vanilla conventions
✅ Localization key naming is consistent
✅ Load order (loadOrder=1) maintained

---

## 8. Testing Checklist

- [ ] Ore and ingot smelting works correctly
- [ ] Tool head forging produces correct quantities (1 ingot → 2 heads)
- [ ] Iron tools assemble properly (head + stick → tool)
- [ ] Storage types accept correct resources
- [ ] Tool properties apply correct damage/speed/durability multipliers
- [ ] Localization strings display properly in UI
- [ ] No nil errors or missing resource references
- [ ] Load order prevents initialization crashes

---

## 9. Performance Impact

| Aspect | Impact | Notes |
|--------|--------|-------|
| Crafting Duration | No change | Same action repeats as bronze |
| Tool Effectiveness | +7-50% | Better stats, slightly slower |
| Storage Organization | Improved | 4 dedicated storage types |
| Code Complexity | Low | Reuses proven patterns |
| Memory Usage | Minimal | 2 extra storage type definitions |

---

## 10. Future Considerations

- Consider custom iron tool models instead of bronze placeholders
- Adjust multipliers based on gameplay balance feedback
- Add more specialized iron tool variants
- Implement iron armor/equipment when ready
