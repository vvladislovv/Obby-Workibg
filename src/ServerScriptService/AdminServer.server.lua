local rs = game.ReplicatedStorage:WaitForChild("AdminPanelRS")
local re = rs:WaitForChild("RE")
local admins = require(rs:WaitForChild("AdminsModule"))
local Data = require(script.Parent.Server.DataStore)
local ts = game:GetService("TextService")

local ms = game:GetService("MessagingService")
local announcementTopic = "admin panel ANNOUNCEMENT"
local banTopic = "admin panel BAN"
local muteTopic = "admin panel MUTE"
local unmuteTopic = "admin panel UNMUTE"
local kickTopic = "admin panel KICK"

local dss = game:GetService("DataStoreService")
local ds = dss:GetDataStore("MODERATION DATASTORE2")

local cs = require(game:GetService("ServerScriptService"):WaitForChild("ChatServiceRunner"):WaitForChild("ChatService"))
local channel = cs:GetChannel("ALL")

local shuttingDown = false
--Respond to commands
re.OnServerEvent:Connect(function(plr, instruction, value, targetId)
	
	if table.find(admins, plr.UserId) then
		local adminChar = plr.Character
		
		local targetPlr
		if tonumber(targetId) then
			targetPlr = game.Players:GetPlayerByUserId(tonumber(targetId))
		end
		
		--CHARACTER COMMANDS
		if tonumber(targetId) then
			targetId = tonumber(targetId)
			if targetPlr and targetPlr.Character then
				local targetChar = targetPlr.Character
				
				if instruction == "GO TO" and adminChar then
					adminChar.HumanoidRootPart.CFrame = targetChar.HumanoidRootPart.CFrame
				elseif instruction == "BRING" then
					targetChar.HumanoidRootPart.CFrame = adminChar.HumanoidRootPart.CFrame
					
				elseif instruction == "FREEZE" then
					targetChar.HumanoidRootPart.Anchored = true
				elseif instruction == "UNFREEZE" then
					targetChar.HumanoidRootPart.Anchored = false
					
				elseif instruction == "SPEED" and tonumber(value) then
					targetChar.Humanoid.WalkSpeed = tonumber(value)
				elseif instruction == "JUMP" and tonumber(value) then
					if targetChar.Humanoid.UseJumpPower == true then
						targetChar.Humanoid.JumpPower = tonumber(value)
					else
						targetChar.Humanoid.JumpHeight = tonumber(value)
					end
					
				elseif instruction == "HEALTH" and tonumber(value) then
					targetChar.Humanoid.Health = tonumber(value)
				end
			end
			
		--MODERATION COMMANDS
			if instruction == "MUTE" and tonumber(value) then
				
				local muteStart = os.time()
				local muteEnd = muteStart + tonumber(value)
				
				local data = {muteEnd}
				
				pcall(function()
					ds:SetAsync(targetId .. "Muted", data)
					
					if targetPlr then
						channel:MuteSpeaker(targetPlr.Name)
						
						task.wait(tonumber(value))
						if targetPlr then
							channel:UnmuteSpeaker(targetPlr.Name)
						end
					else
						ms:PublishAsync(muteTopic, {targetId, tonumber(value)})
					end
				end)
			elseif instruction == "UNMUTE" then
				pcall(function()
					ds:RemoveAsync(targetId .. "Muted")
					
					if targetPlr then
						channel:UnmuteSpeaker(targetPlr.Name)
					else
						ms:PublishAsync(unmuteTopic, {targetId})
					end
				end)
			elseif instruction == "Present" then
				print(value)
				local tt = tonumber(targetId)
				if tt == plr.UserId then
					local PData = Data:Get(plr)
					PData.BaseSettings.Present = value
					PData:Update('BaseSettings', PData.BaseSettings)
					print(value)
				end
			elseif instruction == "Checkpoint"  then
				print(value)
				local tt = tonumber(targetId)
				if tt == plr.UserId then
					local PData = Data:Get(plr)
					PData.BaseSettings.Checkpoint = value
					PData:Update('BaseSettings', PData.BaseSettings)
					print(value)
				end
			elseif instruction == "BAN" and tonumber(value[1]) then
				local banStart = os.time()
				local banEnd = banStart + tonumber(value[1])
				
				local banReason = value[2]
				
				local data = {banEnd, banReason}
				
				pcall(function()
					ds:SetAsync(targetId .. "Banned", data)
					
					local dateInfo = os.date("!*t", data[1])
					local dateFormatted = dateInfo["day"] .. "/" .. dateInfo["month"] .. "/" .. dateInfo["year"] .. "  " .. dateInfo["hour"] .. ":" .. dateInfo["min"] .. ":" .. dateInfo["sec"]
					local banMessage = "Banned for: " .. data[2] .. " | Ends: " .. dateFormatted
					
					if targetPlr then
						targetPlr:Kick(banMessage)
						
					else
						ms:PublishAsync(banTopic, {targetId, banMessage})
					end
				end)
			elseif instruction == "UNBAN" then
				pcall(function()
					ds:RemoveAsync(targetId .. "Banned")
				end)
				
			elseif instruction == "KICK" then
				if targetPlr then
					targetPlr:Kick(value)
				else
					ms:PublishAsync(kickTopic, {targetId, value})
				end
			end
			
		--COMMAND BAR
		elseif instruction == "COMMAND BAR" and value then
			pcall(function()
				loadstring(value)()
			end)
			
		--SYSTEM COMMANDS
		else
			if instruction == "ANNOUNCE" and value and targetId then
				local success, filtered = pcall(function()
					local filteredTextResult = ts:FilterStringAsync(value, plr.UserId):GetNonChatStringForBroadcastAsync()
					return filteredTextResult
				end)
				if success and filtered then
					
					if targetId == "GLOBAL" then
						ms:PublishAsync(announcementTopic, {filtered})
						
					else
						re:FireAllClients("ANNOUNCE", filtered)
					end
				end
					
			elseif instruction == "SHUT DOWN" then
				shuttingDown = true
				
				for i, plr in pairs(game.Players:GetPlayers()) do
					plr:Kick("This server is shutting down.")
				end
			end
		end
	end
end)


--Check moderation data
game.Players.PlayerAdded:Connect(function(plr)
	
	--Kick new players if game is shutting down
	if shuttingDown then
		plr:Kick("This server has shut down.")
	end
	
	--Kick banned players, or remove ban data if ban time is over
	local banSuccess, banData = pcall(function()
		local data = ds:GetAsync(plr.UserId .. "Banned")
		return data
	end)
	
	if banSuccess and banData then
		local banEnd = banData[1]
		
		if os.time() >= banEnd then
			pcall(function()
				ds:RemoveAsync(plr.UserId .. "Banned")
			end)
			
		else
			local banReason = banData[2]
			
			local dateInfo = os.date("!*t", banEnd)
			local dateFormatted = dateInfo["day"] .. "/" .. dateInfo["month"] .. "/" .. dateInfo["year"] .. "  " .. dateInfo["hour"] .. ":" .. dateInfo["min"] .. ":" .. dateInfo["sec"]
			local banMessage = "Banned for: " .. banReason .. " | Ends: " .. dateFormatted
			
			plr:Kick(banMessage)
		end
	end
	
	--Mute players or unmute them if mute time is over
	local muteSuccess, muteData = pcall(function()
		local data = ds:GetAsync(plr.UserId .. "Muted")
		return data
	end)
	
	if muteSuccess and muteData then
		local muteEnd = muteData[1]
		
		if os.time() >= muteEnd then
			pcall(function()
				ds:RemoveAsync(plr.UserId .. "Muted")
			end)
			
		else
			channel:MuteSpeaker(plr.Name)
			
			local timeToUnmute = muteEnd - os.time()
			task.wait(timeToUnmute)
			
			if plr then
				channel:UnmuteSpeaker(plr.Name)
			end
		end
	end
end)


--Receive global announcements
local announcementConnection = ms:SubscribeAsync(announcementTopic, function(message)
	if message and message.Data[1] then
		re:FireAllClients("ANNOUNCE", message.Data[1])
	end
end)
--Ban players across different servers
local banConnection = ms:SubscribeAsync(banTopic, function(message)
	local targetId = message.Data[1]
	local banMessage = message.Data[2]
	
	for i, plr in pairs(game.Players:GetPlayers()) do
		if plr.UserId == targetId then
			plr:Kick(banMessage)
		end
	end
end)
--Mute players across different servers
local muteConnection = ms:SubscribeAsync(muteTopic, function(message)
	local targetId = message.Data[1]
	local muteLength = message.Data[2]

	for i, plr in pairs(game.Players:GetPlayers()) do
		if plr.UserId == targetId then
			
			channel:MuteSpeaker(plr.Name)

			task.wait(muteLength)
			if plr then
				channel:UnmuteSpeaker(plr.Name)
			end
		end
	end
end)
--Unmute players across different servers
local unmuteConnection = ms:SubscribeAsync(unmuteTopic, function(message)
	local targetId = message.Data[1]
	for i, plr in pairs(game.Players:GetPlayers()) do
		if plr.UserId == targetId then

			channel:UnmuteSpeaker(plr.Name)
		end
	end
end)
--Kick players across different servers
local kickConnection = ms:SubscribeAsync(kickTopic, function(message)
	local targetId = message.Data[1]
	local kickReason = message.Data[2]
	for i, plr in pairs(game.Players:GetPlayers()) do
		if plr.UserId == targetId then

			plr:Kick(kickReason)
		end
	end
end)