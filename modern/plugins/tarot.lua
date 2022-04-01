PLUGIN.name = "Tarot Cards"
PLUGIN.author = "Howl, based on work by Chancer"
PLUGIN.desc = "Adds Tarot and MOTHERFUCKING UNO, IT CAME WITH FREE WITH YOUR FUCKING XBOX!"

nut.command.add("uno", {
	syntax = "<none>",
	onRun = function(client, arguments)
		local inventory = client:getChar():getInv()
		if (!inventory:hasItem("uno")) then
			client:notify("You do not have a deck of Uno cards.")
			return
		end

		local cards = {"0","1","2","3","4","5","6","7","8","9","Draw 2","Reverse Card","Skip Card","Wild Card"}
		local family = {"Green", "Red", "Blue", "Yellow"}
		
		local msg = "draws a " ..table.Random(family).. " " ..table.Random(cards).. " from the Uno deck"
		
		nut.chat.send(client, "rolld", msg)
	end
})
nut.command.add("tarot", {
	syntax = "<none>",
	onRun = function(client, arguments)
		local inventory = client:getChar():getInv()
		if (!inventory:hasItem("tarot")) then
			client:notify("You do not have a tarot deck.")
			return
		end

		local family = {"The Fool", "The Magician", "The High Priestess", "The Empress", "The Emperor", "The Hierophant", "The Lovers", "The Chariot", "Justice", "The Hermit", "The Wheel of Fortune", "Strength", "The Hanged Man", "Death", "Temperance", "The Devil", "The Tower", "The Star", "The Moon", "The Sun", "Judgement", "The World",}
		local fam2 = {"reversed position", "upright position"}
		
		local msg = "draws " ..table.Random(family).. " in the " ..table.Random(fam2)
		
		nut.chat.send(client, "rolld", msg)
	end
})
