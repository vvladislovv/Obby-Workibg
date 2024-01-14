local Christmas = {}

function Christmas:PLayerSpeed(Humanoid)
    if Humanoid then
        task.spawn(function()
            while true do
                task.wait()
                    if Humanoid.WalkSpeed <= 50 then
                        Humanoid.WalkSpeed = 50
                    end
                    if Humanoid.JumpHeight <= 35 then
                        Humanoid.JumpHeight = 35
                    end 
            end
        end)
    end
end

return Christmas