local AdminCommand = {}

local Data = require(script.Parent.DataStore)
local Full_checkPoint = 52

local AdminTable = {
    ['vlad060108'] = true,
    ['BreadDev'] = true
}

game.Players.PlayerAdded:Connect(function(player)
    task.wait()
	local PData = Data:Get(player)
    if not PData.Loaded then
        repeat
            task.wait()
            PData = Data:Get(player)
        until PData.Loaded
    end
    if AdminTable[player.Name] then
        PData.BaseSettings.Present = 100000
        PData.BaseSettings.Checkpoint = Full_checkPoint
        PData:Update('BaseSettings', PData.BaseSettings)
    end
end)

return AdminCommand