PLUGIN.name = "Agility Attribute"
PLUGIN.author = "Wolfkann"
PLUGIN.desc = "Adds an Agility Attribute"

function PLUGIN:PostPlayerLoadout(client)
	
	character = client:getChar()
	
		if (character:getAttrib("agil", 0) == 45) then
			client:SetJumpPower( 250 )
			client:SetCrouchedWalkSpeed( 1 )
		else
			client:SetJumpPower( 200 + character:getAttrib("agil", 0))
			client:SetCrouchedWalkSpeed( 0.64 + (character:getAttrib("agil", 0) * 0.008 ) )
		end
	
end
