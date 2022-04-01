SCHEMA.name = "Modular Modern Horror RP"
SCHEMA.author = "Howl"
SCHEMA.desc = "Replace this in sh_schema in the modern/schema folder." -- this is useless since we use schemaDesc in the language files (shut the fuck up adaster)

-- This will make players drop their equipped weapons on death.
-- function SCHEMA:PlayerDeath( client )
    -- local items = client:getChar():getInv():getItems()
    -- for k, item in pairs( items ) do
        -- if item.isWeapon then
            -- if item:getData( "equip" ) then
                -- nut.item.spawn( item.uniqueID, client:GetShootPos(), function()
                    -- item:remove()
                -- end, Angle(), item.data )
            -- end
        -- end
    -- end
-- end

nut.chat.register("event", {
	onCanSay =  function(speaker, text)
		return speaker:IsAdmin()
	end,
	onCanHear = 10000000,
	onChatAdd = function(speaker, text)
		chat.AddText(Color(255, 0, 250), "", color_white, text)
	end,
	prefix = {"/ev"}
})

nut.currency.set("", "$", "$")

nut.util.include("sh_commands.lua")

nut.util.includeDir("hooks")

nut.config.add("chatRange", 440, "The maximum distance a person's IC chat message goes to.", nil, {
	form = "Float",
	data = {min = 10, max = 5000},
	category = "chat"
})

if SERVER then 
    util.AddNetworkString("PlayerAttributeAdminViewer")  
end

nut.command.add("viewattrib", {
    syntax = "<string playerName>",
    adminOnly = true,
    onRun = 
function(caller, args)
        if SERVER then
            local player = nut.command.findPlayer(caller, args[1])
            if (IsValid(player)) then
                local char = player:getChar()
                if (char) then
                    net.Start("PlayerAttributeAdminViewer")
                    net.WriteString(util.TableToJSON(char:getAttribs(),false))
                    net.WriteEntity(player)
                    net.Send(caller)

                end
            end 
         end
end})

ALWAYS_RAISED["gred_emp_empty"] = true

if CLIENT then  
    net.Receive("PlayerAttributeAdminViewer", function(len)
        local tbl = util.JSONToTable(net.ReadString() or {})
        PrintTable(tbl)

        local pnl = vgui.Create( "DFrame" )
        pnl:SetSize( 300, 500 )
        pnl:Center()
        pnl:MakePopup()
        pnl:SetTitle("Viewing Stats for " .. net.ReadEntity():Nick())
        local AppList = vgui.Create( "DListView", pnl )
        AppList:Dock( FILL )
        AppList:AddColumn( "Attribute" )
        AppList:AddColumn( "Value" )
        
        for i,v in pairs(tbl) do
            AppList:AddLine( i, v )
        end


    end)
end