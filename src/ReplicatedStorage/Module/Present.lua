local Present = {}

local PresentF = game.Workspace:WaitForChild("Present")
local TS = game:GetService('TweenService')
local Players = game:GetService("Players")

local player = Players.LocalPlayer
local PresentValue = false
--local humanoid = character:WaitForChild("Humanoid")

local PRESS = 1

local RS = game:GetService('ReplicatedStorage')
local Remote = RS:WaitForChild('Remote')
local CoulDown = 25

task.spawn(function()
		task.wait()
		for _, open in next, PresentF:GetChildren() do
			open.Touched:Connect(function(hit)
				if hit.Parent == player.character and PresentValue == false then
					TS:Create(open, TweenInfo.new(2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Size = Vector3.new(0,0,0)}):Play()
					PresentValue = true
					--print(hit)
					Remote.Touched:FireServer(PresentValue,open)
					open.CanTouch = false
					task.wait(0.3)
					PresentValue = false
					task.wait(CoulDown)
					TS:Create(open, TweenInfo.new(2, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Size = Vector3.new(4.954, 6.755, 5.051)}):Play()
					open.CanTouch = true
				end
			end)
		end
end)




--_G.Present.Value = _G.Present.Value + PresentValue


return Present
