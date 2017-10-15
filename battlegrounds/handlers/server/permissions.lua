--[[

				MTA:BG
			MTA Battlegrounds
	Developed By: Null System Works

]]--

local restrictedCommands = {
	["say"] = true,
	["teamsay"] = true,
	["showchat"] = true, 
	["register"] = true,
	["me"] = true
}

local function restrictCommands(cmd)
	if (restrictedCommands[cmd] and not getElementData(source,"inLobby")) then
			cancelEvent()
	end
end
addEventHandler("onPlayerCommand",root,restrictCommands)

local function stopExternalParachuteResource()
	local parachuteResource = getResourceFromName("parachute")
	local realParachuteR = getResourceFromName("parachutes")
	if parachuteResource and getResourceState(parachuteResource) == "running" then
		stopResource(parachuteResource)
	end
	if getResourceState(realParachuteR) == "running" then
		restartResource(parachuteResource)
	end
end
addEventHandler("onResourceStart",resourceRoot,stopExternalParachuteResource)
