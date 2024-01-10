task.wait()
local Platform = game.Workspace:WaitForChild('PartOwner'):WaitForChild('MagazineBuyS')
local Player = game:GetService("Players").LocalPlayer
local Sound = game:GetService('SoundService')
local UIS = game:GetService('UserInputService')
local PlayerGui = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui')
local magazine = PlayerGui:WaitForChild('Magazine')
local TW = game:GetService('TweenService')
local HumRootPart = Player.Character:WaitForChild('HumanoidRootPart')
local Remote = game:GetService('ReplicatedStorage'):WaitForChild('Remote')

--local Distance = (Magazine.Position-HumRootPart.Position).Magnitude

local GuiModule = {}
local ScreenGUi = true

function OpenGui()
	for _, Index in next, Platform:GetChildren() do
		Index.ProximityPrompt.Triggered:Connect(function(hit)
			if ScreenGUi == true then
				TW:Create(magazine.FrameGlobule, TweenInfo.new(1,Enum.EasingStyle.Quint, Enum.EasingDirection.InOut),{Position = UDim2.new(0.185, 0,0.15, 0)}):Play() -- UDim2.new(0.185, 0,1, 0)
				ScreenGUi = false
			else
				TW:Create(magazine.FrameGlobule, TweenInfo.new(1,Enum.EasingStyle.Quint, Enum.EasingDirection.InOut),{Position = UDim2.new(0.185, 0,6, 0)}):Play()
				ScreenGUi = true
			end
		end)
	end
end

OpenGui()

magazine.FrameGlobule.Frame.CloseFrame.Close.MouseButton1Click:Connect(function()
	TW:Create(magazine.FrameGlobule, TweenInfo.new(1,Enum.EasingStyle.Quint, Enum.EasingDirection.InOut),{Position = UDim2.new(0.185, 0,6, 0)}):Play()
end)

task.spawn(function()
	magazine.FrameGlobule.Frame.FrameProduct.ProductOne.Frame.FrameButton.TextButton.MouseButton1Click:Connect(function()
		local Cost = tonumber(magazine.FrameGlobule.Frame.FrameProduct.ProductOne.Frame.CostFrame.TextLabel.Text)
		local IndexProduct = 1
		Remote.BuyShop:FireServer(Cost, IndexProduct)
		
	end)
	magazine.FrameGlobule.Frame.FrameProduct.ProductTwo.Frame.FrameButton.TextButton.MouseButton1Click:Connect(function()
		local Cost = tonumber(magazine.FrameGlobule.Frame.FrameProduct.ProductTwo.Frame.CostFrame.TextLabel.Text)
		local IndexProduct = 2
		Remote.BuyShop:FireServer(Cost, IndexProduct)
		
	end)
	magazine.FrameGlobule.Frame.FrameProduct.ProductThree.Frame.FrameButton.TextButton.MouseButton1Click:Connect(function()
		local Cost = tonumber(magazine.FrameGlobule.Frame.FrameProduct.ProductThree.Frame.CostFrame.TextLabel.Text)
		local IndexProduct = 3
		Remote.BuyShop:FireServer(Cost, IndexProduct)
		
	end)
	magazine.FrameGlobule.Frame.FrameProduct.ProductFour.Frame.FrameButton.TextButton.MouseButton1Click:Connect(function()
		local Cost = tonumber(magazine.FrameGlobule.Frame.FrameProduct.ProductFour.Frame.CostFrame.TextLabel.Text)
		local IndexProduct = 4
		Remote.BuyShop:FireServer(Cost, IndexProduct)
		
	end)
	magazine.FrameGlobule.Frame.FrameProduct.ProductFive.Frame.FrameButton.TextButton.MouseButton1Click:Connect(function()
		local Cost = tonumber(magazine.FrameGlobule.Frame.FrameProduct.ProductFive.Frame.CostFrame.TextLabel.Text)
		local IndexProduct = 5
		Remote.BuyShop:FireServer(Cost, IndexProduct)
		
	end)
end)

return GuiModule
