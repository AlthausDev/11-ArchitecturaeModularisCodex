@echo off
REM === Architecturae Modularis Codex (AMC) ===
REM Estructura base de carpetas para Skyrim_MO2_Portable\mods

cd /d "G:\Skyrim Mods\Skyrim_MO2_Portable\mods"

REM 00 Foundations
mkdir "00b_SKSE_Frameworks"
mkdir "00c_AddressLibrary"
mkdir "00d_Utilities"
mkdir "00e_PowerofThree"

REM 01 Core Systems
mkdir "01a_UnofficialPatch"
mkdir "01b_EngineFixes"
mkdir "01c_DisplayTweaks"
mkdir "01d_BugFixes"
mkdir "01e_ScrambledBugs"

REM 02 Gameplay
mkdir "02a_Combat"
mkdir "02b_Magic"
mkdir "02c_Stealth"
mkdir "02d_AI"
mkdir "02e_Balance"
mkdir "02f_Survival"
mkdir "02g_Progression"

REM 03 Animation
mkdir "03a_Frameworks"
mkdir "03b_CombatAnimations"
mkdir "03c_IdlePoses"
mkdir "03d_CreatureAnimations"

REM 04 Visuals
mkdir "04a_Lighting"
mkdir "04b_Weather"
mkdir "04c_Textures"
mkdir "04d_Meshes"
mkdir "04e_VFX"
mkdir "04f_Performance"

REM 05 Audio
mkdir "05a_Music"
mkdir "05b_SFX"
mkdir "05c_Voices"
mkdir "05d_Ambience"

REM 06 UI
mkdir "06a_HUD"
mkdir "06b_Menus"
mkdir "06c_MCM"
mkdir "06d_Notifications"

REM 07 Quests_Stories
mkdir "07a_NewQuests"
mkdir "07b_QuestExpansions"
mkdir "07c_QuestTweaks"

REM 08 Locations
mkdir "08a_NewWorldspaces"
mkdir "08b_Dungeons"
mkdir "08c_Cities"
mkdir "08d_Towns"
mkdir "08e_PlayerHomes"

REM 09 NPCs_Creatures
mkdir "09a_Followers"
mkdir "09b_Enemies"
mkdir "09c_Citizens"
mkdir "09d_Creatures"
mkdir "09e_Population"

REM 10 Items_Equipment
mkdir "10a_Weapons"
mkdir "10b_Armor"
mkdir "10c_Artifacts"
mkdir "10d_Crafting"
mkdir "10e_Materials"
mkdir "10f_Consumables"

REM 11 Gameplay Additions
mkdir "11a_NewMechanics"
mkdir "11b_Features"
mkdir "11c_GuildsFactions"

REM 12 Adult
mkdir "12a_Frameworks"
mkdir "12b_Animations"
mkdir "12c_Addons"
mkdir "12d_NSFWQuests"

REM 13 Patches_Merges
mkdir "13a_MergedPlugins"
mkdir "13b_ConflictResolutions"
mkdir "13c_LoadOrderFixes"

REM 14 Overrides
mkdir "14a_LateFixes"
mkdir "14b_CosmeticOverrides"

REM 15 Testing_Debug
mkdir "15a_Experimental"
mkdir "15b_Tools"

REM 99 Unsorted
mkdir "99_Unsorted"

echo === Estructura AMC creada correctamente ===
pause
