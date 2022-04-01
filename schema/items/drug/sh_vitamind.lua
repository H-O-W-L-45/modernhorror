ITEM.name = "Vitamide D"
ITEM.model = "models/props_lab/jar01b.mdl"
ITEM.desc = "A simple tablet containing an almost medically toxic amount of Vitamin D. Is it a good idea to take this? Probably."
ITEM.duration = 10
ITEM.price = 2
ITEM.effect = {""}
ITEM.attribBoosts = {
	["resist"] = 5
}

local effectText = {
	"You barely feel any different.",
	"Your legs are OK.",
}
ITEM:hook("_use", function(item)
	item.player:EmitSound("physics/flesh/flesh_impact_bullet1.wav")
	item.player:notifyLocalized(table.Random(effectText))
	item.player:ScreenFade(1, Color(255, 255, 255, 125), 3, 0)
end)
