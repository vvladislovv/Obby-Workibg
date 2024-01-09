local Present = {}

local RS = game:GetService('ReplicatedStorage')
local Remote = RS:WaitForChild('Remote')
local Data = require(game.ServerScriptService.Server.DataStore)
--local DataStore = require(game.ServerScriptService.Server.DataStore)
local Data = require(game.ServerScriptService.Server.DataStore)
local FolderPresent = game.Workspace.Present
--local player = game:GetService('Players')
--print('Start')
--local TouchedER

Remote.Touched.OnServerEvent:Connect(function(plr, PresentValue,openPresent)-- это не таблица
	local PData = Data:Get(plr)
	if PresentValue == true then
		if openPresent.Name == 'Union1' then
			PData.BaseSettings.Present += 1
			PData:Update('BaseSettings', PData.BaseSettings)
			PresentValue = false
		end
		if openPresent.Name == 'Union2' then
			PData.BaseSettings.Present += 3
			PData:Update('BaseSettings', PData.BaseSettings)
			PresentValue = false
		end
		if openPresent.Name == 'Union3' then
			PData.BaseSettings.Present += 5
			PData:Update('BaseSettings', PData.BaseSettings)
			PresentValue = false
		end
		if openPresent.Name == 'Union4' then
			PData.BaseSettings.Present += 10
			PData:Update('BaseSettings', PData.BaseSettings)
			PresentValue = false
		end
		if openPresent.Name == 'Union5' then
			PData.BaseSettings.Present += 15
			PData:Update('BaseSettings', PData.BaseSettings)
			PresentValue = false
		end
	end
end)



return Present
