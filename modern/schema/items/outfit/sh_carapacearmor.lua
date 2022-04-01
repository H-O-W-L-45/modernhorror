ITEM.name = "Super Duper Super Armor For Super Cool Super Men"
ITEM.desc = "it's just like, it's just like, a mini, mech!"
ITEM.price = 2500
ITEM.flag = "v"
ITEM.model = "models/Combine_Super_Soldier.mdl"
ITEM.width = 2
ITEM.armor = 100
ITEM.height = 2
ITEM.iconCam = {
	pos = Vector(-200, 0.77698647975922, 48.242790222168),
	ang = Angle(0, -0, 0),
	fov = 11.789551553782,
}
ITEM.replacements = "models/Combine_Super_Soldier.mdl"
ITEM.skin = 4
ITEM.newSkin = 4
ITEM.Category = "clothing"

function ITEM:onGetDropModel(item) return "models/props_c17/SuitCase_Passenger_Physics.mdl" end