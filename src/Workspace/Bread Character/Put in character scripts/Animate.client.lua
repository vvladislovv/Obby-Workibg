


-- Very basic walking animation script by GnomeCode
local character = script.Parent
local humanoid = character:WaitForChild("Humanoid")

-- Remeber to select the animtion object and set the id to your own!
local walkAnim = script:WaitForChild("Walk")
local walkAnimTrack = humanoid.Animator:LoadAnimation(walkAnim)

humanoid.Running:Connect(function(speed)
	if speed > 0 then
		if not walkAnimTrack.IsPlaying then
			walkAnimTrack:Play()
		end
	else
		if walkAnimTrack.IsPlaying then
			walkAnimTrack:Stop()
		end
	end
end)