local Tool = script.Parent
local id = 'rbxassetid://15972394013'

Tool.Activated:Connect(function()
	if script.Parent.Parent:FindFirstChild("Humanoid") then
		local anim = Instance.new("Animation")
		anim.AnimationId = id
		local loadedanim = script.Parent.Parent.Humanoid:LoadAnimation(anim)
		loadedanim:Play()
		script.Parent.Parent.Humanoid.WalkSpeed = 50
		local PlayingAnimationTracks = script.Parent.Parent.Humanoid:GetPlayingAnimationTracks()
		for i, v in pairs(PlayingAnimationTracks) do
			if v.Name == 'ToolNoneAnim' then
				v:Stop()
				repeat wait() until loadedanim.IsPlaying == false
				v:Play()
			end
		end
	end
end)