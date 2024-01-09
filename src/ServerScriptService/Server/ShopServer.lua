local Remote = game:GetService('ReplicatedStorage'):WaitForChild('Remote')
local Player = game:GetService('Players')
local ItemsFolder = game.ReplicatedStorage:WaitForChild("Items")
local Data = require(game.ServerScriptService.Server.DataStore)
local FreeFolderItems = game.ServerStorage.FreeFolderItems

local ShopServer = {}

Remote.BuyShop.OnServerEvent:Connect(function(plr, Cost, IndexProduct)
	local PData = Data:Get(plr)
	if IndexProduct == 1 then
		if PData.BaseSettings.Present >= Cost then
			print(Cost)
			PData.BaseSettings.Present -= Cost -- Если хватает на вещь, тогда делает минус с даты
			print('Yes cost')
		else
			print('No cost')
		end
	end
	if IndexProduct == 2 then
		if PData.BaseSettings.Present >= Cost then
			PData.BaseSettings.Present -= Cost -- Если хватает на вещь, тогда делает минус с даты
			print('Yes cost')
		else
			print('No cost')
		end
	end
	if IndexProduct == 3 then
		if PData.BaseSettings.Present >= Cost then
			PData.BaseSettings.Present -= Cost -- Если хватает на вещь, тогда делает минус с даты
			print('Yes cost')
		else
			print('No cost')
		end
	end
	if IndexProduct == 4 then
		if PData.BaseSettings.Present >= Cost then
			PData.BaseSettings.Present -= Cost -- Если хватает на вещь, тогда делает минус с даты
			print('Yes cost')
		else
			print('No cost')
		end
	end
	if IndexProduct == 5 then
		if PData.BaseSettings.Present >= Cost then
			PData.BaseSettings.Present -= Cost -- Если хватает на вещь, тогда делает минус с даты
			print('Yes cost')
		else
			print('No cost')
		end
	end
end)

return ShopServer
