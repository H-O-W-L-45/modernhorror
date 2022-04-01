PLUGIN.name = "Custom Channel Names"
PLUGIN.author = "DoopieWop"
PLUGIN.description = "Creates radio channels without frequencies that everyone can see. Easily customizable."

PLUGIN.channels = {
	["r"] = {name = "[COMMS]", alias = {"/radio"}, prefixcolor = Color(55, 151, 255), textcolor = Color(215, 215, 255), filter = "radio"},
	["bnet"] = {name = "[BLOODNET]", alias = {"/bloodnet"}, prefixcolor = Color(255, 0, 0), textcolor = Color(255, 215, 215), filter = "radio"}
}

function PLUGIN:InitializedConfig()
	for k, v in pairs(self.channels) do
		v.alias = v.alias or {}

		table.Add(v.alias, {"/" .. k})

		if v.prefixcolor == nil then
			v.prefixcolor = Color(255,255,255)
		elseif type(v.prefixcolor) != "table" then
			v.prefixcolor = Color(255,255,255)
			ErrorNoHalt("Invalid prefix color for \'"..k.."\'!\n")
		end

		if v.textcolor == nil then
			v.textcolor = Color(255,255,255)
		elseif type(v.textcolor) != "table" then
			v.textcolor = Color(255,255,255)
			ErrorNoHalt("Invalid text color for \'"..k.."\'!\n")
		end

		if v.name == nil then
			v.name = "[UNKNOWN]"
		end

		nut.chat.register(k, {
			onChatAdd = function(speaker, text)
				chat.AddText(v.prefixcolor, v.name, " " .. speaker:Name() .. ": ", v.textcolor, text)
			end,
			prefix = v.alias,
			filter = v.filter or "ic"
		})
	end
end