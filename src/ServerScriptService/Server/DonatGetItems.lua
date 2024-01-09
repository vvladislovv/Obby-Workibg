local DonatGetItems = {}

local Remote = game:GetService('ReplicatedStorage'):WaitForChild('Remote')
local itemsSS = game:GetService('ServerStorage'):WaitForChild('Items')

local ItemsFolder = game:GetService('ReplicatedStorage').Module.ItemsModuleServer

local BouncyM = require(ItemsFolder.BouncyModule)
local HasteM = require(ItemsFolder.HasteModule)
local RegenerationM = require(ItemsFolder.RegenerationModule)
local EverythingM = require(ItemsFolder.EverythingModule)


Remote.OpenDonatLoki.OnServerEvent:Connect(function(plr, CheckItems)
    if CheckItems.Name == 'Haste Potion' then
        local Haste = itemsSS["Haste Potion"]
        if plr.Backpack:FindFirstChild(Haste.Name) or plr.Character:FindFirstChild(Haste.Name) then
            HasteM:StarModule()
            return
        else
            local CloneItems = Haste:Clone()
            CloneItems.Parent = plr.Backpack
            HasteM:StarModule()
        end
    end
    if CheckItems.Name == 'Potion of Everything' then
        local Everything = itemsSS["Potion of Everything"]
        if plr.Backpack:FindFirstChild(Everything.Name) or plr.Character:FindFirstChild(Everything.Name) then
            EverythingM:StarModule()
            return
        else
            local CloneItems = Everything:Clone()
            CloneItems.Parent = plr.Backpack
            EverythingM:StarModule()
        end
    end
    if CheckItems.Name == 'Potion of Regeneration' then
        local Regeneration = itemsSS["Potion of Regeneration"]
        if plr.Backpack:FindFirstChild(Regeneration.Name) or plr.Character:FindFirstChild(Regeneration.Name) then
            RegenerationM:StarModule()
            return
        else
            local CloneItems = Regeneration:Clone()
            CloneItems.Parent = plr.Backpack
            RegenerationM:StarModule()
        end
    end
    if CheckItems.Name == 'Bouncy Jelly' then
        local Bouncy = itemsSS["Bouncy Jelly"]
        if plr.Backpack:FindFirstChild(Bouncy.Name) or plr.Character:FindFirstChild(Bouncy.Name) then
            BouncyM:StarModule()
            return
        else
            local CloneItems = Bouncy:Clone()
            CloneItems.Parent = plr.Backpack
            BouncyM:StarModule()
        end
    end
end)

return DonatGetItems