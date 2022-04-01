--the item's name displayed in 3D2D and in the inventory.
ITEM.name = "Chormsbornger"
--model path. i suggest making sure your clients have your content as missing item models are a right pisser. this one is gmod default.
ITEM.model = "models/food/burger.mdl"
--description for lore and descriptive purposes.
ITEM.desc = "This REALLY doesn't feel like food!"
--inventory size in vertical and horizontal strata
ITEM.width = 1
ITEM.height = 1
--here is where you would determine how much health it grants or removes. you can use negative values, but do not use decimal ones (0.1 etc) for safety's sake.
ITEM.health = 10
--here is the price as default in vendors, but you can always change it later.
ITEM.price = 1
--look at the base drug item for an example of effects you can use, and check the drugs base too.
ITEM.effect = {""}
--category in the buymenu and adminspawnmenu, if you have that addon.
ITEM.category = "Food"
--effects on use. i only suggest changing the notifylocalized and sound paths. you can find default HL2 soundpaths here: https://wiki.facepunch.com/gmod/HL2_Sound_List
ITEM:hook("_use", function(item)
	item.player:EmitSound("npc/barnacle/barnacle_crunch3.wav")
	item.player:SetHealth(item.player:Health() + item.health) --Give health to player when they consume
	item.player:notifyLocalized("You actually quite enjoy the taste of the "..item.name.." but lose "..item.health.." health.") 
	item.player:ViewPunch( Angle( 0.4, 0, 0 ) )
end)

