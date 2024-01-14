local Remote = game:GetService('ReplicatedStorage'):WaitForChild('Remote')
local Data = require(game.ServerScriptService.Server.DataStore)
local checkpoints = game.Workspace.Checkpoints
local MS = game:GetService('MarketplaceService')
local NewLevel = 1
local RemoteNext = false
local NextLevelDonat 
local NextLevel = {}
local finsh = 0
local ProductID = 682049099
-- Дописать телеаорт на следующию локациию 


Remote.NextCheckPoint.OnServerEvent:Connect(function(plr, NextLevel)

    if NextLevel == true and finsh == 0 then
        finsh = 1
        local PData = Data:Get(plr)
        PData.BaseSettings.Checkpoint += 1
        PData:Update('BaseSettings', PData.BaseSettings)
        task.wait(5)
        finsh = 0
        local PDataPosition = tostring(PData.BaseSettings.Checkpoint)
        print(PDataPosition)
		for _, v in next, checkpoints:GetChildren() do
            if MS:UserOwnsGamePassAsync(plr.UserId, ProductID) then
                if v.Name == PDataPosition then
                    plr.Character.HumanoidRootPart.CFrame = CFrame.new(v.Position)
                end
            else
                print('fff')
            end
        end
    end
end)

return NextLevel