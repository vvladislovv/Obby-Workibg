local rs = game.ReplicatedStorage:WaitForChild("AdminPanelRS")
local re = rs:WaitForChild("RE")
local admins = require(rs:WaitForChild("AdminsModule"))

local uis = game:GetService("UserInputService")
local ts = game:GetService("TweenService")

local panel = script.Parent:WaitForChild("AdminPanel")
panel.Visible = false
local announcement = script.Parent:WaitForChild("AnnouncementsFrame")
announcement.Visible = false

local plrId = game.Players.LocalPlayer.UserId


--Receive announcements
local goalTransparency = announcement.Transparency



--Update list of players in admin panel
local selectPlrFrame = panel.Pages.MainButtonsFrame.ButtonsScroller.SelectPlayerFrame
local scroller = selectPlrFrame.PlayersScroller
local selectedFrame = selectPlrFrame.SelectedPlayerFrame
selectedFrame.Visible = false

function updatePlayers()
	for i, child in pairs(scroller:GetChildren()) do
		if child:IsA("TextButton") then
			child:Destroy()
		end
	end
	
	for i, plr in pairs(game.Players:GetPlayers()) do
		
		local btn = script.PlayerButton:Clone()
		
		local name = plr.Name
		btn.PlayerName.Text = name
		
		local image = game.Players:GetUserThumbnailAsync(plr.UserId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
		btn.PlayerImage.Image = image
		
		btn.MouseButton1Click:Connect(function()
			
			selectedFrame.PlayerName.Text = name
			selectedFrame.DisplayName.Text = "@" .. plr.DisplayName
			selectedFrame.UserId.Text = plr.UserId
			selectedFrame.InGame.Text = "Currently in server 🟢"
			selectedFrame.PlayerImage.Image = image
			
			selectedFrame.Visible = true
		end)
		
		btn.Parent = scroller
	end
end
updatePlayers()
game.Players.PlayerAdded:Connect(updatePlayers)
game.Players.PlayerRemoving:Connect(updatePlayers)


--If not admin, delete admin panel
if not table.find(admins, plrId) then
	panel:Destroy()
	
--If admin, give access to admin panel
else
	--Alert user they are an admin
	
	uis.InputBegan:Connect(function(inp, p)
		if not p and inp.KeyCode == Enum.KeyCode.Q then --Press B on keyboard to open admin panel
			panel.Visible = not panel.Visible
		end
	end)
	
	panel.CloseButton.MouseButton1Click:Connect(function() --Close admin panel when button is clicked on
		panel.Visible = false
	end)
	
	selectPlrFrame.UserIdBox.FocusLost:Connect(function() --Search UserIds to select players not in the same server as the admin
		local userId = selectPlrFrame.UserIdBox.Text
		
		if tonumber(userId) then
			local plrInfo = game:GetService("UserService"):GetUserInfosByUserIdsAsync({tonumber(userId)})[1]
			if plrInfo then
				local username = plrInfo.Username
				local displayName = plrInfo.DisplayName
				local inServer = game.Players:FindFirstChild(username)
				local image = game.Players:GetUserThumbnailAsync(userId, Enum.ThumbnailType.HeadShot, Enum.ThumbnailSize.Size100x100)
				
				selectedFrame.PlayerName.Text = username
				selectedFrame.DisplayName.Text = "@" .. displayName
				selectedFrame.UserId.Text = userId
				selectedFrame.InGame.Text = inServer and "Currently in server 🟢" or "Not in server 🔴"
				selectedFrame.PlayerImage.Image = image

				selectedFrame.Visible = true
			end
		end
	end)
	
	--Command Bar
	panel.CommandBar.FocusLost:Connect(function(enterPressed)
		if enterPressed then
			re:FireServer("COMMAND BAR", panel.CommandBar.Text)
		end
	end)
	
	local btns = panel.Pages.MainButtonsFrame.ButtonsScroller; btns.Parent.Visible = true
	local btnsPre = panel.Pages.PresentFrame; btnsPre.Parent.Visible = true
	local btnsChek = panel.Pages.CheckpointFrame; btnsChek.Parent.Visible = true
	local muteFrame = panel.Pages.MuteFrame; muteFrame.Visible = false
	local banFrame = panel.Pages.BanFrame; banFrame.Visible = false
	local kickFrame = panel.Pages.KickFrame; kickFrame.Visible = false
	local annFrame = panel.Pages.AnnounceFrame; annFrame.Visible = false
	local shutFrame = panel.Pages.ShutdownFrame; shutFrame.Visible = false
	local presntFrame = panel.Pages.PresentFrame; presntFrame.Visible = false
	local CheckFrame = panel.Pages.CheckpointFrame; CheckFrame.Visible = false
	
	--MODERATION BUTTONS
	--Mute Button
	btns.ModerationButtons.MuteButton.MouseButton1Click:Connect(function()
		if tonumber(selectedFrame.UserId.Text) then
			muteFrame.DisplayName.Text = selectedFrame.DisplayName.Text
			muteFrame.PlayerName.Text = selectedFrame.PlayerName.Text
			muteFrame.PlayerImage.Image = selectedFrame.PlayerImage.Image
			muteFrame.Visible = true
			btns.Parent.Visible = false
		end
	end)
	muteFrame.BackButton.MouseButton1Click:Connect(function()
		btns.Parent.Visible = true
		muteFrame.Visible = false
	end)
	muteFrame.ConfirmButton.MouseButton1Click:Connect(function()
		local name = string.gsub(muteFrame.PlayerName.Text, "@", "")
		local targetId = game.Players:GetUserIdFromNameAsync(name)
		local length = tonumber(muteFrame.MuteLengthBox.Text)
		if targetId and length then
			btns.Parent.Visible = true
			muteFrame.Visible = false
			re:FireServer("MUTE", length, targetId)
		end
	end)
	
	--Unmute Button
	btns.ModerationButtons.UnmuteButton.MouseButton1Click:Connect(function()
		if tonumber(selectedFrame.UserId.Text) then
			re:FireServer("UNMUTE", nil, tonumber(selectedFrame.UserId.Text))
		end
	end)
	--Ban Button
	btns.ModerationButtons.BanButton.MouseButton1Click:Connect(function()
		if tonumber(selectedFrame.UserId.Text) then
			banFrame.DisplayName.Text = selectedFrame.DisplayName.Text
			banFrame.PlayerName.Text = selectedFrame.PlayerName.Text
			banFrame.PlayerImage.Image = selectedFrame.PlayerImage.Image
			panel.Pages.BanFrame.Visible = true
			btns.Parent.Visible = false
		end
	end)
	banFrame.BackButton.MouseButton1Click:Connect(function()
		btns.Parent.Visible = true
		banFrame.Visible = false
	end)
	banFrame.ConfirmButton.MouseButton1Click:Connect(function()
		local name = string.gsub(banFrame.PlayerName.Text, "@", "")
		local targetId = game.Players:GetUserIdFromNameAsync(name)
		local length = tonumber(banFrame.BanLengthBox.Text)
		local compiled = {length, banFrame.ReasonBox.Text}
		if targetId and length then
			btns.Parent.Visible = true
			banFrame.Visible = false
			re:FireServer("BAN", compiled, targetId)
		end
	end)
	--Unban Button
	btns.ModerationButtons.UnbanButton.MouseButton1Click:Connect(function()
		if tonumber(selectedFrame.UserId.Text) then
			re:FireServer("UNBAN", nil, tonumber(selectedFrame.UserId.Text))
		end
	end)
	--Kick Button
	btns.ModerationButtons.KickButton.MouseButton1Click:Connect(function()
		if tonumber(selectedFrame.UserId.Text) then
			kickFrame.DisplayName.Text = selectedFrame.DisplayName.Text
			kickFrame.PlayerName.Text = selectedFrame.PlayerName.Text
			kickFrame.PlayerImage.Image = selectedFrame.PlayerImage.Image
			panel.Pages.KickFrame.Visible = true
			btns.Parent.Visible = false
		end
	end)
	kickFrame.BackButton.MouseButton1Click:Connect(function()
		btns.Parent.Visible = true
		kickFrame.Visible = false
	end)
	kickFrame.ConfirmButton.MouseButton1Click:Connect(function()
		local name = string.gsub(kickFrame.PlayerName.Text, "@", "")
		local targetId = game.Players:GetUserIdFromNameAsync(name)
		local reason = kickFrame.ReasonBox.Text
		if targetId then
			btns.Parent.Visible = true
			kickFrame.Visible = false
			re:FireServer("KICK", reason, targetId)
		end
	end)
	
	--CHARACTER BUTTONS
	--Go To Button
	btns.CharacterButtons.GoToButton.MouseButton1Click:Connect(function()
		if tonumber(selectedFrame.UserId.Text) then
			re:FireServer("GO TO", nil, tonumber(selectedFrame.UserId.Text))
		end
	end)
	--Bring Button
	btns.CharacterButtons.BringButton.MouseButton1Click:Connect(function()
		if tonumber(selectedFrame.UserId.Text) then
			re:FireServer("BRING", nil, tonumber(selectedFrame.UserId.Text))
		end
	end)
	--Freeze Button
	btns.CharacterButtons.FreezeButton.MouseButton1Click:Connect(function()
		if tonumber(selectedFrame.UserId.Text) then
			re:FireServer("FREEZE", nil, tonumber(selectedFrame.UserId.Text))
		end
	end)
	--Unfreeze Button
	btns.CharacterButtons.UnfreezeButton.MouseButton1Click:Connect(function()
		if tonumber(selectedFrame.UserId.Text) then
			re:FireServer("UNFREEZE", nil, tonumber(selectedFrame.UserId.Text))
		end
	end)
	--Speed Input Box
	btns.CharacterButtons.WalkSpeedBox.FocusLost:Connect(function(enterPressed)
		if enterPressed and tonumber(selectedFrame.UserId.Text) then
			re:FireServer("SPEED", tonumber(btns.CharacterButtons.WalkSpeedBox.Text), tonumber(selectedFrame.UserId.Text))
		end
	end)
	--Jump Input Box
	btns.CharacterButtons.JumpHeightBox.FocusLost:Connect(function(enterPressed)
		if enterPressed and tonumber(selectedFrame.UserId.Text) then
			re:FireServer("JUMP", tonumber(btns.CharacterButtons.JumpHeightBox.Text), tonumber(selectedFrame.UserId.Text))
		end
	end)
	
	btnsPre.IndexBox.FocusLost:Connect(function(enterPressed)
		if enterPressed and tonumber(selectedFrame.UserId.Text) then
			local Text = btnsPre.IndexBox.Text
			re:FireServer("Present", tonumber(btnsPre.IndexBox.Text), tonumber(selectedFrame.UserId.Text), Text)
		end
	end)
	
	btnsChek.IndexBox.FocusLost:Connect(function(enterPressed)
		if enterPressed and tonumber(selectedFrame.UserId.Text) then
			local Text = btnsChek.IndexBox.Text
			re:FireServer("Checkpoint", tonumber(btnsChek.IndexBox.Text), tonumber(selectedFrame.UserId.Text), Text)
		end
	end)
	--Health Input Box
	btns.CharacterButtons.HealthBox.FocusLost:Connect(function(enterPressed)
		if enterPressed and tonumber(selectedFrame.UserId.Text) then
			re:FireServer("HEALTH", tonumber(btns.CharacterButtons.HealthBox.Text), tonumber(selectedFrame.UserId.Text))
		end
	end)
	
	--SYSTEM BUTTONS
	--Announce Button
	btns.SystemButtons.AnnounceButton.MouseButton1Click:Connect(function()
		panel.Pages.AnnounceFrame.Visible = true
		btns.Parent.Visible = false
	end)
	annFrame.BackButton.MouseButton1Click:Connect(function()
		btns.Parent.Visible = true
		annFrame.Visible = false
	end)
	local server = annFrame.ServerButton
	local global = annFrame.GlobalButton
	server.CircleBackground.CircleFill.Visible = true
	server.MouseButton1Click:Connect(function()
		global.CircleBackground.CircleFill.Visible = false
		server.CircleBackground.CircleFill.Visible = true
	end)
	global.CircleBackground.CircleFill.Visible = false
	global.MouseButton1Click:Connect(function()
		server.CircleBackground.CircleFill.Visible = false
		global.CircleBackground.CircleFill.Visible = true
	end)
	annFrame.ConfirmButton.MouseButton1Click:Connect(function()
		local message = annFrame.AnnouncementBox.Text
		local messageGlobal = global.CircleBackground.CircleFill.Visible and "GLOBAL" or "SERVER"
		if string.len(message) > 0 then
			btns.Parent.Visible = true
			annFrame.Visible = false
			re:FireServer("ANNOUNCE", message, messageGlobal)
		end
	end)
	--Shutdown Button
	btns.SystemButtons.ShutdownButton.MouseButton1Click:Connect(function()
		panel.Pages.ShutdownFrame.Visible = true
		btns.Parent.Visible = false
	end)
	
	panel.Pages.MainButtonsFrame.ButtonsScroller.DataButtons.PresentButton.MouseButton1Click:Connect(function()
		panel.Pages.PresentFrame.Visible = true
	end)
	panel.Pages.MainButtonsFrame.ButtonsScroller.DataButtons.CheckpointButton.MouseButton1Click:Connect(function()
		panel.Pages.CheckpointFrame.Visible = true
	end)
	
	presntFrame.BackButton.MouseButton1Click:Connect(function()
		panel.Pages.PresentFrame.Visible = false
		btns.Parent.Visible = true
	end)
	
	CheckFrame.BackButton.MouseButton1Click:Connect(function()
		panel.Pages.CheckpointFrame.Visible = false
		btns.Parent.Visible = true
	end)
	
	shutFrame.BackButton.MouseButton1Click:Connect(function()
		panel.Pages.ShutdownFrame.Visible = false
		btns.Parent.Visible = true
	end)
	shutFrame.ConfirmButton.MouseButton1Click:Connect(function()
		btns.Parent.Visible = true
		shutFrame.Visible = false
		re:FireServer("SHUT DOWN")
	end)
end