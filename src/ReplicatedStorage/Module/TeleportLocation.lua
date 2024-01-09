local TeleportLocal = {}

local FolderTeleport = game.Workspace.FolderTeleprot

    FolderTeleport.TeleportOldWorld.Touched:Connect(function(hit)
        if hit.Parent:FindFirstChild('HumanoidRootPart') then
            hit.Parent.HumanoidRootPart.CFrame = FolderTeleport.TeleportNewWorld.CFrame + Vector3.new(0,3,0)
        end
    end)


return TeleportLocal