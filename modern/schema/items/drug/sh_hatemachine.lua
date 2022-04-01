ITEM.name = "HATEMACHINE"
ITEM.model = "models/props_c17/TrapPropeller_Lever.mdl"
ITEM.desc = "A new drug on the market, or perhaps an old one re-discovered, HATEMACHINE has a rep for making its users feel almost indestructible, and is believed to be a result of leaked government medical intelligence. Horribly unhealthy, though -- perhaps worse than Slasher."
ITEM.duration = 100
ITEM.price = 2
ITEM.effect = {"colormod1", "sharpen1"}
ITEM.health = -15
ITEM.attribBoosts = {
	["stm"] = 55,
	["agl"] = 55,
	
}

local effectText = {
	"FEED THE FIRE. FEED THE FIRE. FEED THE FIRE.",
	"getupgetoutinthecityofdreamsgetupgetoutnowimsettinyoufree.",
	"ISYOURNOSERUNNINGWHOCARESLETSTEARDOWNTHETOWERSANDFIREUPTHEFLAMESAHHAHAHAHAHAH.",
	"we'll be IMMOR TAL IN THE COOOOOOOODEEEEEEEEEE",
	"AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA",
	"I'D RATHER DIE THAN GIVE YOU CONTROL.",
}
ITEM:hook("_use", function(item)
	item.player:EmitSound("physics/flesh/flesh_impact_bullet1.wav")
	item.player:SetHealth(item.player:Health() + item.health) --Give health to player when they consume
	item.player:notifyLocalized(table.Random(effectText))
	item.player:notifyLocalized("You stabbed yourself with the flask of "..item.name.." and lost "..item.health.." health.") --Send message to player
	item.player:ScreenFade(1, Color(215, 0, 0, 115), 3, 0)
	item.player:ViewPunch( Angle( 0, -20, 0 ) )
end)
