local CheckPoint = {} --- дописать  
----- INSTRUCTIONS -----

-- Create a folder in Workspace called "Checkpoints" (without the quotes)
-- Move all of your checkpoints into that folder
-- Change the name of all of your checkpoints to their stage number (change the name of the first checkpoint to '1', the second checkpoint to '2', and so on)
-- If your first checkpoint is 0, change the "FIRST_CHECKPOINT" variable below to 0
-- Make sure your checkpoints are normal parts and not SpawnLocations, if they are SpawnLocations, you either need to set their 'Enabled' property to false or replace them with regular parts
-- If you spawn facing the wrong direction, try rotating the checkpoint

-- IMPORTANT: If you have another data store in your game called "ObbyData", make sure to change the name of the data store below in this script

----- Variables -----

local Players = game:GetService("Players")

local checkpoints = game.Workspace.Checkpoints 
local Data = require(game.ServerScriptService.Server.DataStore)

local Starting = 0

Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(character)
		task.wait() 
		local PData = Data:Get(player)
		if not PData.Loaded then
			repeat
				task.wait()
				PData = Data:Get(player)
			until PData.Loaded
		end
		local CheckPointSave = PData.BaseSettings.Checkpoint
		local checkpoint = checkpoints:FindFirstChild(tostring(CheckPointSave))
		if checkpoint then
			character:WaitForChild("HumanoidRootPart").CFrame = checkpoint.CFrame + Vector3.new(0, 3 + (checkpoint.Size.Y / 2), 0)
		end
	end)
end)

for i, v in pairs(checkpoints:GetChildren()) do
	v.Touched:Connect(function(hit)
		local player = Players:GetPlayerFromCharacter(hit.Parent)
		
		local TostringStarting = 0
		if not player then
			return
		end
		
		Starting = tonumber(v.Name)
		local PData = Data:Get(hit.Parent)
		if Starting == tonumber(v.Name) then
			if PData.BaseSettings.Checkpoint > Starting then
				PData.BaseSettings.Checkpoint = PData.BaseSettings.Checkpoint
				PData:Update('BaseSettings', PData.BaseSettings)
			else
				PData.BaseSettings.Checkpoint  = Starting
 		end

		end
	end)
end

return CheckPoint