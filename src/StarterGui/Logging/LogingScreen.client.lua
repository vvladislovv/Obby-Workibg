local Loging = script.Parent.Frame1
local TextLoging = Loging.Text
local image = Loging.ImageLabel

Loging.Visible = true
local CouldTime = task.wait(0.35)
--GuiScreen = true
local TW = game:GetService("TweenService")
--local Lobby = script.Parent.Lobby

---screen Enabled
script.Parent.Parent.MettaGui.Present.Visible = false

script.Parent.Parent.MettaGui.Checkpoint.Visible = false

function GuiStart()
	local Teleporting = script.Parent.Parent.TeleportObby.Frame
	local TextTeleporting = Teleporting.TextLabel
	Teleporting.Visible = true
	local Stoper = 0
	repeat
		TextTeleporting.Text = "Teleporting"
		task.wait(CouldTime)
		TextTeleporting.Text = "Teleporting."
		task.wait(CouldTime)
		TextTeleporting.Text = "Teleporting.."
		task.wait(CouldTime)
		TextTeleporting.Text = "Teleporting..."
		task.wait(CouldTime)
		Stoper += 1
	until Stoper == 5
	
	if  Stoper == 5 then
		Teleporting.Visible = false
		TextTeleporting.Visible = false
		Text()
	end
end

function Text()
	local TextL = 0
	Loging.Visible = true
	image.Visible = true
	TextLoging.Visible = true
	repeat
		TextLoging.Text = "Loading"
		task.wait(CouldTime)
		TextLoging.Text = "Loading."
		task.wait(CouldTime)
		TextLoging.Text = "Loading.."
		task.wait(CouldTime)
		TextLoging.Text = "Loading..."
		task.wait(CouldTime)
		TextL += 1
	until TextL == 4
end
GuiStart()


TW:Create(Loging, TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {Transparency = 1}):Play()
TW:Create(image, TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {ImageTransparency = 1}):Play()
TW:Create(TextLoging, TweenInfo.new(1.5, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut), {Transparency = 1}):Play()



script.Parent.Parent.MettaGui.Present.Visible = true

script.Parent.Parent.MettaGui.Checkpoint.Visible = true




	
	

