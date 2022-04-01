--the item's name displayed in 3D2D and in the inventory.
ITEM.name = "Slasher"
--model path. i suggest making sure your clients have your content as missing item models are a right pisser. this one is hl2 default for demonstration purposes.
ITEM.model = "models/props_c17/TrapPropeller_Lever.mdl"
--description for lore and descriptive purposes.
ITEM.desc = "A highly-addictive bathtub-brewed stimulant."
--how long the visual and statistic effects last in seconds. this is 30 by default but here i've made it last for 100 as Slasher, in my script, is a strong drug.
ITEM.duration = 100
--inventory size in vertical and horizontal strata
ITEM.width = 1
ITEM.height = 1
--here is the price as default in vendors, but you can always change it later.
ITEM.price = 2
--this references effects inside the drugs base to apply on the client on use, for the duration specified above.
ITEM.effect = {"colormod1", "sharpen1"}
--how much health is given or taken from the client in raw numbers. here i use a negative value because drugs is bad, mmmkay?
ITEM.health = -5
--attribute boosts in raw numbers. here your stamina will be boosted, giving you extra run speed
ITEM.attribBoosts = {
	["stam"] = 25
}

--random lore/internal monologue strings that fire upon use, alongside the notifylocalized line down below. 
--note the presence of two notifylocalized lines to make both fire. 
--remove the one you don't want if you want only one to be fired.
local effectText = {
	"This can't be good for you, but you feel great.",
	"You feel your bones start to rot from the inside out. And also hungry.",
	"If only Monster Energy felt this good, eh? Well, it'll also rot your teeth too.",
	"Winners don't do drugs, kid. But you feel like a fucking winner right now.",
	"Is your heart beating too fast? Who cares, you feel like you can punch a freight train.",
}
--effects on use. i only suggest changing the notifylocalized and sound paths. you can find default HL2 soundpaths here: https://wiki.facepunch.com/gmod/HL2_Sound_List
ITEM:hook("_use", function(item)
	item.player:EmitSound("physics/flesh/flesh_impact_bullet1.wav")
	item.player:SetHealth(item.player:Health() + item.health) --Give health to player when they consume
	item.player:notifyLocalized(table.Random(effectText))
	item.player:notifyLocalized("You stabbed yourself with "..item.name.." and lost "..item.health.." health.") --Send message to player
	item.player:ScreenFade(1, Color(215, 0, 0, 115), 3, 0)
	item.player:ViewPunch( Angle( 0, -20, 0 ) )
end)
