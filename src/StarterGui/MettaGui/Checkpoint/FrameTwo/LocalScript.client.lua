_G.PData = game.ReplicatedStorage.Remote.GetDataSave:InvokeServer()

game.ReplicatedStorage.Remote.ClientDataUpdate.OnClientEvent:Connect(function(key, value)
	_G.PData[key] = value
	if key == 'BaseSettings'then
		script.Parent.Items.Text = _G.PData.BaseSettings.Checkpoint
	end
end)


script.Parent.Items.Text = _G.PData.BaseSettings.Checkpoint
