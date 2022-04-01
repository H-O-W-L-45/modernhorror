

function SCHEMA:PlayerSwitchFlashlight(client, state)
	local character = client:getChar()

	if (!character or !character:getInv()) then
		return false
	end

	if (character:getInv():hasItem("flashlight")) then
		return true
	end
end

-- Disable player spray.
function SCHEMA:PlayerSpray(client)
	return false
end