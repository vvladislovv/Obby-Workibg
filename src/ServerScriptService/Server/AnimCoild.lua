local AnimCould = {}
local CouldsAnim = game.Workspace:WaitForChild('CouldsAnim')

local Could1 = CouldsAnim:WaitForChild('Cloud1')
local Could2 = CouldsAnim:WaitForChild('Cloud2')

    task.spawn(function()
        while true do
            task.wait(5)
            Could2.Start.Attachment1.Parent = Could2.End
            --   print('End')
            task.wait(5)
            Could2.End.Attachment1.Parent = Could2.Start
            --  print('Start')
            task.wait(5)
        end
    end)

    task.spawn(function()
        while true do
            task.wait(5)
            Could1.Start.Attachment1.Parent = Could1.End
            -- print('End')
            task.wait(5)
            Could1.End.Attachment1.Parent = Could1.Start
            --print('Start')
            task.wait(5)
        end
    end)

return AnimCould
-- TW:Create(Could1, TweenInfo.new(15, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {Position = Vector3.new(211.203, 542.197, -533.392)}):Play()
   -- TW:Create(Could2, TweenInfo.new(15, Enum.EasingStyle.Linear, Enum.EasingDirection.InOut, -1, true), {Position = Vector3.new(267.366, 547.46, -578.266)}):Play()