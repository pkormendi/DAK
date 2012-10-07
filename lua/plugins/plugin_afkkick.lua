//NS2 Automatic AFK Kicker

local AFKClientTracker = { }
local lastAFKUpdate = 0

if kDAKConfig and kDAKConfig.AFKKicker and kDAKConfig.AFKKicker.kEnabled then

	local function DisplayMessage(client, message)

		local player = client:GetControllingPlayer()
		chatMessage = string.sub(string.format(message), 1, kMaxChatLength)
		Server.SendNetworkMessage(player, "Chat", BuildChatMessage(false, "PM - Admin", -1, kTeamReadyRoom, kNeutralTeamType, chatMessage), true)

	end
	
	local function DisconnectClientForIdling(client)

		client.disconnectreason = string.format(kDAKConfig.AFKKicker.kAFKKickDisconnectReason, kDAKConfig.AFKKicker.kAFKKickDelay)
		Server.DisconnectClient(client)
		
	end

	local function AFKOnClientConnect(client)
	
		if client:GetIsVirtual() then
			//Bots dont get afk'd
			return true
		end
		
		if client ~= nil then
			local player = client:GetControllingPlayer()
			if player ~= nil and client ~= nil then
				local PEntry = { ID = client:GetUserId(), MVec = player:GetViewAngles(), POrig = player:GetOrigin(), Time = Shared.GetTime() + kDAKConfig.AFKKicker.kAFKKickDelay, Active = true, Warn1 = false, Warn2 = false, kick = false }
				table.insert(AFKClientTracker, PEntry)
			end
			return true
		end
		return false
	end
	
	table.insert(kDAKOnClientDelayedConnect, function(client) return AFKOnClientConnect(client) end)
	
	local function UpdateAFKClient(client, PEntry, player)
		if player ~= nil then
		
			if DAKGetClientCanRunCommand(client, "sv_afkimmune") then
				return PEntry
			end
		
			local playerList = EntityListToTable(Shared.GetEntitiesWithClassname("Player"))
			PEntry.Active = true
			if player:GetViewAngles() ~= PEntry.MVec or (player:GetOrigin() ~= PEntry.POrig and player:GetIsOverhead()) or #playerList < kDAKConfig.AFKKicker.kAFKKickMinimumPlayers then
				PEntry.MVec = player:GetViewAngles()
				PEntry.POrig = player:GetOrigin()
				PEntry.Time = Shared.GetTime() + kDAKConfig.AFKKicker.kAFKKickDelay
				if PEntry.Warn2 or PEntry.Warn1 or PEntry.kick then
					PEntry.kick = false
					PEntry.Warn2 = false
					PEntry.Warn1 = false
					DisplayMessage(client, kDAKConfig.AFKKicker.kAFKKickReturnMessage)
				end
				return PEntry			
			end
			
			if PEntry.kick and PEntry.Time < Shared.GetTime() then
				Shared.Message(string.format(kDAKConfig.AFKKicker.kAFKKickMessage, player:GetName(), kDAKConfig.AFKKicker.kAFKKickDelay))
				EnhancedLog(string.format(kDAKConfig.AFKKicker.kAFKKickMessage, player:GetName(), kDAKConfig.AFKKicker.kAFKKickDelay))
				DisconnectClientForIdling(client)
				return nil
			end
			
			if not PEntry.Warn1 and PEntry.Time < (Shared.GetTime() + kDAKConfig.AFKKicker.kAFKKickWarning1) then
				DisplayMessage(client, string.format(kDAKConfig.AFKKicker.kAFKKickWarningMessage1, kDAKConfig.AFKKicker.kAFKKickWarning1))
				PEntry.Warn1 = true
			end
			
			if not PEntry.Warn2 and PEntry.Time < (Shared.GetTime() + kDAKConfig.AFKKicker.kAFKKickWarning2) then
				DisplayMessage(client, string.format(kDAKConfig.AFKKicker.kAFKKickWarningMessage2, kDAKConfig.AFKKicker.kAFKKickWarning2))
				PEntry.Warn2 = true
			end
			
			if PEntry.Warn2 and PEntry.Warn1 and PEntry.Time < Shared.GetTime() then
				DisplayMessage(client, string.format(kDAKConfig.AFKKicker.kAFKKickClientMessage, kDAKConfig.AFKKicker.kAFKKickDelay))
				PEntry.kick = true
			end
			
			return PEntry
		end
	
	end

	local function AFKOnClientDisconnect(client)    

		if #AFKClientTracker > 0 then
			for i = 1, #AFKClientTracker do
				if AFKClientTracker[i] ~= nil and client == AFKClientTracker[i] then
					AFKClientTracker[i] = nil
				end
			end
		end
		return true
		
	end

	table.insert(kDAKOnClientDisconnect, function(client) return AFKOnClientDisconnect(client) end)

	local function ProcessPlayingUsers(deltatime)

		PROFILE("AFKKick:ProcessPlayingUsers")

		if #AFKClientTracker > 0 and lastAFKUpdate + kDAKConfig.AFKKicker.kAFKKickCheckDelay < Shared.GetTime() then
			local playerRecords = Shared.GetEntitiesWithClassname("Player")
			for i = #AFKClientTracker, 1, -1 do
				local PEntry = AFKClientTracker[i]
				if PEntry ~= nil then
					PEntry.Active = false
					for _, player in ientitylist(playerRecords) do
						if player ~= nil then
							local client = Server.GetOwner(player)
							if client ~= nil then
								if PEntry.ID == client:GetUserId() then
									AFKClientTracker[i] = UpdateAFKClient(client, PEntry, player)
								end
							end
						end
					end
					if not PEntry.Active then
						AFKClientTracker[i] = nil
					end
				else
					AFKClientTracker[i] = nil
				end
			end
			lastAFKUpdate = Shared.GetTime()
		end
		return true
	end

	table.insert(kDAKOnServerUpdate, function(deltatime) return ProcessPlayingUsers(deltatime) end)
	
elseif kDAKConfig and not kDAKConfig.AFKKicker then
	
	DAKGenerateDefaultDAKConfig("AFKKicker")
	
end

Shared.Message("AFKKicker Loading Complete")