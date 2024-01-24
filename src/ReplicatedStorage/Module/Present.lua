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
		task.spawn(function()
			while true do
				task.wait()
				TS:Create(open, TweenInfo.new(8, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Orientation = Vector3.new(0,-360,0), Position = Vector3.new(open.Position.X,open.Position.Y+4,open.Position.Z)}):Play()
				task.wait(3)
				TS:Create(open, TweenInfo.new(8, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Orientation = Vector3.new(0,-360,0), Position = Vector3.new(open.Position.X,open.Position.Y-4,open.Position.Z)}):Play()
				task.wait(3)
			end
		end)

		open.Touched:Connect(function(hit)
			if hit.Parent == player.character and PresentValue == false then
				TS:Create(open, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Size = Vector3.new(0,0,0)}):Play()
				PresentValue = true
				--print(hit)
				Remote.Touched:FireServer(PresentValue,open)
				open.CanTouch = false
				task.wait(0.3)
				PresentValue = false
				task.wait(CoulDown)
				TS:Create(open, TweenInfo.new(0.5, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Size = Vector3.new(4.954, 6.755, 5.051)}):Play()
				open.CanTouch = true
			end
		end)
	end
end)




--_G.Present.Value = _G.Present.Value + PresentValue


return Present
