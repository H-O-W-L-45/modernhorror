ITEM.name = "Grenade"
ITEM.desc = "A weighty fragmentation grenade. This item will leave your inventory when used."
ITEM.price = 0
ITEM.category = "Weapons"
ITEM.model = "models/weapons/w_grenade.mdl"
ITEM.width = 1
ITEM.height = 1


ITEM.functions.Use = {
    onRun = function(item)
        local client = item.player
        client:Give("weapon_frag")
        client:EmitSound(" items/ammo_pickup.wav", 110)
        return true    
    end
	}