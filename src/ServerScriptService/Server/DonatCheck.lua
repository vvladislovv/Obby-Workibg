local Remote = game:GetService("ReplicatedStorage"):WaitForChild('Remote')
local LevelFull = 68
local Data = require(game.ServerScriptService.Server.DataStore)
local checkpoints = game.Workspace.Checkpoints
local DonatFolderPass = game.Workspace.PartOwner.DonatPass.DonatLevel
local BadgeService = game:GetService("BadgeService")
local BagersID = 2898491687964336

local DonatCheck = {}
--hit.Parent.HumanoidRootPart.CFrame = FolderTeleport.TeleportNewWorld.CFrame + Vector3.new(0,3,0)
Remote.DonatCheck.OnServerEvent:Connect(function(plr,ProductUsers)
    if ProductUsers == true then
        if not BadgeService:UserHasBadgeAsync(plr.UserId, BagersID) then
            BadgeService:AwardBadge(plr.UserId, BagersID)
        end
        local PData = Data:Get(plr)
        PData.BaseSettings.Checkpoint = LevelFull
        PData:Update('BaseSettings', PData.BaseSettings)
        DonatFolderPass.Touched:Connect(function(hit)
            if hit.Parent:FindFirstChild('HumanoidRootPart') then
                hit.Parent.HumanoidRootPart.CFrame = checkpoints['68'].CFrame + Vector3.new(0,3,0)
            end
        end)
    end
end)

return DonatCheck