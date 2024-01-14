local Cookies = {}

local CoulDown = 15

function Cookies:EatCook(Humanoid)
    if Humanoid then
        local mathEffect = math.random(1, 2)
        print(mathEffect)
            if mathEffect == 1 then
                Humanoid.JumpHeight = 25
                game.Players.PlayerAdded:Connect(function(client)
                    client.CharacterAdded:Connect(function(character)
                        character.Humanoid.Died:Connect(function()
                            Humanoid.JumpHeight = 9
                        end);
                    end);
                end);
                task.wait(CoulDown)
                Humanoid.JumpHeight = 9
            elseif mathEffect == 2 then
                Humanoid.WalkSpeed = 40
                game.Players.PlayerAdded:Connect(function(client)
                    client.CharacterAdded:Connect(function(character)
                        character.Humanoid.Died:Connect(function()
                            Humanoid.WalkSpeed = 20
                        end);
                    end);
                end);
                task.wait(CoulDown)
                Humanoid.WalkSpeed = 20
            end
    end
end


return Cookies