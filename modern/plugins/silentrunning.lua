PLUGIN.name = "Silent Running (On Dangerous Ground)"
PLUGIN.author = "Howl"
PLUGIN.desc = "Renders several common commands silent to all but the recipients. No more metagaming!"
-- Take the children and yourself and hide out in the shelter
-- By now the fighting will be close at hand
nut.command.add("charsetmodel", {
	adminOnly = true,
	syntax = "<string name> <string model>",
	onRun = function(client, arguments)
		if (!arguments[2]) then
			return L("invalidArg", client, 2)
		end

		local target = nut.command.findPlayer(client, arguments[1])

		if (IsValid(target) and target:getChar()) then
			target:getChar():setModel(arguments[2])
			target:SetupHands()

			client:notify("Their model was changed. Only you and they can see this.")
			target:notify("Your model was adjusted by an admin.")
		end
	end
})
-- Don't believe the church and state 
-- and everything they tell you
-- believe in me, I'm with the high command.

nut.command.add("charsetname", {
	adminOnly = true,
	syntax = "<string name> [string newName]",
	onRun = function(client, arguments)
		local target = nut.command.findPlayer(client, arguments[1])

		if (IsValid(target) and !arguments[2]) then
			return client:requestString("@chgName", "@chgNameDesc", function(text)
				nut.command.run(client, "charsetname", {target:Name(), text})
			end, target:Name())
		end

		table.remove(arguments, 1)

		local targetName = table.concat(arguments, " ")

		if (IsValid(target) and target:getChar()) then
			client:notify("Their name was changed. Only you and they can see this.")
			target:notify("Your name was adjusted by an admin.")


			target:getChar():setName(targetName)
		end
	end
})
-- can you hear me runnin'?
-- can you hear me?
-- can you hear me runnin'?
-- can you hear me callin' you?

nut.command.add("charsetbodygroup", {
	adminOnly = true,
	syntax = "<string name> <string bodyGroup> [number value]",
	onRun = function(client, arguments)
		local value = tonumber(arguments[3])
		local target = nut.command.findPlayer(client, arguments[1])

		if (IsValid(target) and target:getChar()) then
			local index = target:FindBodygroupByName(arguments[2])

			if (index > -1) then
				if (value and value < 1) then
					value = nil
				end

				local groups = target:getChar():getData("groups", {})
					groups[index] = value
				target:getChar():setData("groups", groups)
				target:SetBodygroup(index, value or 0)

			     client:notify("Bodygroups changed. Only you and they can see this.")
				 target:notify("Your bodygroups were adjusted by an admin.")

			else
				return "@invalidArg", 2
			end
		end
	end
})
-- can you hear me?
-- can you hear me runnin'?
nut.command.add("flaggive", {
	adminOnly = true,
	syntax = "<string name> [string flags]",
	onRun = function(client, arguments)
		local target = nut.command.findPlayer(client, arguments[1])

		if (IsValid(target) and target:getChar()) then
			local flags = arguments[2]

			if (!flags) then
				local available = ""

				-- Aesthetics~~
				for k, v in SortedPairs(nut.flag.list) do
					if (!target:getChar():hasFlags(k)) then
						available = available..k
					end
				end

				return client:requestString("@flagGiveTitle", "@flagGiveDesc", function(text)
					nut.command.run(client, "flaggive", {target:Name(), text})
				end, available)
			end

			target:getChar():giveFlags(flags)

			     client:notify("Flags adjusted.")
				 target:notify("Your flags were altered by an admin.")
		end
	end
})
-- can you hear me runnin'?
-- can you hear me callin' you?

nut.command.add("flagtake", {
	adminOnly = true,
	syntax = "<string name> [string flags]",
	onRun = function(client, arguments)
		local target = nut.command.findPlayer(client, arguments[1])

		if (IsValid(target) and target:getChar()) then
			local flags = arguments[2]

			if (!flags) then
				return client:requestString("@flagTakeTitle", "@flagTakeDesc", function(text)
					nut.command.run(client, "flagtake", {target:Name(), text})
				end, target:getChar():getFlags())
			end

			target:getChar():takeFlags(flags)

			     client:notify("Flags adjusted.")
				 target:notify("Your flags were altered by an admin.")
		end
	end
})
-- can you hear me?

nut.command.add("charsetskin", {
	adminOnly = true,
	syntax = "<string name> [number skin]",
	onRun = function(client, arguments)
		local skin = tonumber(arguments[2])
		local target = nut.command.findPlayer(client, arguments[1])

		if (IsValid(target) and target:getChar()) then
			target:getChar():setData("skin", skin)
			target:SetSkin(skin or 0)

			     client:notify("Their skin was changed.")
				 target:notify("Your skin was altered by an admin.")
		end
	end
})

-- can you hear me runnin'?
-- https://www.youtube.com/watch?v=Qs6TY43g5Iw