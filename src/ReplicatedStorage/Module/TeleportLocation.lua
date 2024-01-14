local TeleportLocal = {}

local TeleportVip = false
local Player = game.Players.LocalPlayer
local FolderTeleport = game.Workspace.FolderTeleprot

    FolderTeleport.TeleportOldWorld.Touched:Connect(function(hit)
        if hit.Parent == Player.Character then
            if hit.Parent:FindFirstChild('HumanoidRootPart') then
                hit.Parent.HumanoidRootPart.CFrame = FolderTeleport.TeleportNewWorld.CFrame + Vector3.new(0,3,0)
            end
        end
    end)

    FolderTeleport.TeleportVipOldWorld.Touched:Connect(function(hit)
        if hit.Parent == Player.Character and TeleportVip == false then
            if hit.Parent:FindFirstChild('HumanoidRootPart') then
                hit.Parent.HumanoidRootPart.CFrame = FolderTeleport.TeleportVipNewWorld.CFrame + Vector3.new(0,3,0)
                TeleportVip = true
                task.wait(5)
                TeleportVip = false
            end 
        end
    end)

    FolderTeleport.TeleportVipNewWorld.Touched:Connect(function(hit)
        if hit.Parent == Player.Character and TeleportVip == false then
            if hit.Parent:FindFirstChild('HumanoidRootPart') then
                hit.Parent.HumanoidRootPart.CFrame = FolderTeleport.TeleportVipOldWorld.CFrame + Vector3.new(0,3,0)
                TeleportVip = true
                task.wait(5)
                TeleportVip = false      
            end 
        end
    end)




return TeleportLocal