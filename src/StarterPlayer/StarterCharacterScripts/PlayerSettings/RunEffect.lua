local Player = game:GetService("Players").LocalPlayer
local Character = Player.Character or Player.CharacterAdded:Wait()
local Humanoid = Character:WaitForChild("Humanoid")

local lEffect = Character:WaitForChild("LeftFoot")
local rEffect = Character:WaitForChild("RightFoot")

local ef1 = game.ReplicatedStorage.Assert.RunPlayerEffect.Effect:Clone()
local ef2 = game.ReplicatedStorage.Assert.RunPlayerEffect.Effect:Clone()

local REfect = {}

ef1.Parent = lEffect
ef2.Parent = rEffect

Humanoid.Running:Connect(function(speed)
    if speed > 5 then
        ef2.Enabled = true
        ef1.Enabled = true
    else
        ef2.Enabled = false
        ef1.Enabled = false
    end
end)

Humanoid.Seated:Connect(function(isSeat)
	if isSeat then 
		ef1.Enabled = false
		ef2.Enabled = false
	end
	
end)

Humanoid.Jumping:Connect(function(isJumping)
    if isJumping then
        ef2.Enabled = false
        ef1.Enabled = false
    end
end)

return REfect