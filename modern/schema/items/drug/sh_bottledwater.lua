ITEM.name = "Bottled Water"
ITEM.model = "models/props_junk/garbage_plasticbottle003a.mdl"
ITEM.skin = 0
ITEM.flag = "v"
ITEM.desc = "A simple bottle of mineral water."
ITEM.width = 1
ITEM.height = 1
ITEM.price = 1
ITEM.health = 35
ITEM.effect = {""}
ITEM.category = "Drink"
ITEM:hook("_use", function(item)
	item.player:EmitSound("npc/barnacle/barnacle_gulp1.wav")
	item.player:SetHealth(item.player:Health() + item.health) --Give health to player when they consume
	item.player:notifyLocalized("You chugged down the "..item.name.." for "..item.health.." health.") --Send message to player
	item.player:ViewPunch( Angle( 0.4, 0, 0 ) )
end)

