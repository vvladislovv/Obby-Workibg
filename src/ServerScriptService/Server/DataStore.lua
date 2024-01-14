local Data = {}

local RunService = game:GetService("RunService")
local Players = game:GetService("Players")
local CopyTable = require(game.ReplicatedStorage.Module.Libary.CopyTable)

local Remotes = game.ReplicatedStorage:WaitForChild("Remote")
--local Modules = game.ReplicatedStorage:WaitForChild("Modules")
--local Items = require(Modules.Items)

Data.PlayerData = {}

function Data.new(Player)
	local PData = {}
	PData.Loaded = false
	PData.BaseSettings = { 
		Checkpoint = 0,
		Present = 0
	}

	PData.Equipment = {
		Boot = ""
	}
	function PData:Update(key, value)
		PData[key] = value
		Remotes.ClientDataUpdate:FireClient(Player,key,value)
	end
	
	Data.PlayerData[Player.Name] = PData
	return PData
end

function Data:Get(Player)
	if game:GetService("RunService"):IsServer() then
		return Data.PlayerData[Player.Name]
	else
		return Remotes.GetDataSave:InvokeServer()
	end
end

local AutoSaves = {}

local MainKey = 'DataMainServerAlifa123'
local ClientKey = 'DataMainClientAlifa123'

local DataStore2 = require(game.ServerScriptService.DataStore2)

function LoadData(Client)
	DataStore2.Combine(MainKey, ClientKey)
	local PData = Data.new(Client)
	local DataStorage = DataStore2(ClientKey, Client):GetTable(PData)
	PData = GetDataFromDataStorage(Client, DataStorage)
	PData.Loaded = true
	AutoSaves[Client.Name] = Client
end

function SaveData(client, PData)
	DataStore2(ClientKey, client):Set(CopyTable:CopyWithoutFunctions(PData))
	print(PData)
end

function GetDataFromDataStorage(Client, DataStorage)
	local PData = Data:Get(Client)
	
	for i,v in pairs(DataStorage.BaseSettings) do
		PData.BaseSettings[i] = DataStorage.BaseSettings[i]
	end

	for i,v in pairs(DataStorage.Equipment) do
		PData.Equipment[i] = DataStorage.Equipment[i]
	end
	return PData
end
do
	Players.PlayerAdded:Connect(LoadData)
	Players.PlayerRemoving:Connect(function(Client)
		SaveData(Client, Data:Get(Client))
		AutoSaves[Client.Name] = nil
	end)
	--Players.PlayerRemoving:Connect(function(Client) SaveData(Client, Data:Get(Client)) AutoSaves[Client.Name] = nil end)

	game.ReplicatedStorage.Remote.GetDataSave.OnServerInvoke = function(client)
		local PData = Data:Get(client)
		return PData
	end
end

local TotalDelta = 0
spawn(function()
	while wait(1) do
		TotalDelta += 1
		if TotalDelta > 3 then
			TotalDelta = 0
			for _, Player in pairs(AutoSaves) do
				local PData = Data:Get(Player)
				SaveData(Player, PData)
			end
		end
	end
end)

return Data
