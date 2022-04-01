PLUGIN.name = "NPC Item Drop"
PLUGIN.author = "Halokiller38"
PLUGIN.desc = "This plugin makes it when you kill a npc it drops something."

function PLUGIN:OnNPCKilled(entity)
	local class = entity:GetClass()

	if (class == "npc_vj_working_joe_hostile" or class == "npc_vj_mutant_watcher") then
		nut.item.spawn("randycore", entity:GetPos() + Vector(0, 0, 8))
	end
	if (class == "npc_vjanimal_eye_rat" or class == "npc_vj_mutant_watcher") then
		nut.item.spawn("ratmeat", entity:GetPos() + Vector(0, 0, 8))
	end
end