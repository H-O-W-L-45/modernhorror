PLUGIN.name="Add Items To Factions"
PLUGIN.author="Howl"
PLUGIN.desc="Adds faction weapons or items to factions."


 -- Copy the below table and edit it to add new factions etc etc.
 
function PLUGIN:OnCharCreated(client, character)
    local inventory = character:getInv()

    if (inventory) then        
        if (character:getFaction() == FACTION_WANDERER) then
            inventory:add("tophat", 1)
			
			
        end
    end
end
