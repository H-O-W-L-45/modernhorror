ITEM.name = "Drug Base"
ITEM.model = "models/healthvial.mdl"
ITEM.width = 1
ITEM.height = 1
ITEM.desc = "Makes you love dank memes"
ITEM.category = "Drugs"
ITEM.duration = 30
ITEM.effect = {"colormod1"}
if(SERVER) then 

	hook.Add("PostPlayerLoadout","effectrester", function(client)
		client:setLocalVar("colormod1",false)
		client:setLocalVar("bloom",false)
		client:setLocalVar("texturize1",false)
		client:setLocalVar("sobel1",false)
		client:setLocalVar("motionblur1",false)
		client:setLocalVar("sharpen1",false)
	end)
end
if(CLIENT) then
    local colormod1 = {
        [ "$pp_colour_addr" ] = 0.05,
        [ "$pp_colour_addg" ] = 0.02,
        [ "$pp_colour_addb" ] = 0.02,
        [ "$pp_colour_brightness" ] = 0,
        [ "$pp_colour_contrast" ] = 1,
        [ "$pp_colour_colour" ] = 2,
        [ "$pp_colour_mulr" ] = 0,
        [ "$pp_colour_mulg" ] = 0.5,
        [ "$pp_colour_mulb" ] = 0
    }
	    local colormod2 = {
        [ "$pp_colour_addr" ] = 0.02,
        [ "$pp_colour_addg" ] = 0.02,
        [ "$pp_colour_addb" ] = 0.04,
        [ "$pp_colour_brightness" ] = 0,
        [ "$pp_colour_contrast" ] = 1,
        [ "$pp_colour_colour" ] = 2,
        [ "$pp_colour_mulr" ] = 0,
        [ "$pp_colour_mulg" ] = 0.5,
        [ "$pp_colour_mulb" ] = 0
    }
	local pattern = Material("pp/texturize/rainbow.png")
	local pattern2 = Material("pp/texturize/rainbow.png")
	local pattern3 = Material("pp/texturize/plain.png")
    hook.Add( "PreDrawEffects", "drugsEffects", function()
		local ply = LocalPlayer()
        if(ply:getLocalVar("colormod1")) then //We are looking for variable so we can draw effect
            DrawColorModify(colormod1)
        end
		if(ply:getLocalVar("colormod2")) then //We are looking for variable so we can draw effect
            DrawColorModify(colormod2)
        end
	    if(ply:getLocalVar("bloom")) then
            DrawBloom( 0.65, 2, 9, 9, 1, 4, 1, 1, 1 )
        end
		if(ply:getLocalVar("bloom2")) then
            DrawBloom( 0.62, 2, 15, 2, 1, 12, 1, 2, 3 )
        end
	    if(ply:getLocalVar("bloom3")) then
            DrawBloom( 0.65, 2, 9, 9, 1, 2, 1, 1, 2 )
        end
		if(ply:getLocalVar("texturize1")) then
            DrawTexturize( 1, pattern )
        end
		if(ply:getLocalVar("texturize2")) then
            DrawTexturize( 1, pattern2 )
        end
		if(ply:getLocalVar("texturize3")) then
            DrawTexturize( 1, pattern3 )
        end
		if(ply:getLocalVar("sobel1")) then
            DrawSobel( 0.5 )
        end
		if(ply:getLocalVar("motionblur1")) then
            DrawMotionBlur( 0.4, 0.8, 0.01 )
        end
		if(ply:getLocalVar("sharpen1")) then
            DrawSharpen( 2.2, 0.9 )
        end		
		if(ply:getLocalVar("motionblur2")) then
            DrawMotionBlur( 0.7, 0.5, 0.05 )
        end
	    if(ply:getLocalVar("motionblur3")) then
            DrawMotionBlur( 0.4, 0.6, 0.05 )
        end
		if(ply:getLocalVar("overlay1")) then
            DrawMaterialOverlay( "effects/tp_eyefx/tpeye", -0.06 )
        end
    end )
end 
-- sorry, for name order.
ITEM.functions._use = { 
	name = "Use",
	tip = "useTip",
	icon = "icon16/color_wheel.png",
	onRun = function(item)
		local client = item.player
		local char = client:getChar()
		if (char and client:Alive()) then
			if (item.attribBoosts) then
				for k, v in pairs(item.attribBoosts) do
					char:addBoost(item.uniqueID, k, v)
				end
			end
			if(item.effect) then
				for _,v in pairs(item.effect) do
					client:setLocalVar(v,1)
				end
			end
			
			local charID = char:getID()
			local name = item.name
			timer.Create("DrugEffect_" .. item.uniqueID .. "_" .. client:EntIndex(), item.duration, 1, function()
				if (client and IsValid(client)) then
					local curChar = client:getChar()
					if (curChar and curChar:getID() == charID) then
						client:notify(Format("%s has worn off.", name))
						if(item.effect) then
							for _,v in pairs(item.effect) do
								client:setLocalVar(v,false)
							end
						end
						if (item.attribBoosts) then
							for k, v in pairs(item.attribBoosts) do
								char:removeBoost(item.uniqueID, k)
							end
						end
					end
				end
			end)
			
			return true
		end

		return false
	end,
	onCanRun = function(item)
		return (!IsValid(item.entity))
	end
}