local ModuleLevel = {}
local LocalizationService = game:GetService('LocalizationService')
local TW = game:GetService('TweenService')
local ShopModule = require(script.Parent.ShopModule)

function PartDiead()
    local NineFolder = game.Workspace.PartDiead

    for _, Index in next, NineFolder:GetChildren() do
        --print(Index)
        Index.Touched:Connect(function(hit)
            if hit.Parent:FindFirstChild('Humanoid') then
                hit.Parent.Humanoid.Health = 0
            end
        end)
    end
end

function FlyPart()
    local FlyPart = game.Workspace.TenLevelOne.Fly

    for _, index in next, FlyPart:GetChildren() do
        TW:Create(index, TweenInfo.new(math.random(5,10), Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {Position = Vector3.new(index.Position.X, index.Position.Y-50, index.Position.Z)}):Play()
        task.wait()
    end
end

function OneLevelSpeed()
    local Speed = 5
    local RunLevel = game.Workspace:FindFirstChild('OneLevel')
    for	_, index in next, RunLevel:GetChildren() do
        while true do
            index.Velocity = index.CFrame.LookVector*Speed
            task.wait(0.1)
            break
        end
        index.Touched:Connect(function(hit)
            local Hum = hit.Parent:FindFirstChild('Humanoid')
            if Hum then
                Hum.WalkSpeed = 100
            end
            if hit.Parent:FindFirstChild('Humanoid') then
               if hit.Parent.Humanoid.Health == 0 then
                Hum.WalkSpeed = 20
               end
            end
        end)

        game.Workspace.StopOneLevel.StopSpeed.Touched:Connect(function(hit)
            local Hum = hit.Parent:FindFirstChild('Humanoid')
            if Hum then
                Hum.WalkSpeed = 20
            end
        end)

        game.Workspace.StopOneLevel.BlockOneLevel.Touched:Connect(function(hit)
            local Hum = hit.Parent:FindFirstChild('Humanoid')
            if Hum then
                Hum.WalkSpeed = 20
            end
        end)	

        
    end
end

function IceSpeed()
    local Speed = 5
    local IceFolder = game.Workspace:FindFirstChild('IceFolder')

    for	_, index in next, IceFolder:GetChildren() do
        while true do
            index.Velocity = index.CFrame.LookVector*Speed
            task.wait(0.1)
            break
        end
    end
end

function IceDown()
    local TenFolder = game.Workspace.IceDown

    for _, Index in next, TenFolder:GetChildren() do
        Index.Touched:Connect(function()
            if not Index.CanCollide then
                TW:Create(Index, TweenInfo.new(0.3, Enum.EasingStyle.Linear, Enum.EasingDirection.Out), {Transparency = 1}):Play()
                task.wait(15)
                Index.Transparency = 0
            end
        end)
    end
end

function StarLevel()
    local StarFolder = game.Workspace:FindFirstChild('StarLevel')
    local StarFolderBig = game.Workspace:FindFirstChild('StarBig')


    for _, index in next, StarFolder:GetChildren() do
        index.Touched:Connect(function(hit)
            TW:Create(index, TweenInfo.new(16, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Transparency = 1}):Play()
            if index.Transparency >= 0.7 then
                index.CanCollide = false
            end
            task.wait(25)
            TW:Create(index, TweenInfo.new(8, Enum.EasingStyle.Elastic, Enum.EasingDirection.Out), {Transparency = 0}):Play()
            index.CanCollide = true
        end)
        TW:Create(index, TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1), {Orientation = Vector3.new(0,360,-90)}):Play()
    end
end

function DownThreeLevel()
    local Thrlevel = game.Workspace.ThreeDown
    for _, index in next, Thrlevel:GetChildren() do
        index.Touched:Connect(function(hit)
            if index.CanCollide == true then
                return
            else
                TW:Create(index, TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{Transparency = 1, Position = Vector3.new(index.Position.X,index.Position.Y-60, index.Position.Z)}):Play()
            -- Position = Vector3.new(index.Position.X, -61.7, index.Position.Z)
                task.wait(15)
                TW:Create(index, TweenInfo.new(2,Enum.EasingStyle.Linear,Enum.EasingDirection.InOut),{Transparency = 0,Position = Vector3.new(index.Position.X,index.Position.Y+60, index.Position.Z)}):Play()
                index.CanTouch = false
                task.wait(2)
                index.CanTouch = true
            end
        end)	
    end
end

function Icile()
    local player = game:GetService('Players').LocalPlayer
    local FolderIcicle = game.Workspace:WaitForChild('IcicleCould')

    for _, index in next, FolderIcicle:GetChildren() do
    --	print('starter')
        TW:Create(index, TweenInfo.new(math.random(0,15), Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {Position = Vector3.new(index.Position.X, index.Position.Y-450, index.Position.Z)}):Play()
        task.wait()
        index.Touched:Connect(function(hit)
            if hit.Parent == player.Character then
                hit.Parent.Humanoid.Health = 0
            end
        end)
    end
end

function StartRoteta()
    local StarRoteta = game.Workspace.StarRoteta

    for _, v in next, StarRoteta:GetChildren() do
        TW:Create(v, TweenInfo.new(math.random(5,10), Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {Orientation = Vector3.new(v.Orientation.X-360,v.Orientation.Y,v.Orientation.Z)}):Play()
        v.Touched:Connect(function(hit)
            if hit.Parent:FindFirstChild('Humanoid') then
                hit.Parent.Humanoid.Health = 0
            end
        end)
    end
end

function TreeFly()
    local TreeFly = game.Workspace.TreeFly

        for _, index in next, TreeFly:GetChildren() do
            TW:Create(index, TweenInfo.new(math.random(5,8), Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {Position = Vector3.new(index.Position.X, index.Position.Y-50, index.Position.Z)}):Play()
            task.wait()
        end
end

function HolmSystems()
    local ShepFolder = game.Workspace:WaitForChild('ShrepFolder')
    local RS = game:GetService('ReplicatedStorage')
    local Player = game:GetService('Players').LocalPlayer
    task.spawn(function()
        local NewShep = ShepFolder.Shrep1:Clone()
        NewShep.Parent = ShepFolder
        NewShep.Name = 'NewSherp'
        NewShep.Position = ShepFolder.Spawn.Position
        NewShep.Color = Color3.fromRGB(255, 255, 255)
        NewShep.Anchored = false
        ShepFolder.BarierOne.Touched:Connect(function(hit)
            if hit.Name == "NewSherp" then
                --print(hit)
                hit:Destroy()
                task.wait(10)
                local NewShep = ShepFolder.Shrep1:Clone()
                NewShep.Parent = ShepFolder
                NewShep.Name = 'NewSherp'
                NewShep.Position = ShepFolder.Spawn.Position
                NewShep.Color = Color3.fromRGB(255, 255, 255)
                NewShep.Anchored = false
                
                NewShep.Touched:Connect(function(hit)
                    if hit.Parent == Player.Character then
                        hit.Parent.Humanoid.Health = 0 
                    end
                end)
            end
        end)
    end)
end

function DonatDoor()
    local DonatFolder  = game.Workspace:WaitForChild('PartOwner'):WaitForChild('DonatDoors')
    local ProductID = 677129437
    local PartComDonat = workspace.PartOwner.DonatLoci

    local TW = game:GetService('TweenService')

    local MS = game:GetService('MarketplaceService')
    local Player = game.Players.LocalPlayer
    local Remote = game:GetService('ReplicatedStorage'):WaitForChild('Remote')

    local PlayerGui = game:GetService('Players').LocalPlayer:WaitForChild('PlayerGui')
    local ShopDonat = PlayerGui:WaitForChild('ShopDonat')
    local FrameUpper = ShopDonat.FrameUpper

    local NoButton = FrameUpper.FrameTwoUpper.CloseButton.TextButton
    local YesButton = FrameUpper.FrameTwoUpper.OpenButton.TextButton

    local OpenDonat = false
    local OpenGui = false
    local ScreenGUi = true
    local UIS = game:GetService('UserInputService')

    local IndexNow
    local FolderButton = game.Workspace:WaitForChild('PartOwner').DonatLoking
    for _, index in next, FolderButton:GetChildren() do
        index.ProximityPrompt.Triggered:Connect(function(hit)
            if hit then
               -- print(index)
                if ScreenGUi == true then
                   -- print('Open')
                    IndexNow = index
                    FrameUpper:TweenSize(UDim2.new(0, 677,0, 256), 'InOut','Quint',0.1, true)
                    ScreenGUi = false
                else
                   -- print('Close')
                    FrameUpper:TweenSize(UDim2.new(0, 0,0, 0), 'InOut','Quint',0.1, true)
                    ScreenGUi = true
                end
                
            end
        end)
    end
    NoButton.MouseButton1Click:Connect(function()
        FrameUpper:TweenSize(UDim2.new(0, 0,0, 0), 'InOut','Quint',0.5, true)
        ScreenGUi = true
    end)
---    Remote.OpenDonatLoki:FireServer(index)
    YesButton.MouseButton1Click:Connect(function()
        Remote.OpenDonatLoki:FireServer(IndexNow)
        FrameUpper:TweenSize(UDim2.new(0, 0,0, 0), 'InOut','Quint',0.5, true)
        ScreenGUi = true
    end)


    DonatFolder.Loked.ClickDetector.MouseClick:Connect(function()
        if MS:UserOwnsGamePassAsync(Player.UserId, ProductID) then
            TW:Create(DonatFolder, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {Transparency = 0.6, Color = Color3.fromRGB(89, 255, 12), CanCollide = false}):Play()
           -- print('Open door')
        else
            MS:PromptGamePassPurchase(Player, ProductID)
           -- print('no')
        end
    end)

    PartComDonat.Touched:Connect(function(hit)
        if hit.Parent == Player.Character then
            if MS:UserOwnsGamePassAsync(Player.UserId, ProductID) then
            else
                if hit.Parent:FindFirstChild('Humanoid') then
                    hit.Parent.Humanoid.Health = 0
                end
            end
        end
    end)
    
end

function nextLevelDonat()
    local NextLevelDonat = game.Workspace.PartOwner.NextLevelDonat
    local ProductID = 681992219
    local MS = game:GetService('MarketplaceService')
	local Player = game.Players.LocalPlayer
    local NextLevel = false
	local Remote = game:GetService('ReplicatedStorage'):WaitForChild('Remote')
	 
    for _, indexDonat in next, NextLevelDonat:GetChildren()do
        indexDonat.Touched:Connect(function(hit)
            print(Player.UserId)
            if hit.Parent == Player.Character then
                if not MS:UserOwnsGamePassAsync(Player.UserId, ProductID) then
                    NextLevel = true
                    --TW:Create(DonatFolder, TweenInfo.new(1, Enum.EasingStyle.Linear, Enum.EasingDirection.In), {Transparency = 0.6, Color = Color3.fromRGB(89, 255, 12), CanCollide = false}):Play()
                    Remote.NextCheckPoint:FireServer(NextLevel)
                else
                    NextLevel = false
                    MS:PromptGamePassPurchase(Player, ProductID)
                end
            end 
        end) 
    end
end

function LevelDonatPass()
	local DonatFolderPass = game.Workspace.PartOwner.DonatPass.DonatLevel
    local Remote = game:GetService("ReplicatedStorage"):WaitForChild('Remote')
    local MS = game:GetService('MarketplaceService')
    local ProductID = 682049099
    local ProductUsers = false
    local Player = game.Players.LocalPlayer

    --for _, IndexPass in next, DonatFolder:GetChildren() do
    DonatFolderPass.Touched:Connect(function(hit)
        print(hit.Parent)
            print(Player.Character)
        if hit.Parent == Player.Character then
            if MS:UserOwnsGamePassAsync(Player.UserId, ProductID) then
                -- print('asasdfasd')
                 ProductUsers = true
                 Remote.DonatCheck:FireServer(ProductUsers)
             else
                -- print('ffff')
                 ProductUsers = false
                 MS:PromptGamePassPurchase(Player, ProductID)
             end 
        end
    end)
end
--end
function SharpRotate()
    local Sharp = game.Workspace.SharpRotate

    for _, v in next, Sharp:GetChildren() do
        TW:Create(v, TweenInfo.new(15, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {Orientation = Vector3.new(-360,-360,-360)}):Play()
    end
end

function AnimCoids()
    local CouldsAnim = game.Workspace:WaitForChild('CouldsAnim')

    local Could1 = CouldsAnim:WaitForChild('Cloud1')
    local Could2 = CouldsAnim:WaitForChild('Cloud2')

    TW:Create(Could1, TweenInfo.new(15, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {Position = Vector3.new(211.203, 542.197, -533.392)}):Play()
    TW:Create(Could2, TweenInfo.new(15, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {Position = Vector3.new(267.366, 547.46, -578.266)}):Play()

end

function VenterRotate()
    local Model = workspace:WaitForChild('Venter')

    for _, obj in next, Model:GetChildren() do
        task.spawn(function()
            obj:WaitForChild('Part')
            while true do
                task.wait()
                obj:SetPrimaryPartCFrame(obj.PrimaryPart.CFrame*CFrame.Angles(0,0, math.rad(4)))
            end
        end)
        task.wait(math.random())
    end
end

function FlyPlatform()
	task.spawn(function()
		local Folder = game.Workspace.FivteeryLevel
		local TW = game:GetService("TweenService")
			for _, index in next, Folder:GetChildren() do
				TW:Create(index, TweenInfo.new(4, Enum.EasingStyle.Linear, Enum.EasingDirection.Out, -1), {Orientation = Vector3.new(0,360,-90)}):Play()
                index.Touched:Connect(function(hit)
                    if hit.Parent:FindFirstChild('Humanoid') then
                        hit.Parent.Humanoid.Health = 0
                    end
                end)
            end
	end)
end

function ModuleLevel:StartLevel()
    PartDiead()
    FlyPart()
    OneLevelSpeed()
    IceSpeed()
    IceDown()
    StarLevel()
    DownThreeLevel()
    Icile()
    TreeFly()
    StartRoteta()
    HolmSystems()
    DonatDoor()
    LevelDonatPass()
    nextLevelDonat()
    SharpRotate()
    AnimCoids()
    VenterRotate()
    FlyPlatform()
    print('Start Full Program')
end

return ModuleLevel