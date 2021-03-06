PLUGIN.name = "Spooky Commands"
PLUGIN.author = "Chancer & Angelsaur"
PLUGIN.desc = "Some commands that do spooky things to people."

	if (SERVER) then
		util.AddNetworkString( "MannStart" )
		util.AddNetworkString( "MannEnd" )
		util.AddNetworkString( "MannStart2" )
		util.AddNetworkString( "MannStart3" )
		util.AddNetworkString( "Flicker" )
		util.AddNetworkString( "LightsOn" )
		util.AddNetworkString( "LightsOff" )
	end
	
if (CLIENT) then
	surface.CreateFont( "SPOOKFont", {
		font = "Consolas",
		extended = false,
		size = 160,
		weight = 1000,
		blursize = 5,
		antialias = true,
	} )

	local Mannequin = false

	local cache = { }
	timercache = { }
	soundcache = { }
	modelcache = { }
		
	local CreatePhysModel = function(mdl)
		local ent = ents.CreateClientProp()
		ent:SetModel(mdl)
		ent:PhysicsInit(SOLID_VPHYSICS)
		ent:SetMoveType(MOVETYPE_VPHYSICS)
		ent:SetSolid(SOLID_VPHYSICS)

		table.insert(modelcache, ent)

		return ent
	end
			
	local CreateModel = function(mdl, isragdoll)
		local ent

		if isragdoll then
			ent = ClientsideRagdoll(mdl)
		else
			ent = ClientsideModel(mdl, RENDERGROUP_OTHER)
		end
	  
		table.insert(modelcache, ent)
	  
		return ent
	end

	local AddSound = function(name)
		local snd = CreateSound(LocalPlayer(), name)
	  
		table.insert(soundcache, snd)
	  
		return snd
	end

	local NewHookAdd = function(str, name, func)
		--name = "dronesrewrite_hell_hooks" .. name
		hook.Add(str, name, func)
	  
		table.insert(cache, {
			str = str,
			name = name
		})
	end

	local NewTimerSimple = function(time, func)
		local name = "dronesrewrite_hell_timers" .. table.Count(timercache)
		timer.Create(name, time, 1, func)
	  
		table.insert(timercache, {
			name = name
		})
	end

	local StopTimers = function() for k, v in pairs(timercache) do timer.Destroy(v.name) end end
	local RemoveHooks = function() for k, v in pairs(cache) do hook.Remove(v.str, v.name) end end
	local StopSounds = function() for k, v in pairs(soundcache) do if v then v:Stop() end end end
	local RemoveModels = function() for k, v in pairs(modelcache) do SafeRemoveEntity(v) end end
	
	function EndMannequin()
		
		if IsValid(Noise) then Noise:Stop() end
			
			RemoveHooks()
			StopTimers()
			StopSounds()
			RemoveModels()
			
			hook.Remove("PreDrawHUD", "dronesrewrite_hell_flicker")
			hook.Remove( "HUDPaint", "BlackOut" )
			hook.Remove("Think", "TwitchFX")
			 
			-- LocalPlayer():ScreenFade( SCREENFADE.IN, Color( 0, 0, 0, 255 ), 1, 1 )
			Mannequin = false
		end
	
	local function EnableMann()
		local Models = { }
		local Scrap = { }
		
		local function Flicker()
			NewHookAdd("PreDrawHUD", "dronesrewrite_hell_flicker", function()
				local TEMP_BLUR = Material("effects/flicker_256")

				cam.Start2D()
					local x, y = 0, 0
					local scrW, scrH = ScrW(), ScrH()
					surface.SetDrawColor(255, 255, 255)
					surface.SetMaterial( TEMP_BLUR )		
					for i = 1, 3 do
						TEMP_BLUR:SetFloat("$blur", (i / 1) * 15)
						TEMP_BLUR:Recompute()
						render.UpdateScreenEffectTexture()
						surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
					end
				cam.End2D()
			end)
		end
		
		local function Debris()
			NewHookAdd("Think", "debris", function()
				local emitter = ParticleEmitter(Vector(0, 0, 0))	  
					 
				local vec = VectorRand() * 500
				vec.z = math.abs(vec.z)

				local p = emitter:Add("particle/smokesprites_000" .. math.random(1, 9), LocalPlayer():GetPos() + vec)
				
				p:SetDieTime(2)
				p:SetStartAlpha(25)
				p:SetEndAlpha(0)
				p:SetStartSize(math.random(800, 1200))
				p:SetRoll(math.Rand(-10, 10))
				p:SetRollDelta(math.Rand(-1, 1))
				p:SetEndSize(10)   
				p:SetCollide(true)
				p:SetGravity(Vector(0, 0, -20))
				p:SetColor(255, 0, 0)
			end)
		end

		local function DarkScreen()
			NewHookAdd("HUDPaint", "BlackOut", function()
				surface.SetDrawColor( 0, 0, 0, 240 )
				surface.DrawRect( 0, 0, ScrW(), ScrH() )
			end)
		end

		local function ScreenNoise()
			NewHookAdd("RenderScreenspaceEffects", "Noise", function()
				DrawMaterialOverlay("effects/tvscreen_noise002a", 0)
			end)
		end		

		local function CenterText()
			local value = 0;

			local targetValue = 255;

			local speed = 5;
			
			value = Lerp( speed * FrameTime( ), value, targetValue );

			local whispers = {
				"WHERE ARE YOU GOING?",
				"WHERE ARE YOU GOING?",
				"WHERE ARE YOU GOING?",
				"WHERE ARE YOU GOING?",
				"WHERE ARE YOU GOING?",
				"WHERE ARE YOU GOING?",
				"WHERE ARE YOU GOING?",
				"WHERE ARE YOU GOING?",
				"WHERE ARE YOU GOING?",
				"WHERE ARE YOU GOING?",
				"WHERE ARE YOU GOING?",
				"I see you.",
				"Your planet is dead.",
				"You're mine.",
				"I have you.",
				"I found you.",
			}

			WhisperSpook = table.Random( whispers )
			WhisperSpookEnd = CurTime() + 2.5;
			
			NewHookAdd("HUDPaint", "DrawTextCenter", function()
				local w,h = ScrW(),ScrH()
				surface.SetDrawColor ( 0, 0, 0, 255 )
				surface.DrawRect ( 0, 0, w, h / 7 )
				
				local w,h = ScrW(),ScrH()
				surface.SetDrawColor ( 0, 0, 0, 255 )
				surface.DrawRect ( 0, 930, w, h / 7 )

				if CurTime() <= WhisperSpookEnd then
					draw.DrawText( WhisperSpook, "SPOOKFont", ScrW() * 0.5, ScrH() * 0.40, Color(math.random(25,255), 0, 0, math.random(15,255) ), TEXT_ALIGN_CENTER )
				end
			end)
		end

		local function ColorFX()
			local cfx = {
				["$pp_colour_addr"] = -0.12,
				["$pp_colour_addg"] = -0.12,
				["$pp_colour_addb"] = -0.12,
				["$pp_colour_brightness"] = -0.02,
				["$pp_colour_contrast"] = 1,
				["$pp_colour_colour"] = 0.20,
				["$pp_colour_mulr"] = 0,
				["$pp_colour_mulg"] = 0,
				["$pp_colour_mulb"] = 0.5
			}

			local Const = 0.5

			NewHookAdd("RenderScreenspaceEffects", "ScreenColor", function()
				DrawColorModify( cfx ) 
				DrawBloom( 0, 1, 10, 10, 1, 0.3, 0.5, 0.5, 0.5 )
				DrawMotionBlur(Const * 0.5, Const, Const * 0.01)
			end)
		end

		local function Mann()
			local halluc

			local pos = LocalPlayer():GetPos() + Vector(0, 0, 100)
			local ang = Angle(0, LocalPlayer():GetAngles().y, 0)

			local tr = util.TraceLine({
				start = pos,
				endpos = pos + ang:Forward() * math.random(60,300),
				filter = LocalPlayer(), function( ent ) 
					if ( ent:GetClass() == "prop_physics" ) then 
						return true
					end 
				end
			})

			local rag_pos = tr.HitPos + tr.HitNormal * 32 - Vector(0, 0, 100)

			if not halluc then
				halluc = CreateModel("models/humans/group01/male_cheaple.mdl")
				halluc:SetModelScale(1, 0)
				halluc:SetAngles(ang + Angle(0, 180, 0))
				halluc:SetColor(Color(0,0,0))
				halluc:SetRenderFX(kRenderFxDistort)
				halluc:SetPos(rag_pos)
				halluc:Spawn()
				halluc:SetSequence("idle_all_02")	
				
			end
		end
	
		util.ScreenShake(LocalPlayer():GetPos(), 5, 15, 5, 1000)

		Debris()
		ColorFX()
		CenterText()
		
		timer.Simple(0, function() DarkScreen() Mann()  end)
		timer.Simple(0.1, function() RemoveModels() end)
		timer.Simple(0.2, function() DarkScreen() Mann()  end)
		timer.Simple(0.3, function() RemoveModels()  end)
		timer.Simple(0.4, function() DarkScreen() Mann()  end)
		timer.Simple(0.5, function() RemoveModels()  end)
		timer.Simple(0.6, function() DarkScreen() Mann() end)
		timer.Simple(0.7, function() RemoveModels()  end)
		timer.Simple(0.8, function() DarkScreen() Mann() end)
		timer.Simple(0.9, function() RemoveModels() end)
		timer.Simple(1.0, function() DarkScreen() Mann() end)
		timer.Simple(1.5, function() RemoveModels() end)
		timer.Simple(1.8, function() DarkScreen() Mann()  end)
		timer.Simple(2.2, function() RemoveModels() end)
	end
		
	local function DoMannequin()
		if Mannequin then return end
		
		Mannequin = true
		-- LocalPlayer():ScreenFade( SCREENFADE.IN, Color( 0, 0, 0, 255 ), 1, 0 )		
		EnableMann()
		
		sound.Play("respite/scream.wav", LocalPlayer():GetPos(), 60, 100, 1) 
	end

	local function FlickerScreen()
		local function DarkScreen()
			NewHookAdd("HUDPaint", "BlackOut", function()
				surface.SetDrawColor( 0, 0, 0, 100 )
				surface.DrawRect( 0, 0, ScrW(), ScrH() )
				end)
			end
	
		local function ColorFX()
			local cfx = {
				["$pp_colour_addr"] = -0.18,
				["$pp_colour_addg"] = -0.14,
				["$pp_colour_addb"] = -0.10,
				["$pp_colour_brightness"] = -0.05,
				["$pp_colour_contrast"] = 1.45,
				["$pp_colour_colour"] = 0.25,
				["$pp_colour_mulr"] = 0,
				["$pp_colour_mulg"] = 0,
				["$pp_colour_mulb"] = 0
			}
			
			NewHookAdd("RenderScreenspaceEffects", "ScreenColor", function()
				DrawColorModify( cfx ) 
			end)
		end

		local sndlevel = 90
		local sndpitch = math.random(75,115)
	
		timer.Simple(0, function() DarkScreen() ColorFX() sound.Play("ambient/energy/spark6.wav", LocalPlayer():GetPos(), sndlevel, sndpitch, 1) end)
		timer.Simple(0.2, function() hook.Remove( "HUDPaint", "BlackOut" ) hook.Remove( "RenderScreenspaceEffects", "ScreenColor" ) end)
		timer.Simple(0.4, function() DarkScreen() ColorFX() sound.Play("ambient/energy/spark4.wav", LocalPlayer():GetPos(), sndlevel, sndpitch, 1) end)
		timer.Simple(0.6, function() hook.Remove( "HUDPaint", "BlackOut" ) hook.Remove( "RenderScreenspaceEffects", "ScreenColor" ) end)
		timer.Simple(0.8, function() DarkScreen() ColorFX() sound.Play("ambient/energy/spark3.wav", LocalPlayer():GetPos(), sndlevel, sndpitch, 1) end)
		timer.Simple(1.0, function() hook.Remove( "HUDPaint", "BlackOut" ) hook.Remove( "RenderScreenspaceEffects", "ScreenColor" ) end)
		timer.Simple(1.1, function() DarkScreen() ColorFX() sound.Play("ambient/energy/spark1.wav", LocalPlayer():GetPos(), sndlevel, sndpitch, 1) end)
		timer.Simple(1.2, function() hook.Remove( "HUDPaint", "BlackOut" ) hook.Remove( "RenderScreenspaceEffects", "ScreenColor" ) end)
		timer.Simple(1.5, function() DarkScreen() ColorFX() sound.Play("ambient/energy/spark5.wav", LocalPlayer():GetPos(), sndlevel, sndpitch, 1) end)
		timer.Simple(5, function() 
		hook.Remove( "HUDPaint", "BlackOut" )
		hook.Remove( "RenderScreenspaceEffects", "ScreenColor" )
		sound.Play("ambient/energy/spark2.wav", LocalPlayer():GetPos(), sndlevel, sndpitch, 1) end)
	end

	net.Receive( "MannStart", function()
		local target = net.ReadEntity()
		DoMannequin()
	end )

	net.Receive( "MannEnd", function()
		local target = net.ReadEntity()
		EndMannequin()
	end )

	net.Receive( "Flicker", function()
		local target = net.ReadEntity()
		FlickerScreen()
	end )


	local function EnableMann2()
		local Models = { }

		local function DarkScreen()
			NewHookAdd("HUDPaint", "BlackOut", function()
				surface.SetDrawColor( 0, 0, 0, math.random(0,255) )
				surface.DrawRect( 0, 0, ScrW(), ScrH() )
			end)
		end

		local function CenterText()
			local whispers = {
				"WHY ME?",
				"I KNOW WHAT YOU DID.",
				"I'M HERE NOW.",
				"THE PIPES ARE SCREAMING.",
				"THE WATER IS TAINTED.",
				"DON'T FORGET ME.",
				"PLEASE LET ME GO.",
				"I WANT TO COME BACK.",
				"I WANT MY MOMMY",
				" i want my mommy",
			}

			WhisperSpook = table.Random( whispers )
			WhisperSpookEnd = CurTime() + 3

			NewHookAdd("HUDPaint", "DrawTextCenter", function()
				local w,h = ScrW(),ScrH()
				surface.SetDrawColor ( 0, 0, 0, 255 )
				surface.DrawRect ( 0, 0, w, h / 7 )
				
				local w,h = ScrW(),ScrH()
				surface.SetDrawColor ( 0, 0, 0, 255 )
				surface.DrawRect ( 0, 930, w, h / 7 )

				if CurTime() <= WhisperSpookEnd then
					draw.DrawText( WhisperSpook, "SPOOKFont", ScrW() * 0.5, ScrH() * 0.40, Color(math.random(25,255), 0, 0, math.random(100,255) ), TEXT_ALIGN_CENTER )
				end
			end)
		end

		local function ColorFX()
			local cfx = {
				["$pp_colour_addr"] = -0.10,
				["$pp_colour_addg"] = -0.10,
				["$pp_colour_addb"] = -0.06,
				["$pp_colour_brightness"] = 0,
				["$pp_colour_contrast"] = 2,
				["$pp_colour_colour"] = 0,
				["$pp_colour_mulr"] = 0,
				["$pp_colour_mulg"] = 0,
				["$pp_colour_mulb"] = 0
			}

			NewHookAdd("RenderScreenspaceEffects", "ScreenColor", function()
				DrawColorModify( cfx ) 
				end)
			end

			local function Mann2()
				local halluc
				local pos = LocalPlayer():GetPos() + Vector(0, 0, 100)
				local ang = Angle(0, LocalPlayer():GetAngles().y, 0)

				local tr = util.TraceLine({
					start = pos,
					endpos = pos + ang:Forward() * 65,
					filter = LocalPlayer(), function( ent ) 
						if ( ent:GetClass() == "prop_physics" ) then 
							return true
						end 
					end
				})

				local rag_pos = tr.HitPos + tr.HitNormal * 32 - Vector(0, 0, 100)

				if not halluc then
					halluc = CreateModel("models/humans/group01/male_cheaple.mdl")
					halluc:SetModelScale(1, 0)
					halluc:SetAngles(ang + Angle(0, 180, 0))
					halluc:SetPos(rag_pos)
					halluc:Spawn()
					halluc:SetBodygroup( 1, 1 )
					halluc:SetBodygroup( 2, 1 )
					halluc:SetSkin("0")
					halluc:SetSequence("idle_all_02")
				    halluc:SetColor(Color(55,55,55))				

					hook.Add("Think", "TwitchFX", function() 
						if halluc:IsValid() then 
							local NeckBone2 = halluc:LookupBone("valvebiped.bip01_head1")
							local HeadBone2 = halluc:LookupBone("valvebiped.bip01_neck1")

							local TEMP_HeadAng = Angle(0,0,0)
							local TEMP_HeadPos = Vector(0,0,0)
							local TEMP_NeckAng = Angle(0,0,0)
							local TEMP_NeckPos = Vector(0,0,0)

							TEMP_HeadAng = Angle(0,0,0)
							TEMP_HeadPos = Vector(0,0,0)
							TEMP_NeckAng = Angle(0,0,0)
							TEMP_NeckPos = Vector(0,0,0)

							local twitch_ang1 = math.random( -30, 30 )

							TEMP_HeadAng = TEMP_HeadAng + Angle( twitch_ang1, twitch_ang1, twitch_ang1 )
							TEMP_NeckAng = TEMP_HeadAng + Angle( twitch_ang1, 0, 0 ) 
							
							halluc:ManipulateBoneAngles( HeadBone2, TEMP_HeadAng )
							--halluc:ManipulateBonePosition( HeadBone2, TEMP_HeadPos )
							halluc:ManipulateBoneAngles( NeckBone2, TEMP_NeckAng )
						end 
					end)
				end
			end

			ColorFX()
			CenterText()
			Mann2() 

			util.ScreenShake(LocalPlayer():GetPos(), 5, 5, 3, 1000)

			timer.Simple(1.8, function() EndMannequin() end)
		end

		local function Appear()
		
			if Mannequin then return end
			
			Mannequin = true
			-- LocalPlayer():ScreenFade( SCREENFADE.IN, Color( 0, 0, 0, 255 ), 1, 0 )		
			EnableMann2()

			sound.Play("ambient/atmosphere/hole_hit1.wav", LocalPlayer():GetPos(), 75, 100, 1) 

		end
			
		net.Receive( "MannStart2", function()
			local target = net.ReadEntity()
			Appear()	
		end )

		local function EnableMann3()
			local Models = { }
		
			local function DarkScreen()
				NewHookAdd("HUDPaint", "BlackOut", function()
					surface.SetDrawColor( 0, 0, 0, 250 )
					surface.DrawRect( 0, 0, ScrW(), ScrH() )
					end)
				end
		
			local function CenterText()
				local whispers = {
					"End.",
					"Fall.",
					"Crawl.",
					"Anger.",
					"I see you.",
					"Get away.",
					"Go home.",
					"Kill.",
					"Leave.",
					"Die.",
					"Help.",
					"Suffer.",
					"Consume.",
					"Return.",
					"Drain.",
					"Steal.",
					"Stay.",
					"Scream.",
					"I have you.",
					"I found you.",
					"Don't move.",
					"Give in.",
					"Don't run.",
					"Don't leave.",
					"Perish."
				}
			
				WhisperSpook = table.Random( whispers )
				WhisperSpookEnd = CurTime() + 3;
				
				NewHookAdd("HUDPaint", "DrawTextCenter", function()
					local w,h = ScrW(),ScrH()
					surface.SetDrawColor ( 0, 0, 0, 255 )
					surface.DrawRect ( 0, 0, w, h / 7 )
					
					local w,h = ScrW(),ScrH()
					surface.SetDrawColor ( 0, 0, 0, 255 )
					surface.DrawRect ( 0, 930, w, h / 7 )
			
					if CurTime() <= WhisperSpookEnd then
				
						draw.DrawText( WhisperSpook, "SPOOKFont", ScrW() * 0.5, ScrH() * 0.40, Color(math.random(25,255), 0, 0, math.random(15,255) ), TEXT_ALIGN_CENTER )
					end
				end)
			end
		
			local function ColorFX()
				local cfx = {
					["$pp_colour_addr"] = -0.05,
					["$pp_colour_addg"] = -0.05,
					["$pp_colour_addb"] = -0.05,
					["$pp_colour_brightness"] = 0,
					["$pp_colour_contrast"] = 2,
					["$pp_colour_colour"] = 0,
					["$pp_colour_mulr"] = 0,
					["$pp_colour_mulg"] = 0,
					["$pp_colour_mulb"] = 0
				}
		
				NewHookAdd("RenderScreenspaceEffects", "ScreenColor", function()
					DrawColorModify( cfx ) 
					end)
				end

			local function Mann3()

			local halluc
			local pos = LocalPlayer():GetPos() + Vector(0, 0, 100)
			local ang = Angle(0, LocalPlayer():GetAngles().y, 0)

			local tr = util.TraceLine({
				start = pos,
				endpos = pos + ang:Forward() * 65,
				filter = LocalPlayer(), function( ent ) 
					if ( ent:GetClass() == "prop_physics" ) then 
					return true
				end 
			end
			})

			local rag_pos = tr.HitPos + tr.HitNormal * 32 - Vector(0, 0, 100)

			if not halluc then

				halluc = CreateModel("models/humans/group01/male_cheaple.mdl")
				halluc:SetModelScale(1, 0)
				halluc:SetAngles(ang + Angle(0, 180, 0))
				halluc:SetPos(rag_pos)
				halluc:Spawn()
				halluc:SetSequence("idle")	
				hook.Add("Think", "TwitchFX", function() 
					if halluc:IsValid() then 

						local NeckBone2 = halluc:LookupBone("mixamorig:Head")
						local HeadBone2 = halluc:LookupBone("mixamorig:Neck")

						local TEMP_HeadAng = Angle(0,0,0)
						local TEMP_HeadPos = Vector(0,0,0)
						local TEMP_NeckAng = Angle(0,0,0)
						local TEMP_NeckPos = Vector(0,0,0)

						TEMP_HeadAng = Angle(0,0,0)
						TEMP_HeadPos = Vector(0,0,0)
						TEMP_NeckAng = Angle(0,0,0)
						TEMP_NeckPos = Vector(0,0,0)

						local twitch_ang1 = math.random( -30, 30 )

						TEMP_HeadAng = TEMP_HeadAng + Angle( twitch_ang1, twitch_ang1, twitch_ang1 )
						TEMP_NeckAng = TEMP_HeadAng + Angle( twitch_ang1, 0, 0 ) 
						
						halluc:ManipulateBoneAngles( HeadBone2, TEMP_HeadAng )
						--halluc:ManipulateBonePosition( HeadBone2, TEMP_HeadPos )
						halluc:ManipulateBoneAngles( NeckBone2, TEMP_NeckAng )
					end 
				end)
			end
		end

			ColorFX()
			CenterText()
			Mann3() 
	
			util.ScreenShake(LocalPlayer():GetPos(), 5, 5, 3, 1000)
	
			timer.Simple(0, function() DarkScreen() end)
			timer.Simple(0.2, function() DarkScreen() end)
			timer.Simple(0.3, function() hook.Remove( "HUDPaint" )  end)
			timer.Simple(0.4, function() DarkScreen() end)
			timer.Simple(0.5, function() hook.Remove( "HUDPaint" )  end)
			timer.Simple(0.6, function() DarkScreen() end)
			timer.Simple(0.7, function() hook.Remove( "HUDPaint" )  end)
			timer.Simple(0.8, function() DarkScreen() end)
			timer.Simple(0.9, function() hook.Remove( "HUDPaint" ) end)
			timer.Simple(1.0, function() DarkScreen() end)
			timer.Simple(1.2, function() hook.Remove( "HUDPaint" ) end)
			timer.Simple(1.4, function() DarkScreen() end)
			timer.Simple(2.0, function() EndMannequin() end)
		
		end
			
		
		local function Appear()
		
			if Mannequin then return end
			
			Mannequin = true
			-- LocalPlayer():ScreenFade( SCREENFADE.IN, Color( 0, 0, 0, 255 ), 1, 0 )		
			EnableMann3()
	
			sound.Play(" ambient/atmosphere/hole_hit1.wav", LocalPlayer():GetPos(), 75, 100, 1) 
	
		end
		
	net.Receive( "MannStart3", function()
		local target = net.ReadEntity()
		Appear()	
	end )

	net.Receive( "LightsOff", function()
		local target = net.ReadEntity()
		TurnLightsOff()
	end )

	net.Receive( "LightsOn", function()
		local target = net.ReadEntity()
		TurnLightsOn()
	end )

	--isOutside = StormFox.Env.IsOutside() or StormFox.Env.NearOutside()
	
	function TurnLightsOn()		

		local sndlevel = 80
		local sndpitch = math.random(100,115)
		
		timer.Simple(0, function() hook.Remove( "RenderScreenspaceEffects", "ScreenColor2" ) hook.Remove( "HUDPaint", "LightsOut1" ) end)
		timer.Simple(0.2, function() DarkScreen() sound.Play("ambient/energy/spark2.wav", LocalPlayer():GetPos(), sndlevel, sndpitch, 1) end)
		timer.Simple(0.4, function() hook.Remove( "RenderScreenspaceEffects", "ScreenColor2" ) hook.Remove( "HUDPaint", "LightsOut1" ) end)
	
	end

	function DarkScreen()
	
			local cfx = {
				["$pp_colour_addr"] = -0.10,
				["$pp_colour_addg"] = -0.10,
				["$pp_colour_addb"] = -0.10,
				["$pp_colour_brightness"] = 0,
				["$pp_colour_contrast"] = 1,
				["$pp_colour_colour"] = 0.15,
				["$pp_colour_mulr"] = 0,
				["$pp_colour_mulg"] = 0,
				["$pp_colour_mulb"] = 0
			}
			
			hook.Add("RenderScreenspaceEffects", "ScreenColor2", function()
				DrawColorModify( cfx ) 
			end)

			hook.Add("HUDPaint", "LightsOut1", function()
					surface.SetDrawColor( 0, 0, 0, 200 )
					surface.DrawRect( 0, 0, ScrW(), ScrH() )
			end)

	end

    function TurnLightsOff()
	
		local sndlevel = 80
		local sndpitch = math.random(90,110)
		
		timer.Simple(0, function() DarkScreen() sound.Play("ambient/energy/spark6.wav", LocalPlayer():GetPos(), sndlevel, sndpitch, 1) end)
		timer.Simple(0.2, function() hook.Remove( "HUDPaint", "LightsOut1" ) hook.Remove( "RenderScreenspaceEffects", "ScreenColor2" ) end)
		timer.Simple(0.4, function() DarkScreen() sound.Play("ambient/energy/spark4.wav", LocalPlayer():GetPos(), sndlevel, sndpitch, 1) end)
		timer.Simple(0.6, function() hook.Remove( "HUDPaint", "LightsOut1" ) hook.Remove( "RenderScreenspaceEffects", "ScreenColor2" ) end)
		timer.Simple(0.8, function() DarkScreen() sound.Play("ambient/energy/spark3.wav", LocalPlayer():GetPos(), sndlevel, sndpitch, 1) end)
		timer.Simple(1.0, function() hook.Remove( "HUDPaint", "LightsOut1" ) hook.Remove( "RenderScreenspaceEffects", "ScreenColor2" ) end)
		timer.Simple(1.1, function() DarkScreen() sound.Play("ambient/energy/spark1.wav", LocalPlayer():GetPos(), sndlevel, sndpitch, 1) end)
		timer.Simple(1.2, function() hook.Remove( "HUDPaint", "LightsOut1" ) hook.Remove( "RenderScreenspaceEffects", "ScreenColor2" ) end)
		timer.Simple(1.8, function() DarkScreen() sound.Play("ambient/energy/spark5.wav", LocalPlayer():GetPos(), sndlevel, sndpitch, 1) end)
		
		end	
	
end

--nut.chat.send(target, "mind", table.Random(whispers)) 

nut.command.add("scappear", {
	adminOnly = true,
	syntax = "<string name>",
	onRun = function(client, arguments)
		local target = nut.command.findPlayer(client, arguments[1])	
		if ( IsValid(target) ) then		
			net.Start( "MannStart" )
			net.WriteEntity( target )
			net.Send( target ) 
			target:Freeze(true)
		timer.Simple(2.2, function() 
			net.Start( "MannEnd" )
			net.WriteEntity( target )
			net.Send( target ) 
			target:Freeze(false)			
		end )		
	  end
   end
})

nut.command.add("scappear2", {
	adminOnly = true,
	syntax = "<string name>",
	onRun = function(client, arguments)
		local target = nut.command.findPlayer(client, arguments[1])	
		if(IsValid(target)) then		
			net.Start("MannStart2")
			net.WriteEntity(target)
			net.Send(target) 
			target:Freeze(true)
			
			timer.Simple(2, function() 
				net.Start("MannEnd")
				net.WriteEntity( target )
				net.Send(target) 
				target:Freeze(false)			
			end)
		end
	end
})

nut.command.add("sclightsout", {
	adminOnly = true,
	syntax = "<string name>",
	onRun = function(client, arguments)
		local target = nut.command.findPlayer(client, arguments[1])	
		if ( IsValid(target) ) then		
			net.Start( "Flicker" )
			net.WriteEntity( target )
			net.Send( target ) 

		timer.Simple(5, function() 
			net.Start( "MannEnd" )
			net.WriteEntity( target )
			net.Send( target ) 
		end )		
	  end
   end
})

nut.command.add("lightsoff", {
	adminOnly = true,
	syntax = "<string name>",
	onRun = function(client, arguments)
		local target = nut.command.findPlayer(client, arguments[1])	
		if ( IsValid(target) ) then		
			net.Start( "LightsOff" )
			net.WriteEntity( target )
			net.Send( target ) 
	  end
   end
})

nut.command.add("lightson", {
	adminOnly = true,
	syntax = "<string name>",
	onRun = function(client, arguments)
		local target = nut.command.findPlayer(client, arguments[1])	
		if ( IsValid(target) ) then		
			net.Start( "LightsOn" )
			net.WriteEntity( target )
			net.Send( target ) 	
	  end
   end
})

--this is global and that's annoying
function flashlightFlicker(target, times)
	if(times > 0) then
		timer.Simple(math.random(1, 3), function()
			if (target:FlashlightIsOn()) then
				target:Flashlight(false)
			else
				target:Flashlight(true)
			end
			flashlightFlicker(target, times-1)
		end)
	end
end

nut.command.add("scflicker", {
	adminOnly = true,
	syntax = "<string name> [num times]",
	onRun = function(client, arguments)
		local target = nut.command.findPlayer(client, arguments[1])
		local times = tonumber(arguments[2]) or 10
		if(target:getChar() and not target:getChar():getInv():getFirstItemOfType("flashlight_shard")) then
			client:notify("Flickering.")
			flashlightFlicker(target, times)
		else
			client:notify("Not flickering.")
		end
	end
})

nut.command.add("scwhisper", {
	adminOnly = true,
	syntax = "<string name>",
	onRun = function(client, arguments)
		local target = nut.command.findPlayer(client, arguments[1]) or client
		
		if(target) then
			--local times = tonumber(arguments[2]) or 10
			local whispers = {}
			whispers[0] = "avoxgaming/ambients/ghost_scream_1.wav"
			whispers[1] = "ambient/creatures/town_moan1.wav"
			whispers[2] = "ambient/creatures/town_scared_sob2.wav"
			whispers[3] = "ambient/creatures/town_scared_breathing2.wav"
			whispers[4] = "ambient/creatures/teddy.wav"
			whispers[5] = "avoxgaming/objects/pipe_laughter_1.mp3"
			whispers[6] = "ambient/materials/footsteps_wood1.wav"

			
			target:ConCommand( "play " .. whispers[math.random(0,6)] )
		else
			client:notify("Invalid target")
		end
	end
})

nut.command.add("scemit", {
	adminOnly = true,
	syntax = "<string soundpath> [num level] [num pitch]",
	onRun = function(client, arguments)
		if(!arguments[1]) then
			client:notify("No sound specified")
			return false
		end
	
		local soundLevel = tonumber(arguments[2] or 75)
		local pitch = math.Clamp(tonumber(arguments[3] or 100), 30, 256)
		client:EmitSound(arguments[1], soundLevel, pitch)
		client:notify("Emitting a sound: " .. arguments[1])
	end
})

nut.command.add("scsound", {
	adminOnly = true,
	syntax = "<string name> <string soundpath>",
	onRun = function(client, arguments)
		local target = nut.command.findPlayer(client, arguments[1])
		
		if(target) then
			target:ConCommand( "play " .. arguments[2] )
		else
			client:notify("Invalid target")
		end
	end
})

nut.command.add("scteleport", {
	adminOnly = true,
	syntax = "<string name> <string soundpath>",
	onRun = function(client, arguments)
		local target = nut.command.findPlayer(client, arguments[1])
		
		if(target) then
			target:ScreenFade(SCREENFADE.IN, Color(0, 0, 0, 255), 1, 5)
			
			--From Evolve admin mod
			local size = Vector( 32, 32, 72 )
			local tr = {}
			tr.start = client:GetShootPos()
			tr.endpos = client:GetShootPos() + client:GetAimVector() * 100000000
			tr.filter = client
			local trace = util.TraceEntity(tr, client)
			
			local EyeTrace = client:GetEyeTraceNoCursor()
			if (trace.HitPos:Distance(EyeTrace.HitPos) > size:Length()) then -- It seems the player wants to teleport through a narrow spot... Force them there even if there is something in the way.
				trace = EyeTrace
				trace.HitPos = trace.HitPos + trace.HitNormal * size * 1.2
			end
			
			target:SetPos(trace.HitPos + trace.HitNormal * size)
			target:SetLocalVelocity(Vector(0,0,0))
		else
			client:notify("Invalid target")
		end
	end
})

nut.command.add("placesound", {
	adminOnly = true,
	syntax = "<string path> [num level] [num pitch]",
	onRun = function(client, arguments)
		local soundLevel = tonumber(arguments[2] or 75);
		local pitch = tonumber(arguments[3] or 100);
		local trace = client:GetEyeTraceNoCursor();
		
		if (client:GetShootPos():Distance(trace.HitPos) <= 2000) then
			if( pitch > 29 and pitch < 256  ) then
				sound.Play(arguments[1], trace.HitPos, soundLevel, pitch)
			else
				client:notify("The pitch needs to be between 30 and 255!")
			end
		else
			client:notify("You cannot play a sound that far away!")
		end
	end
})

nut.command.add("earthquake", {
	adminOnly = true,
	onRun = function(client, arguments)

	util.ScreenShake( Vector( 0, 0, 0 ), 20, 20, 8, 9999999999 )

	for k, v in pairs( player.GetAll() ) do
		v:ConCommand("play ambient/atmosphere/terrain_rumble1.wav")
	end
end
})
