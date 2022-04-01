ITEM.name = "Neat Scotch with Honey"
ITEM.model = "models/props_junk/garbage_coffeemug001a.mdl"
ITEM.desc = "A glass of fine Scotch with a twist of honey. Howl's favorite drink."
-- I had to.
ITEM.width = 1
ITEM.height = 1
ITEM.health = 15
ITEM.price = 5
ITEM.duration = 100
ITEM.category = "Booze"
ITEM.effect = {"motionblur1", "bloom"}
ITEM.attribBoosts = {
	["end"] = -6,
	["str"] = 5,
}

local effectText = {
	"You feel the warm, smoky and spicy burn roll down your throat.",
	"A nice tingle rolls down your throat, and a fire burns in your tummy.",
	"Ah, that's some good peat.",
	"RIP Shock Magnum.",
	"Enjoy that one, kid?",
}
ITEM:hook("_use", function(item)
	item.player:EmitSound("npc/barnacle/barnacle_gulp1.wav")
	item.player:SetHealth(item.player:Health() + item.health) --Give health to player when they consume
	item.player:notifyLocalized(table.Random(effectText))
	item.player:notifyLocalized("You chugged down the "..item.name.." for "..item.health.." health.") --Send message to player
	item.player:ScreenFade(1, Color(11, 11, 11, 0), 3, 0)
	item.player:ViewPunch( Angle( 1, 0, 0 ) )
end)