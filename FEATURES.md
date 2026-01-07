# Arsenic Bronze Mod - Feature Summary

## ✅ CONFIRMED WORKING FEATURES

### 1. **Arsenic Poisoning System** ✓ TESTED & WORKING
- **Functionality**: Sapiens have a 40% chance of getting arsenic poisoning when smelting arsenic bronze ingots
- **Implementation**: Shadow file at `scripts/server/sapienAI/activeOrderAI.lua` intercepts the `smeltMetal` completion function
- **Effects When Triggered**:
  - Applies `minorFoodPoisoning` status effect for full food poisoning duration
  - Sends notification to player about arsenic exposure
  - Automatically creates a "treatFoodPoisoning" plan
  - Shows sapien name in log: "[Name] POISONED by arsenic fumes!"
- **Technical Details**:
  - Only triggers on `arsenicBronzeIngot` completion
  - Checks existing poisoning status (won't apply if already poisoned)
  - Uses vanilla food poisoning treatment system
  - Notification references both `arsenicBronzeIngot` and `arsenicOre` for clarity

### 2. **Complete Material System** ✓
- **Arsenic Ore**: Greenish mineral resource spawning in world
- **Arsenic Bronze Material**: Custom alloy with vec3(0.25, 0.32, 0.18) greenish tint
- **Performance Multipliers**: All tools 1.6× better than bronze (2.56× for axe tree chopping)

### 3. **Full Tool Set** ✓ VISIBLE & FUNCTIONAL
All 6 finished tools spawn correctly with proper greenish color:
- ✓ Arsenic Bronze Knife (metalKnife base model)
- ✓ Arsenic Bronze Chisel (metalChisel base model)
- ✓ Arsenic Bronze Axe (bronzeHatchet base → arsenicHatchet remap)
- ✓ Arsenic Bronze Spear (bronzeSpear → arsenicSpear)
- ✓ Arsenic Bronze Hammer (bronzeHammer → arsenicHammer)
- ✓ Arsenic Bronze Pickaxe (bronzePickaxe → arsenicPickaxe)

### 4. **Crafting System** ✓
- **Arsenic Bronze Ingot**: Smelted from arsenic ore + tin ore + copper ore (produces 3 ingots)
- **Tool Heads**: 4 metal heads (axe, pickaxe, spear, hammer) crafted at kiln (2 each)
- **Direct Tools**: Knife and chisel smithed directly at kiln (2 each, no head/assembly)
- **Assembled Tools**: Axe/pickaxe/spear/hammer assembled from head + branch at craft area
- **Recipe Visibility**: All recipes require blacksmithing skill and use `disabledUntilCraftableResearched = true`

### 5. **Storage System** ✓
Dedicated storage containers for:
- Arsenic ore
- Arsenic bronze ingots
- Iron ore (bonus)
- Iron ingots (bonus)

---

## TECHNICAL IMPLEMENTATION NOTES

### Model Remap Pattern (Critical Discovery)
Three-layer system for finished tools:
1. **gameObject.lua**: Defines modelName (custom or base)
   - Assembled tools: `arsenicHatchet`, `arsenicSpear`, etc.
   - Direct tools: `metalKnife`, `metalChisel`
2. **craftable.lua**: `addGameObjectInfo` overrides with vanilla base names
   - Assembled: `bronzeHatchet`, `bronzeSpear`, etc.
   - Direct: `metalKnife`, `metalChisel` (same as gameObject)
3. **model.lua**: Remaps from vanilla/base to custom with `arsenicBronze` material
   - `model.remapModels.bronzeHatchet.arsenicHatchet = { metal = "arsenicBronze" }`

### Shadow File Structure (Arsenic Poisoning)
- **Location**: `scripts/server/sapienAI/activeOrderAI.lua` (NOT in patches/)
- **Pattern**: `mod:onload(activeOrderAI)` with super function saved
- **Key Insight**: Server modules (`serverGOM`, `serverStatusEffects`, `planManager`) must be required INSIDE the completion function, not at module level
- **Load Order**: 1 (loads early to catch all smelting operations)

### Vanilla Nomenclature
- Axes are called "Hatchet" in vanilla code (`bronzeHatchet`, not `bronzeAxe`)
- Knife and chisel use generic metal base models (`metalKnife`, `metalChisel`)
- Only axe/pickaxe/spear/hammer use the head+branch assembly pattern

---

## CHANGELOG

**Version 1.0.0 - January 7, 2026**
- ✅ Arsenic poisoning system confirmed working (40% chance)
- ✅ All 6 tools visible with correct greenish arsenicBronze color
- ✅ Complete crafting chain functional (ore → ingots → heads/tools)
- ✅ Recipe visibility fixed (blacksmithing requirement + research flag)
- ✅ Storage containers implemented
- ✅ Material system with proper tints and multipliers

---

## KNOWN ISSUES
None currently - all core features tested and working!

---

## CREDITS
- **Architecture & Design**: Yaz
- **Implementation & Coding**: GitHub Copilot
- **Testing**: Yaz
