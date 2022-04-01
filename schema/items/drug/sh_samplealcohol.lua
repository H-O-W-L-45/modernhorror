--the item's name displayed in 3D2D and in the inventory.
ITEM.name = "Whiskey"
--model path. i suggest making sure your clients have your content as missing item models are a right pisser. this one is hl2 default for demonstration purposes.
ITEM.model = "models/props_junk/garbage_glassbottle002a.mdl"
--skin, for if your model has alternate skins. the fallout 4 content is what i normally use for my items hence why i have this here.
ITEM.skin = 0
--flag that can purchase this item. this is deprecated in my script b/c i don't have any trader classes, just admins to sell items. replace as you need.
ITEM.flag = "v"
--description for lore and information purposes. i went with a more lore-focused one.
ITEM.desc = "The strong scent of sugary corn mash hits your nostrils like a freight train. This stuff seems as rough as roper's boots. Fitting, eh?"
--item size in the inventory, horizontally and vertically.
ITEM.width = 1
ITEM.height = 1
--price in traders/vendors/business. this can be changed in vendors later though.
ITEM.price = 30
--health the item gives or subtracts. you can use negative values to subtract. i'm a functioning alcoholic and so are all my players' chars so this is a positive value
ITEM.health = 40
--how long the item lasts in seconds. by default this is 30 seconds but here it's 100. the value in the item overrides the base.
ITEM.duration = 100
--item category in business and adminspawnmenu if you have the plugin
ITEM.category = "Booze"
--visual effects on client. see the base for examples of effects.
ITEM.effect = {"motionblur1", "bloom"}
--attribute boosts in raw numbers. here you lose endurance (run duration) but gain strength. it'th juftht like my fallout gameth!
ITEM.attribBoosts = {
	["end"] = -5,
	["str"] = 25,
}

--random lore/internal monologue strings that fire upon use, alongside the notifylocalized line down below. 
--note the presence of two notifylocalized lines to make both fire. 
--remove the ones you don't want if you want only one to be fired.
local effectText = {
	"You feel like a cowboy, if only for a moment, before the nausea takes over.",
	"A guitar twangs somewhere in the distance. Or maybe that's just your head spinning.",
	"Yehheeehhahwakwdlshth prrarddnnererhshh",
	"Hoohoeeehghh chrehehermm greehvyy!!!",
	"FIhgfifi wasshznnn thammasanan wiwss ikkdkisss yayhh",
}
--effects on use. i only suggest changing the notifylocalized and sound paths. you can find default HL2 soundpaths here: https://wiki.facepunch.com/gmod/HL2_Sound_List
ITEM:hook("_use", function(item)
	item.player:EmitSound("npc/barnacle/barnacle_gulp1.wav")
	item.player:SetHealth(item.player:Health() + item.health) --Give health to player when they consume
	item.player:notifyLocalized(table.Random(effectText))
	item.player:notifyLocalized("You drank the bottle of "..item.name.." for "..item.health.." health.") --Send message to player
	item.player:ScreenFade(1, Color(11, 11, 11, 0), 3, 0)
	item.player:ViewPunch( Angle( 1, 0, 0 ) )
end)



