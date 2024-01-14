tool = script.Parent
debounce = nil
local CoulDown = 15
function Start()
	if debounce == nil then
		local anim = tool:WaitForChild('Animation')
		local Hum = script.Parent.Parent:WaitForChild('Humanoid')
		local AnimTrack = Hum:LoadAnimation(anim) 
		AnimTrack:Play()	
		EatCook(Hum)
		debounce = true
		task.wait(CoulDown)
		debounce = nil
	end
end

function EatCook(Humanoid)
	if Humanoid then
		Humanoid.JumpHeight = 25
		Humanoid.WalkSpeed = 40
		game.Players.PlayerAdded:Connect(function(client)
			client.CharacterAdded:Connect(function(character)
				character.Humanoid.Died:Connect(function()
					Humanoid.JumpHeight = 9
					Humanoid.WalkSpeed = 20
				end);
			end);
		end);

		task.wait(CoulDown)
		Humanoid.JumpHeight = 9
		Humanoid.WalkSpeed = 20
	end
end
tool.Activated:Connect(Start)

