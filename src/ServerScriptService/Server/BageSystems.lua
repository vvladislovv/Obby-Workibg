local BadgeService = game:GetService("BadgeService")
local BagersID = 172779697017220

local Bagers = {}

game.Players.PlayerAdded:Connect(function(player)
    task.wait(1)
    if not BadgeService:UserHasBadgeAsync(player.UserId, BagersID) then
        BadgeService:AwardBadge(player.UserId, BagersID)
    end
end)

return Bagers