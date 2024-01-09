local GuiStatsModule = {}

local Player = game:GetService('Players').LocalPlayer
local PlayerGui = Player:WaitForChild("PlayerGui")
--Stast
local MettaGui = PlayerGui:WaitForChild('MettaGui')

local Checkpoint = MettaGui.Checkpoint
local NameStats = Checkpoint.FrameTwo.NameStats
local ItemserChk = Checkpoint.FrameTwo.Items

local Present = MettaGui.Present
local NameStats = Present.FrameTwo.NameStats
local Itemser = Present.FrameTwo.Items

function UpdateGuiPresent()
    task.wait()
    _G.PData = game.ReplicatedStorage.Remote.GetDataSave:InvokeServer()

    Itemser.Text = _G.PData.BaseSettings.Present

end

function UpdateGuiCheckPoint()
    task.wait()
    _G.PData = game.ReplicatedStorage.Remote.GetDataSave:InvokeServer()

    ItemserChk.Text = _G.PData.BaseSettings.Checkpoint

end

UpdateGuiPresent()
UpdateGuiCheckPoint()

return GuiStatsModule