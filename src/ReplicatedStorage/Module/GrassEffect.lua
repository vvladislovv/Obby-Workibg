local InteractiveFoliage = workspace:WaitForChild('SnowGrass')
local Player = game:GetService('Players').LocalPlayer

local Effect = {}

for _, index in next, InteractiveFoliage:GetChildren()  do
	index.Touched:Connect(function(hit)
		if hit.Parent == Player.Character then
			index.ParticleEmitter.Enabled = true
			--print('Touched')
		end
		
	end)
	
	index.TouchEnded:Connect(function(hit)
		if hit.Parent == Player.Character then
			task.wait(0.5)
			--print('Touched not')
			index.ParticleEmitter.Enabled = false
		end
		--print('hit')

	end)
end

return Effect
