ITEM.name = "Jolter"
ITEM.model = "models/props_c17/TrapPropeller_Lever.mdl"
ITEM.desc = "A crazy invention of stim heads. A homemade neurostimulatory shock device, with a secondary injector that contains a tiny amount of Slasher. Very painful to use."
ITEM.duration = 100
ITEM.price = 30
ITEM.effect = {"sharpen1"}
ITEM.health = -15
ITEM.attribBoosts = {
	["stm"] = 50,
	["str"] = -5,
	["end"] = 50,
}

local effectText = {
	"Your entire body judders as you jam several volts of electricity into yourself.",
	"Fuck, that hurts! Still, you feel very invigorated.",
	"Ouch and a fucking half. That really stung, even if it left you buzzing.",
}
ITEM:hook("_use", function(item)
	item.player:EmitSound("physics/flesh/flesh_impact_bullet1.wav")
	item.player:EmitSound("npc/scanner/scanner_electric1.wav")
	item.player:SetHealth(item.player:Health() + item.health) --Give health to player when they consume
	item.player:notifyLocalized(table.Random(effectText))
	item.player:notifyLocalized("You poked yourself with "..item.name.." for "..item.health.." health. You nutter.") --Send message to player
    item.player:ScreenFade(1, Color(255, 255, 255, 255), 1, 0)
	item.player:ViewPunch( Angle( -10, 0, 0 ) )
end)
