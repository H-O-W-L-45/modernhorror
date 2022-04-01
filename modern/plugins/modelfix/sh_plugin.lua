PLUGIN.name="Model fixes"
PLUGIN.author="dickmosi"
-- with significant edits by Howl
PLUGIN.desc="Fixes certain models that T-Pose by default"

--[[
citizen_male				A male NPC citizen model from Half-Life 2.
citizen_female			A female NPC citizen model from Half-Life 2.
metrocop					A metropolice NPC model from Half-Life 2.
overwatch					A Combine soldier NPC model from Half-Life 2.
vort							A vortigaunt NPC model from Half-Life 2.
player						A normal Garry's Mod player model. Player model paths normally start with nut.anim.setModelClass("models/player.
zombie						A zombie NPC model from Half-Life 2.
fastZombie				A fast zombie NPC model from Half-Life 2.
]]

-- howl's waifu models go here
-- this shortens the process; add a , between every model (EG "models/barney.mdl", "models/berney.mdl", etc) to add more to this bracket. This way you don't need lots of single rows.
-- Credits go to Tov for telling me how to do this
local modelList = {"models/barney.mdl"}
for _, v in pairs(modelList) do
  nut.anim.setModelClass(v, "player")
end

-- copypaste this and replace "player" if you have nonstandard models