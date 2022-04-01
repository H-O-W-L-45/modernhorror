local PLUGIN = PLUGIN

PLUGIN.name = "Player Connection Logs"
PLUGIN.author = "Cyumus and Adaster"
PLUGIN.desc = "Shows when a player connects and disconnects."

function PLUGIN:PlayerConnect(client, ip)
	for k,v in pairs(player.GetAll()) do
		v:ChatPrint(client.." has connected to the server.")
	end
end

function PLUGIN:PlayerDisconnected(client)
	PrintMessage(HUD_PRINTTALK, client:Name().." has disconnected from the server.")
end
	