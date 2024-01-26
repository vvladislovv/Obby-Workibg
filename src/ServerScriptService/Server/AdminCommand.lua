local AdminCommand = {}

local Data = require(script.Parent.DataStore)
local Full_checkPoint = 17
local BootName = 'Christmas Shoes'

local AdminTable = {
    --Adimins
    DeveloperGame = {
        ['vlad060108'] = true,
        ['TOPCIERG'] = true,
    },
    
    TesterGame = {
        ['KornKorn228'] = false,
        ['Brings_Darkness'] = false,
        ['NoobPuplu'] = true,
        ['Kubusthomas'] = true,
        ['StepanVIP123'] = true,
    }
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
    if AdminTable.DeveloperGame[player.Name] then
        if PData.BaseSettings.Present >= 100000 then
            PData.BaseSettings.Present = PData.BaseSettings.Present
        end
        PData.BaseSettings.Checkpoint = Full_checkPoint
        PData.Equipment.Boot = BootName
        PData:Update('BaseSettings', PData.BaseSettings)
        PData:Update('Equipment', PData.Equipment)
    elseif AdminTable.TesterGame[player.Name] then
        if PData.BaseSettings.Present >= 100000 then
            PData.BaseSettings.Present = PData.BaseSettings.Present
        end
        PData.Equipment.Boot = ''
        PData.BaseSettings.Present = 100000
        PData:Update('BaseSettings', PData.BaseSettings)
        PData:Update('Equipment', PData.Equipment)
    end
end)

return AdminCommand