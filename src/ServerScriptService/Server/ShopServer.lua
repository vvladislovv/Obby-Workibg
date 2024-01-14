local Remote = game:GetService('ReplicatedStorage'):WaitForChild('Remote')
local Data = require(game.ServerScriptService.Server.DataStore)
local FreeFolderItems = game.ServerStorage.FreeFolderItems
local ServerStorage = game:GetService('ServerStorage')
local ChristmasShoes = ServerStorage.FreeFolderItems['Christmas Shoes']

local LShoes = ChristmasShoes['Christmas Shoes Left']:Clone()
local RShoes = ChristmasShoes['Christmas Shoes Right']:Clone()

local FinisTable = {
	['OneItems'] = false,
	['TwoItems'] = false,
	['ThreeItems'] = false,
	['FourItems'] = false,
	['FiveItems'] = false
} -- Таблица был ли инструмент куплин

game.Players.PlayerAdded:Connect(function(client)
	client.CharacterAdded:Connect(function(character)
		character.Humanoid.Died:Connect(function()
			FinisTable['OneItems'] = false
			FinisTable['TwoItems'] = false
			FinisTable['ThreeItems'] = false
			FinisTable['FourItems'] = false
			FinisTable['FiveItems'] = false
		end);
	end);
end); -- Died player then FinisTable all FALSE

local ShopServer = {}

Remote.BuyShop.OnServerEvent:Connect(function(plr, Cost, IndexProduct)
	local PData = Data:Get(plr)
	if IndexProduct == 1 then
		if PData.BaseSettings.Present >= Cost then
			if FinisTable['OneItems'] == false then
				FinisTable['OneItems'] = true
				print(FinisTable)
				PData.BaseSettings.Present -= Cost
				PData:Update('BaseSettings', PData.BaseSettings) -- Если хватает на вещь, тогда делает минус с даты
				local KeyM = FreeFolderItems["Key"]
					if plr.Backpack:FindFirstChild(KeyM.Name) or plr.Character:FindFirstChild(KeyM.Name) then
						--HasteM:StarModule()
						return
					else
						local Key = KeyM:Clone()
						Key.Parent = plr.Backpack
						--HasteM:StarModule()
					end
				end
		else
			print('No cost')
		end
	end

	if IndexProduct == 2 then
		if PData.BaseSettings.Present >= Cost then
			if FinisTable['TwoItems'] == false then
				FinisTable['TwoItems'] = true
				local Cookes = require(game:GetService('ReplicatedStorage').Module.ItemsModule.CookiesEffect)
				PData.BaseSettings.Present -= Cost
				PData:Update('BaseSettings', PData.BaseSettings) -- Если хватает на вещь, тогда делает минус с даты
				local CookesM = FreeFolderItems["Cookes"]
					local Key = CookesM:Clone()
					if plr.Backpack:FindFirstChild(CookesM.Name) or plr.Character:FindFirstChild(CookesM.Name) then
						return
					else
						Key.Parent = plr.Backpack
						--HasteM:StarModule()
					end
				end
		else
			print('No cost')
		end
	end

	if IndexProduct == 3 then
		if PData.BaseSettings.Present >= Cost then
			if FinisTable['ThreeItems'] == false then
				FinisTable['ThreeItems'] = true
				PData.BaseSettings.Present -= Cost
				PData:Update('BaseSettings', PData.BaseSettings) -- Если хватает на вещь, тогда делает минус с даты
				local SwordM = FreeFolderItems["Ice Sword"]
					if plr.Backpack:FindFirstChild(SwordM.Name) or plr.Character:FindFirstChild(SwordM.Name) then
						return
					else
						local Ice = SwordM:Clone()
						Ice.Parent = plr.Backpack
						--HasteM:StarModule()
					end
				end
		else
			print('No cost')
		end
	end

	if IndexProduct == 4 then
		if PData.BaseSettings.Present >= Cost then
			if FinisTable['FourItems'] == false then
				FinisTable['FourItems'] = true
				print(FinisTable)
				PData.BaseSettings.Present -= Cost
				PData:Update('BaseSettings', PData.BaseSettings) -- Если хватает на вещь, тогда делает минус с даты
				local TorchM = FreeFolderItems["Light Torch"]
					if plr.Backpack:FindFirstChild(TorchM.Name) or plr.Character:FindFirstChild(TorchM.Name) then
						--HasteM:StarModule()
						return
					else
						local Key = TorchM:Clone()
						Key.Parent = plr.Backpack
						--HasteM:StarModule()
					end
				end
		else
			print('No cost')
		end
	end

	if IndexProduct == 5 then -- Boots
		if PData.BaseSettings.Present >= Cost and PData.Equipment.Boot == '' then
			if FinisTable['FiveItems'] == false then
				FinisTable['FiveItems'] = true
				print(FinisTable)
				PData.BaseSettings.Present -= Cost
				PData.Equipment.Boot = 'Christmas Shoes'
				PData:Update('BaseSettings', PData.BaseSettings)
				PData:Update('Equipment', PData.Equipment) -- Если хватает на вещь, тогда делает минус с даты
				local ChristmasM = FreeFolderItems["Christmas Shoes"]
				local Christmas = require(game.ReplicatedStorage.Module.ItemsModule.Christmas)
				while true do task.wait()
					if plr.Character then break end
				end
					local hum = plr.Character:WaitForChild('Humanoid')
					print(hum)
					task.wait()
					if plr.Character:FindFirstChild('Humanoid') then
						Christmas:PLayerSpeed(hum)
						hum:AddAccessory(LShoes)
						hum:AddAccessory(RShoes)
					end
				end
		else
			print('No cost')
		end
	end
	
end)

return ShopServer
