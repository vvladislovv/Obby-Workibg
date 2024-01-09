local TagModule = {}
local rep = game:GetService("ReplicatedStorage") --You can change this to ServerStorage for more security.
local nametag = rep.NameTag 

local Developer = {
	707163568, -- vlad
	2213170051 -- bread
}
local GameDeveloper = {
	542308818 -- Darkness
}


game.Players.PlayerAdded:Connect(function(player)
	player.CharacterAdded:Connect(function(char)

		local head = char:WaitForChild("HumanoidRootPart")
		local newtext = nametag:Clone() --Cloning the text.
		local uppertext = newtext.UpperText
		local lowertext = newtext.LowerText
		local humanoid = char.Humanoid

		humanoid.DisplayDistanceType = "None"

		--Main Text
		newtext.Parent = head
		newtext.Adornee = head
		uppertext.Text = player.Name

		for _, Tags in pairs(Developer) do
			if table.find(Developer, player.UserId) then 
				lowertext.Text = "Developer"
				lowertext.TextColor3 = Color3.fromRGB(60, 255, 109)
			elseif table.find(GameDeveloper, player.UserId) then
				lowertext.Text = "Tester Game"
				lowertext.TextColor3 = Color3.fromRGB(255, 171, 53)
			else
				lowertext.Text = "Snail"
				lowertext.TextColor3 = Color3.fromRGB(234, 221, 170)
			end
		end
	end)
end)

return TagModule
