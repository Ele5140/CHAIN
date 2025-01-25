local Players = game:GetService("Players")
local RunService = game:GetService("RunService")
local UIS = game:GetService("UserInputService")

local Bypass = Players.LocalPlayer

local CoreGui = Instance.new("Folder")
CoreGui.Parent = Bypass

local create1 = function(thing, name, color)
	local highlight = Instance.new("Highlight")
	highlight.Adornee = thing
	highlight.Parent = CoreGui
	highlight.Enabled = false
	highlight.FillTransparency = 1
	highlight.OutlineColor = color
	highlight.DepthMode = Enum.HighlightDepthMode.AlwaysOnTop
	highlight.Name = name
end

local Toggle = false
local ChainToggle = false

UIS.InputBegan:Connect(function(input)
	if input.KeyCode ==Enum.KeyCode.P then
		Toggle = not Toggle
	end
	
	if input.KeyCode ==Enum.KeyCode.O then
		ChainToggle = not ChainToggle
	end
end)

for i, player in pairs(Players:GetChildren()) do
	repeat wait() until player.Character
	if not CoreGui:FindFirstChild(player.UserId .. "ESP1") then
		create1(player.Character, (player.UserId .. "ESP1"), Color3.new(1,1,1))
		task.wait()
	end
end

game.Players.PlayerAdded:Connect(function(player)
	repeat wait() until player.Character
	if not CoreGui:FindFirstChild(player.UserId .. "ESP1") then
		create1(player.Character, (player.UserId .. "ESP1"), Color3.new(1,1,1))
	end
end)

game.Players.PlayerRemoving:Connect(function(player)
	CoreGui:FindFirstChild(player.UserId .. "ESP1"):Destroy()
end)

RunService.Heartbeat:Connect(function()
	for i, player in pairs(Players:GetChildren()) do
		repeat wait() until player.Character
		if not CoreGui:FindFirstChild(player.UserId .. "ESP1") then
			create1(player.Character, (player.UserId .. "ESP1"), Color3.new(1,1,1))
			task.wait()
		end

		for i, v in pairs(CoreGui:GetChildren()) do
			if v:IsA("Highlight") and v.Name == (player.UserId .. "ESP1") then
				if player.Character:FindFirstChild("Humanoid") then
					if player.Character:FindFirstChild("Humanoid").Health ~= 0  then
						v.Enabled = Toggle
					else
						v.Enabled = false
					end
				end
			end
		end

		CoreGui:FindFirstChild(player.UserId .. "ESP1").Adornee = player.Character

	end
end)

RunService.Heartbeat:Connect(function()
	if workspace:FindFirstChild("Misc") then
		if workspace.Misc:FindFirstChild("AI") then
			if workspace.Misc.AI:FindFirstChild("CHAIN") then
				local chain = workspace.Misc.AI:FindFirstChild("CHAIN")
				if not CoreGui:FindFirstChild("CHAIN") then
					create1(chain, "CHAIN", Color3.fromRGB(255, 76, 76))
				end
				CoreGui:FindFirstChild("CHAIN").Enabled = ChainToggle
			else
				if CoreGui:FindFirstChild("CHAIN") then
					CoreGui:FindFirstChild("CHAIN"):Destroy()
				end
			end
		end
	end
end)
