local PhysicsService = game:GetService("PhysicsService")
local Player = game:GetService("Players")
local RS = game:GetService("ReplicatedStorage")
local Items = RS:FindFirstChild("Assert")
local DataSave = require(script.Parent.DataStore)
local PlayerGroup = PhysicsService:RegisterCollisionGroup("p")
PhysicsService:CollisionGroupSetCollidable("p","p", false)


local Equiment = {} do
    
	function NoCollide(Model)
        
            Model:WaitForChild("Humanoid")
            Model:WaitForChild("HumanoidRootPart")
            Model:WaitForChild("Head")
            for index, value in pairs(Model:GetChildren()) do
                if value:IsA("BasePart") then
                    value.CollisionGroup = "p"
                end
            end
        
    end

	function LoadImage(Players, PData)
        local BlackList = {
            ["Boot"] = true,
        }
		
    end

    function Equiment:LoadItems(Player, PData, Character)
        NoCollide(Character)
        print(PData.Equipment)
		local Humanoid = Character:FindFirstChild("Humanoid")

		Equiment:EquipItemsGame(Character, "Boot", Player)


		Humanoid.Died:Connect(function()
            local Character = Player.CharacterAdded:Wait()
            local PData = DataSave:Get(Player)
			Equiment:LoadItems(Player, PData, Character)
        end)
    end

    function Equiment:StartSysmes()
        Player.PlayerAdded:Connect(function(Player)
            task.wait()
            local Character = workspace:WaitForChild(Player.Name)
            local PData = DataSave:Get(Player)
            print(PData.Equipment)
            Equiment:LoadItems(Player, PData, Character)
            LoadImage(Player, PData)
        end)
    end

    function Equiment:EquipItemsGame(Character, TypeItem, Player)
        local PData = DataSave:Get(Player)
		if PData.Equipment[TypeItem] then
			if not PData.Loaded then
				repeat
					task.wait()
					PData = DataSave:Get(Player)
				until PData.Loaded
			end 
                local ItemObj1
                local ItemObj2
                if TypeItem == "Boot" then
                        if PData.Equipment[TypeItem] ~= "" then
                            local Christmas = require(game.ReplicatedStorage.Module.ItemsModule.Christmas)
                            ItemObj1 = Items:WaitForChild(TypeItem.."s")[PData.Equipment[TypeItem].."Left"]:Clone()
                            ItemObj2 = Items:WaitForChild(TypeItem.."s")[PData.Equipment[TypeItem].."Right"]:Clone()
                            Christmas:PLayerSpeed(Character.Humanoid)
                            Character.Humanoid:AddAccessory(ItemObj1)
                            Character.Humanoid:AddAccessory(ItemObj2)
                            ItemObj1.Name = "Boot"
                            ItemObj2.Name = "Boot"
                        end
                    end
        end
    end
end

return Equiment