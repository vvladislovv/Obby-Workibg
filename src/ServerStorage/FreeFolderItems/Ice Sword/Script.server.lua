tool = script.Parent
debounce = nil
function Attack()
	if debounce == nil then
		local anim = tool:WaitForChild('Animation')
		local Hum = script.Parent.Parent:WaitForChild('Humanoid')
		local AnimTrack = Hum:LoadAnimation(anim) 
		AnimTrack:Play()	
		debounce = true
		task.wait(0.3)
		debounce = nil
	end
end

tool.Activated:Connect(Attack)

tool.Union.Touched:Connect(function(hit)
	local plr = game:GetService('Players'):GetPlayerFromCharacter(hit.Parent)
	if plr and debounce == true then
		plr.Character:WaitForChild("Humanoid").Health -= 15
	end
end)