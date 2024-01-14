local Snow = {}

local TS = game:GetService('TweenService')
local SnowFolder = game.Workspace:WaitForChild('SnowGrass')
--local Zone = require(game.ServerScriptService:WaitForChild('Zone'))


function Snow.Animer()
	for _, i in next, SnowFolder:GetChildren() do
		i.Touched:Connect(function()
			--TS:Create(i, TweenInfo.new(0.55, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Orientation = i.Orientation + Vector3.new(1,0,1)}):Play()
			print("Надо сделать анимацию")
		end)
	end
end

Snow.Animer()

return Snow
