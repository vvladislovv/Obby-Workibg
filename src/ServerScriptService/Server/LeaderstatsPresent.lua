local PresentLeaderstats = {}
local DSS = game:GetService("DataStoreService")
local dataStore = DSS:GetOrderedDataStore("DataStoreAlifaa154") --// "DataStore1" - это название хранилища, можете поставить своё
local DataS = require(game.ServerScriptService.Server.DataStore)

local BlackList = {
	['vlad060108'] = true,
	['BreadDev'] = true
}

local function updateBoard()
	local success, errorMessage = pcall(function()
		local Data = dataStore:GetSortedAsync(false, 10)
		local page = Data:GetCurrentPage()
		for rank, data in ipairs(page) do
			local nameID = game.Players:GetNameFromUserIdAsync(tonumber(data.key))
			local nickname = nameID
			local Present = data.value
			local onLeaderboard = false
			
			for i, v in pairs(game.Workspace.Leaderbords.PresentLeaderbords.GlobalBoard.MainGui.Holder:GetChildren()) do
				if v.Name ~= "UIListLayout" then
					if v.Player.Text == nickname then
						onLeaderboard = true
					end
				end
			end
			
			if not onLeaderboard then
				local newFrame = game.ReplicatedStorage.Assert.Template:Clone()
				newFrame.Parent = game.Workspace.Leaderbords.PresentLeaderbords.GlobalBoard.MainGui.Holder
				newFrame.Player.Text = nickname
				newFrame.Coins.Text = Present --// Вместо "Coins" вставьте название вашей валюты
				newFrame.Rank.Text = "#" .. rank
			end
		end
	end)
		
	if not success then
		print(errorMessage)
	end
end

while true do
	for _, plr in pairs(game.Players:GetPlayers()) do
		local PData = DataS:Get(plr)
		local Current = PData.BaseSettings.Present
		if not BlackList[plr.Name] then
			dataStore:SetAsync(plr.UserId, Current)
		else
			dataStore:SetAsync(plr.UserId, 0)
		end

	end
	
	for _, frame in pairs(game.Workspace.Leaderbords.PresentLeaderbords.GlobalBoard.MainGui.Holder:GetChildren()) do
		if frame.Name ~= "UIListLayout" then
			frame:Destroy()
		end
	end
	
	updateBoard()
	--print("Updated")
	
	task.wait(5) --// В скобках: Кол-во секунд между обнавлениями доски
end
return PresentLeaderstats